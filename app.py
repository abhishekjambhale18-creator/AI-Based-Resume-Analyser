import os
import re
import time
from datetime import date, timedelta
from functools import wraps

import mysql.connector
import pdfplumber
from docx import Document as DocxDocument
from flask import (Flask, abort, flash, redirect, render_template, request,
                   session, url_for)
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from werkzeug.security import check_password_hash, generate_password_hash
from werkzeug.utils import secure_filename

import config

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
UPLOAD_FOLDER = os.path.join(BASE_DIR, "uploads")
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

app = Flask(
    __name__,
    static_folder=os.path.join(BASE_DIR, "static"),
    template_folder=os.path.join(BASE_DIR, "templates"),
)
app.secret_key = config.SECRET_KEY
app.config["MAX_CONTENT_LENGTH"] = config.MAX_UPLOAD_MB * 1024 * 1024

# ----------------------------------------------------------------------------
# DATABASE
# ----------------------------------------------------------------------------
DB_CFG = dict(host=config.DB_HOST, port=config.DB_PORT,
              user=config.DB_USER, password=config.DB_PASSWORD)
SCHEMA = [
    """CREATE TABLE IF NOT EXISTS user (
        uid INT(11) AUTO_INCREMENT PRIMARY KEY,
        first_name VARCHAR(50), last_name VARCHAR(50),
        email VARCHAR(100) UNIQUE NOT NULL,
        phone VARCHAR(15),
        password VARCHAR(255) NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP)""",
    """CREATE TABLE IF NOT EXISTS resume (
        rid INT(11) AUTO_INCREMENT PRIMARY KEY,
        uid INT(11) NOT NULL,
        file VARCHAR(255) NOT NULL,
        upload_date DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (uid) REFERENCES user(uid) ON DELETE CASCADE)""",
    """CREATE TABLE IF NOT EXISTS skill (
        sid INT(11) AUTO_INCREMENT PRIMARY KEY,
        rid INT(11) NOT NULL,
        skill VARCHAR(255) NOT NULL,
        FOREIGN KEY (rid) REFERENCES resume(rid) ON DELETE CASCADE)""",
    """CREATE TABLE IF NOT EXISTS jobdesc (
        jid INT(11) AUTO_INCREMENT PRIMARY KEY,
        title VARCHAR(100) NOT NULL,
        company_name VARCHAR(150) NOT NULL,
        req TEXT NOT NULL)""",
    """CREATE TABLE IF NOT EXISTS matchresult (
        mid INT(11) AUTO_INCREMENT PRIMARY KEY,
        rid INT(11) NOT NULL,
        jid INT(11) NOT NULL,
        score FLOAT CHECK (score BETWEEN 0 AND 100),
        status VARCHAR(50) NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (rid) REFERENCES resume(rid) ON DELETE CASCADE,
        FOREIGN KEY (jid) REFERENCES jobdesc(jid) ON DELETE CASCADE)""",
    """CREATE TABLE IF NOT EXISTS feedback (
        fid INT(11) AUTO_INCREMENT PRIMARY KEY,
        uid INT(11) NOT NULL,
        mid INT(11) NULL,
        rating TINYINT, category VARCHAR(50),
        comment TEXT NOT NULL,
        placed_status VARCHAR(20), continue_status VARCHAR(20),
        submitted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (uid) REFERENCES user(uid) ON DELETE CASCADE,
        FOREIGN KEY (mid) REFERENCES matchresult(mid) ON DELETE SET NULL)""",
]

SEED_JOBS = [
    ("Python Developer", "ABC Tech", "python,sql,flask"),
    ("Python Developer", "Infosys", "python,sql,flask,django"),
    ("Java Developer", "TCS", "java,sql"),
    ("Frontend Developer", "Wipro", "html,css,javascript,react"),
    ("Full Stack Developer", "Accenture", "html,css,javascript,python,mysql,flask"),
    ("Machine Learning Engineer", "Google", "python,machine learning,deep learning,tensorflow,pandas,numpy"),
    ("Data Analyst", "Deloitte", "python,sql,pandas,excel,power bi"),
    ("Backend Developer", "Amazon", "python,java,sql,rest api,docker"),
    ("Web Developer", "Capgemini", "html,css,javascript,nodejs"),
    ("Software Engineer", "IBM", "java,python,sql,git"),
    ("Data Scientist", "Fractal", "python,machine learning,data science,sql,scikit-learn"),
    ("DevOps Engineer", "HCL Technologies", "docker,kubernetes,git,aws,linux"),
]


def connect(with_db=True):
    cfg = dict(DB_CFG)
    if with_db:
        cfg["database"] = config.DB_NAME
    return mysql.connector.connect(**cfg)


def q(sql, args=(), one=False, commit=False):
    """Run a query. SELECT -> list/dict, write -> lastrowid."""
    conn = connect()
    try:
        cur = conn.cursor(dictionary=True)
        cur.execute(sql, args)
        if commit:
            conn.commit()
            return cur.lastrowid
        rows = cur.fetchall()
        return (rows[0] if rows else None) if one else rows
    finally:
        conn.close()


def init_db():
    conn = connect(with_db=False)
    cur = conn.cursor()
    cur.execute(f"CREATE DATABASE IF NOT EXISTS `{config.DB_NAME}`")
    conn.commit()
    conn.close()
    conn = connect()
    cur = conn.cursor()
    for stmt in SCHEMA:
        cur.execute(stmt)
    cur.execute("SELECT COUNT(*) FROM jobdesc")
    if cur.fetchone()[0] == 0:
        cur.executemany("INSERT INTO jobdesc (title, company_name, req) VALUES (%s,%s,%s)", SEED_JOBS)
    conn.commit()
    conn.close()


# ----------------------------------------------------------------------------
# NLP: TEXT EXTRACTION + SKILL EXTRACTION
# ----------------------------------------------------------------------------
# canonical skill -> list of aliases searched with word-boundary regex
SKILLS = {
    "python": ["python"], "java": ["java"], "c++": ["c++"], "c": [r"c language", r"c programming"],
    "javascript": ["javascript", r"java script", r"\bjs\b"], "typescript": ["typescript"],
    "html": ["html", "html5"], "css": ["css", "css3"], "bootstrap": ["bootstrap"],
    "react": ["react", r"react\.js", "reactjs"], "angular": ["angular"], "vue": [r"vue\.js", "vuejs"],
    "nodejs": ["nodejs", r"node\.js", r"node js"], "express": ["expressjs", r"express\.js"],
    "flask": ["flask"], "django": ["django"], "fastapi": ["fastapi"], "php": ["php"],
    "sql": ["sql"], "mysql": ["mysql"], "postgresql": ["postgresql", "postgres"],
    "mongodb": ["mongodb"], "sqlite": ["sqlite"], "oracle": ["oracle"],
    "machine learning": ["machine learning", r"\bml\b"], "deep learning": ["deep learning"],
    "data science": ["data science"], "nlp": ["nlp", "natural language processing"],
    "tensorflow": ["tensorflow"], "keras": ["keras"], "pytorch": ["pytorch"],
    "scikit-learn": ["scikit-learn", "sklearn", "scikit learn"],
    "pandas": ["pandas"], "numpy": ["numpy"], "matplotlib": ["matplotlib"],
    "power bi": ["power bi", "powerbi"], "tableau": ["tableau"], "excel": ["excel"],
    "git": ["git", "github"], "docker": ["docker"], "kubernetes": ["kubernetes", "k8s"],
    "aws": ["aws", "amazon web services"], "azure": ["azure"], "linux": ["linux"],
    "rest api": [r"rest api", r"restful", r"rest apis"], "spring boot": ["spring boot", "springboot"],
    "android": ["android"], "kotlin": ["kotlin"], "flutter": ["flutter"],
    "selenium": ["selenium"], "jira": ["jira"], "opencv": ["opencv"],
}
SKILL_PATTERNS = {
    name: re.compile(r"(?<![\w+#])(?:" + "|".join(a if "\\" in a else re.escape(a) for a in aliases) + r")(?![\w+#])")
    for name, aliases in SKILLS.items()
}


def extract_text(path):
    ext = path.rsplit(".", 1)[-1].lower()
    text = ""
    if ext == "pdf":
        with pdfplumber.open(path) as pdf:
            for page in pdf.pages:
                text += (page.extract_text() or "") + "\n"
    elif ext == "docx":
        doc = DocxDocument(path)
        text = "\n".join(p.text for p in doc.paragraphs)
        for table in doc.tables:
            for row in table.rows:
                text += "\n" + " ".join(c.text for c in row.cells)
    return text


def extract_skills(text):
    text = text.lower()
    found = {name for name, pat in SKILL_PATTERNS.items() if pat.search(text)}
    if found & {"mysql", "postgresql", "sqlite", "oracle"}:
        found.add("sql")  # a specific SQL database implies SQL knowledge
    return sorted(found)


def compute_match_score(resume_skills, job_requirements):
    """TF-IDF vectorisation + cosine similarity -> 0..100."""
    if not resume_skills or not job_requirements.strip():
        return 0.0

    def tok(s):
        return [t.strip().lower() for t in s.split(",") if t.strip()]

    vec = TfidfVectorizer(tokenizer=tok, lowercase=False, token_pattern=None)
    m = vec.fit_transform([", ".join(resume_skills), job_requirements])
    return round(float(cosine_similarity(m[0], m[1])[0][0]) * 100, 2)


def match_label(score):
    if score >= 70:
        return "High Match"
    if score >= 40:
        return "Medium Match"
    return "Low Match"


app.jinja_env.globals["match_label"] = match_label


# ----------------------------------------------------------------------------
# AUTH HELPERS
# ----------------------------------------------------------------------------
def login_required(f):
    @wraps(f)
    def wrap(*a, **kw):
        if not session.get("loggedin"):
            return redirect(url_for("login"))
        return f(*a, **kw)
    return wrap


def admin_required(f):
    @wraps(f)
    def wrap(*a, **kw):
        if not session.get("admin"):
            return redirect(url_for("admin_login"))
        return f(*a, **kw)
    return wrap


def status_map():
    """uid -> latest placed / continue status taken from their newest feedback."""
    m = {}
    for f in q("SELECT uid, placed_status, continue_status FROM feedback ORDER BY fid"):
        m[f["uid"]] = {"placed": f["placed_status"], "cont": f["continue_status"]}
    return m


# ----------------------------------------------------------------------------
# USER ROUTES
# ----------------------------------------------------------------------------
@app.route("/")
def index():
    if session.get("admin"):
        return redirect(url_for("admin_dashboard"))
    return redirect(url_for("dashboard" if session.get("loggedin") else "login"))


@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        first = request.form.get("first_name", "").strip()
        last = request.form.get("last_name", "").strip()
        email = request.form.get("email", "").strip().lower()
        phone = request.form.get("phone", "").strip()
        pw = request.form.get("password", "")
        if not first or not re.match(r"^[^@\s]+@[^@\s]+\.[^@\s]+$", email):
            flash("Please enter your name and a valid email.", "error")
        elif len(pw) < 6:
            flash("Password must be at least 6 characters.", "error")
        elif pw != request.form.get("confirm", ""):
            flash("Passwords do not match.", "error")
        elif q("SELECT uid FROM user WHERE email=%s", (email,), one=True):
            flash("Email already registered.", "error")
        else:
            q("INSERT INTO user (first_name,last_name,email,phone,password) VALUES (%s,%s,%s,%s,%s)",
              (first, last, email, phone, generate_password_hash(pw)), commit=True)
            flash("Registration successful. Please login.", "success")
            return redirect(url_for("login"))
    return render_template("register.html")


@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        email = request.form.get("email", "").strip().lower()
        acc = q("SELECT * FROM user WHERE email=%s", (email,), one=True)
        if acc and check_password_hash(acc["password"], request.form.get("password", "")):
            session.clear()
            session.update(loggedin=True, id=acc["uid"], email=acc["email"],
                           name=acc["first_name"] or acc["email"])
            return redirect(url_for("dashboard"))
        flash("Incorrect email or password.", "error")
    return render_template("login.html")


@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("login"))


@app.route("/dashboard")
@login_required
def dashboard():
    resumes = q("""SELECT r.rid, r.file, r.upload_date,
                   (SELECT COUNT(*) FROM skill s WHERE s.rid=r.rid) AS n_skills
                   FROM resume r WHERE r.uid=%s ORDER BY r.rid DESC""", (session["id"],))
    return render_template("dashboard.html", resumes=resumes)


@app.route("/upload_resume", methods=["GET", "POST"])
@login_required
def upload_resume():
    if request.method == "POST":
        file = request.files.get("resume")
        if not file or not file.filename:
            flash("Please choose a resume file.", "error")
            return redirect(url_for("upload_resume"))
        ext = file.filename.rsplit(".", 1)[-1].lower() if "." in file.filename else ""
        if ext not in config.ALLOWED_EXTENSIONS:
            flash("Only PDF and DOCX files are supported.", "error")
            return redirect(url_for("upload_resume"))
        fname = f"{session['id']}_{int(time.time())}_{secure_filename(file.filename)}"
        path = os.path.join(UPLOAD_FOLDER, fname)
        file.save(path)
        try:
            text = extract_text(path)
        except Exception:
            text = ""
        skills = extract_skills(text)
        if not text.strip():
            os.remove(path)
            flash("Could not read any text from this file (scanned image or corrupted).", "error")
            return redirect(url_for("upload_resume"))
        rid = q("INSERT INTO resume (uid, file) VALUES (%s,%s)", (session["id"], fname), commit=True)
        for s in skills:
            q("INSERT INTO skill (rid, skill) VALUES (%s,%s)", (rid, s), commit=True)
        return redirect(url_for("save_resume", rid=rid))
    return render_template("upload_resume.html")


@app.errorhandler(413)
def too_large(_):
    flash(f"File too large. Maximum size is {config.MAX_UPLOAD_MB} MB.", "error")
    return redirect(url_for("upload_resume"))


@app.route("/save_resume")
@login_required
def save_resume():
    rid = request.args.get("rid", type=int)
    resume = q("SELECT * FROM resume WHERE rid=%s AND uid=%s", (rid, session["id"]), one=True)
    if not resume:
        abort(404)
    skills = [r["skill"] for r in q("SELECT skill FROM skill WHERE rid=%s ORDER BY sid", (rid,))]
    jobs = q("SELECT * FROM jobdesc")
    existing = {r["jid"]: r["mid"] for r in q("SELECT mid, jid FROM matchresult WHERE rid=%s", (rid,))}
    results = []
    for job in jobs:
        req = [s.strip().lower() for s in job["req"].split(",") if s.strip()]
        matched = [s for s in req if s in skills]
        missing = [s for s in req if s not in skills]
        score = compute_match_score(skills, job["req"])
        if job["jid"] in existing:
            mid = existing[job["jid"]]
            q("UPDATE matchresult SET score=%s, status=%s WHERE mid=%s",
              (score, "Analyzed", mid), commit=True)
        else:
            mid = q("INSERT INTO matchresult (rid, jid, score, status) VALUES (%s,%s,%s,%s)",
                    (rid, job["jid"], score, "Analyzed"), commit=True)
        results.append(dict(mid=mid, title=job["title"], company=job["company_name"],
                            score=score, matched=matched, missing=missing))
    results.sort(key=lambda r: r["score"], reverse=True)
    best = results[0] if results else None
    return render_template("save_resume.html", resume=resume, skills=skills,
                           results=results, best=best)


@app.route("/submit_feedback", methods=["POST"])
@login_required
def submit_feedback():
    mid = request.form.get("mid", type=int)
    rating = request.form.get("rating", type=int) or 0
    comment = request.form.get("comment", "").strip()
    if not (1 <= rating <= 5) or not comment:
        flash("Please give a star rating and a comment.", "error")
        return redirect(request.referrer or url_for("dashboard"))
    if mid and not q("""SELECT m.mid FROM matchresult m JOIN resume r ON r.rid=m.rid
                        WHERE m.mid=%s AND r.uid=%s""", (mid, session["id"]), one=True):
        mid = None
    q("""INSERT INTO feedback (uid, mid, rating, category, comment, placed_status, continue_status)
         VALUES (%s,%s,%s,%s,%s,%s,%s)""",
      (session["id"], mid, rating, request.form.get("category", "General"), comment,
       request.form.get("placed_status", "Searching"),
       request.form.get("continue_status", "Continuing")), commit=True)
    return redirect(url_for("thankyou"))


@app.route("/thankyou")
@login_required
def thankyou():
    return render_template("thankyou.html")


# ----------------------------------------------------------------------------
# ADMIN ROUTES
# ----------------------------------------------------------------------------
@app.route("/admin_login", methods=["GET", "POST"])
def admin_login():
    if request.method == "POST":
        if (request.form.get("username") == config.ADMIN_USERNAME
                and request.form.get("password") == config.ADMIN_PASSWORD):
            session.clear()
            session["admin"] = True
            return redirect(url_for("admin_dashboard"))
        flash("Invalid admin credentials.", "error")
    return render_template("admin_login.html")


@app.route("/admin_logout")
def admin_logout():
    session.clear()
    return redirect(url_for("admin_login"))


@app.route("/admin_dashboard")
@admin_required
def admin_dashboard():
    c = lambda t: q(f"SELECT COUNT(*) AS n FROM {t}", one=True)["n"]
    return render_template("admin_dashboard.html", users=c("user"), jobs=c("jobdesc"),
                           resumes=c("resume"), feedback=c("feedback"))


@app.route("/user")
@admin_required
def users():
    rows = q("SELECT * FROM user ORDER BY uid DESC")
    st = status_map()
    for r in rows:
        s = st.get(r["uid"])
        r["status"] = "Unknown" if not s else ("Continuing" if s["cont"] == "Continuing" else "No longer active")
    counts = dict(total=len(rows),
                  cont=sum(r["status"] == "Continuing" for r in rows),
                  left=sum(r["status"] == "No longer active" for r in rows),
                  nofb=sum(r["status"] == "Unknown" for r in rows))
    return render_template("users.html", rows=rows, counts=counts)


@app.route("/user/<int:uid>")
@admin_required
def user_view(uid):
    u = q("SELECT * FROM user WHERE uid=%s", (uid,), one=True) or abort(404)
    resumes = q("""SELECT r.*, (SELECT GROUP_CONCAT(skill SEPARATOR ', ') FROM skill s WHERE s.rid=r.rid) AS skills
                   FROM resume r WHERE r.uid=%s ORDER BY r.rid DESC""", (uid,))
    matches = q("""SELECT j.title, j.company_name, MAX(m.score) AS score FROM matchresult m
                   JOIN resume r ON r.rid=m.rid JOIN jobdesc j ON j.jid=m.jid
                   WHERE r.uid=%s GROUP BY j.jid ORDER BY score DESC LIMIT 5""", (uid,))
    fbs = q("SELECT * FROM feedback WHERE uid=%s ORDER BY fid DESC", (uid,))
    return render_template("user_view.html", u=u, resumes=resumes, matches=matches, fbs=fbs)


@app.route("/delete_user/<int:uid>", methods=["POST"])
@admin_required
def delete_user(uid):
    for r in q("SELECT file FROM resume WHERE uid=%s", (uid,)):
        p = os.path.join(UPLOAD_FOLDER, r["file"])
        if os.path.exists(p):
            os.remove(p)
    q("DELETE FROM user WHERE uid=%s", (uid,), commit=True)
    flash("User deleted.", "success")
    return redirect(url_for("users"))


@app.route("/jobs", methods=["GET", "POST"])
@admin_required
def jobs():
    if request.method == "POST":
        t, c, r = (request.form.get(k, "").strip() for k in ("title", "company", "req"))
        if t and c and r:
            r = ",".join(s.strip().lower() for s in r.split(",") if s.strip())
            q("INSERT INTO jobdesc (title, company_name, req) VALUES (%s,%s,%s)", (t, c, r), commit=True)
            flash("Job added.", "success")
        else:
            flash("All fields are required.", "error")
        return redirect(url_for("jobs"))
    return render_template("jobs.html", rows=q("SELECT * FROM jobdesc ORDER BY jid"))


@app.route("/delete_job/<int:jid>", methods=["POST"])
@admin_required
def delete_job(jid):
    q("DELETE FROM jobdesc WHERE jid=%s", (jid,), commit=True)
    flash("Job deleted.", "success")
    return redirect(url_for("jobs"))


@app.route("/admin_feedback")
@admin_required
def admin_feedback():
    rows = q("""SELECT f.*, u.email FROM feedback f JOIN user u ON u.uid=f.uid ORDER BY f.fid""")
    return render_template("admin_feedback.html", rows=rows)


@app.route("/summary_report")
@admin_required
def summary_report():
    users_ = q("SELECT uid FROM user")
    st = status_map()
    total = len(users_)
    placed = sum(1 for u in users_ if st.get(u["uid"], {}).get("placed") == "Placed")
    searching = sum(1 for u in users_ if st.get(u["uid"], {}).get("placed") == "Searching")
    cont = sum(1 for u in users_ if st.get(u["uid"], {}).get("cont") == "Continuing")
    left = sum(1 for u in users_ if st.get(u["uid"], {}).get("cont") == "Left")
    one = lambda s: q(s, one=True)
    resumes = one("SELECT COUNT(*) n FROM resume")["n"]
    jobs_n = one("SELECT COUNT(*) n FROM jobdesc")["n"]
    fb_n = one("SELECT COUNT(*) n FROM feedback")["n"]

    top_skills = q("SELECT skill, COUNT(*) AS freq FROM skill GROUP BY skill ORDER BY freq DESC, skill LIMIT 10")
    dist = one("""SELECT COALESCE(SUM(score>=70),0) hi, COALESCE(SUM(score>=40 AND score<70),0) md,
                  COALESCE(SUM(score<40),0) lo FROM matchresult""")
    job_rows = q("""SELECT j.title, j.company_name, COUNT(m.mid) AS applicants, COALESCE(AVG(m.score),0) AS avg_score
                    FROM jobdesc j LEFT JOIN matchresult m ON m.jid=j.jid GROUP BY j.jid ORDER BY j.jid""")
    avg_rating = one("SELECT COALESCE(AVG(rating),0) a FROM feedback")["a"]
    rating_counts = {r["rating"]: r["c"] for r in q("SELECT rating, COUNT(*) c FROM feedback GROUP BY rating")}
    ratings = [int(rating_counts.get(i, 0)) for i in range(1, 6)]
    recent_fb = q("SELECT f.rating, f.comment, u.email FROM feedback f JOIN user u ON u.uid=f.uid ORDER BY f.fid DESC LIMIT 10")
    activity = q("""SELECT u.uid, u.first_name, u.last_name, u.email,
                    (SELECT COUNT(*) FROM resume r WHERE r.uid=u.uid) AS resumes,
                    (SELECT COUNT(*) FROM feedback f WHERE f.uid=u.uid) AS feedback
                    FROM user u ORDER BY u.uid DESC LIMIT 15""")
    for a in activity:
        s = st.get(a["uid"], {})
        a["cont"], a["placed"] = s.get("cont"), s.get("placed")
    return render_template(
        "summary_report.html", total=total, placed=placed, searching=searching,
        noresp=total - placed - searching, cont=cont, left=left, nofb=total - cont - left,
        resumes=resumes, jobs_n=jobs_n, fb_n=fb_n, top_skills=top_skills,
        dist=[int(dist["hi"]), int(dist["md"]), int(dist["lo"])], job_rows=job_rows,
        avg_rating=round(float(avg_rating), 1), ratings=ratings, recent_fb=recent_fb,
        activity=activity, placement_rate=round(placed / total * 100, 1) if total else 0,
        max_skill=top_skills[0]["freq"] if top_skills else 1)


REPORT_TYPES = {
    "users": "User Registrations", "resumes": "Resume Uploads",
    "matches": "Job Matches", "skills": "Skill Gap / Top Skills", "feedback": "Feedback",
}


def period_summary(kind):
    fmt = {"daily": "%Y-%m-%d", "monthly": "%Y-%m", "yearly": "%Y"}[kind]
    data = {}
    for key, tbl, col in (("users", "user", "created_at"), ("resumes", "resume", "upload_date"),
                          ("feedback", "feedback", "submitted_at")):
        for r in q(f"SELECT DATE_FORMAT({col}, %s) AS p, COUNT(*) AS c FROM {tbl} GROUP BY p", (fmt,)):
            if r["p"]:
                data.setdefault(r["p"], {"users": 0, "resumes": 0, "feedback": 0})[key] = r["c"]
    return [dict(period=p, **v) for p, v in sorted(data.items(), reverse=True)]


@app.route("/date_report")
@admin_required
def date_report():
    today = date.today()
    frm = request.args.get("from") or (today - timedelta(days=30)).isoformat()
    to = request.args.get("to") or today.isoformat()
    rtype = request.args.get("type", "users")
    summary = request.args.get("summary")
    args = (frm, to)

    if rtype == "resumes":
        cols = [("rid", "Resume ID"), ("name", "User"), ("email", "Email"), ("file", "File"),
                ("skills", "Skills"), ("dt", "Uploaded")]
        rows = q("""SELECT r.rid, CONCAT_WS(' ',u.first_name,u.last_name) AS name, u.email, r.file,
                    (SELECT GROUP_CONCAT(skill SEPARATOR ', ') FROM skill s WHERE s.rid=r.rid) AS skills,
                    DATE(r.upload_date) AS dt FROM resume r JOIN user u ON u.uid=r.uid
                    WHERE DATE(r.upload_date) BETWEEN %s AND %s ORDER BY r.upload_date DESC""", args)
    elif rtype == "matches":
        cols = [("name", "User"), ("title", "Job"), ("company_name", "Company"),
                ("score", "Match %"), ("label", "Result"), ("dt", "Date")]
        rows = q("""SELECT CONCAT_WS(' ',u.first_name,u.last_name) AS name, j.title, j.company_name,
                    m.score, DATE(m.created_at) AS dt FROM matchresult m
                    JOIN resume r ON r.rid=m.rid JOIN user u ON u.uid=r.uid JOIN jobdesc j ON j.jid=m.jid
                    WHERE DATE(m.created_at) BETWEEN %s AND %s ORDER BY m.score DESC""", args)
        for r in rows:
            r["label"] = match_label(r["score"])
    elif rtype == "skills":
        cols = [("skill", "Skill"), ("freq", "Resumes"), ("missing_in", "Jobs requiring it")]
        rows = q("""SELECT s.skill, COUNT(*) AS freq FROM skill s JOIN resume r ON r.rid=s.rid
                    WHERE DATE(r.upload_date) BETWEEN %s AND %s GROUP BY s.skill ORDER BY freq DESC""", args)
        jobs_ = q("SELECT req FROM jobdesc")
        for r in rows:
            r["missing_in"] = sum(1 for j in jobs_ if r["skill"] in [x.strip() for x in j["req"].split(",")])
    elif rtype == "feedback":
        cols = [("email", "User"), ("rating", "Rating"), ("category", "Category"),
                ("comment", "Comment"), ("dt", "Date")]
        rows = q("""SELECT u.email, f.rating, f.category, f.comment, DATE(f.submitted_at) AS dt
                    FROM feedback f JOIN user u ON u.uid=f.uid
                    WHERE DATE(f.submitted_at) BETWEEN %s AND %s ORDER BY f.fid DESC""", args)
    else:
        rtype = "users"
        cols = [("uid", "Sr. No"), ("name", "Full Name"), ("email", "Email"), ("phone", "Phone"),
                ("dt", "Registered"), ("resumes", "Resumes"), ("feedback", "Feedback"), ("job", "Job Status")]
        rows = q("""SELECT u.uid, CONCAT_WS(' ',u.first_name,u.last_name) AS name, u.email, u.phone,
                    DATE(u.created_at) AS dt,
                    (SELECT COUNT(*) FROM resume r WHERE r.uid=u.uid) AS resumes,
                    (SELECT COUNT(*) FROM feedback f WHERE f.uid=u.uid) AS feedback
                    FROM user u WHERE DATE(u.created_at) BETWEEN %s AND %s ORDER BY u.uid DESC""", args)
        st = status_map()
        for r in rows:
            r["job"] = st.get(r["uid"], {}).get("placed") or "Pending"

    summary_rows = period_summary(summary) if summary in ("daily", "monthly", "yearly") else None
    return render_template("date_report.html", rows=rows, cols=cols, frm=frm, to=to, rtype=rtype,
                           types=REPORT_TYPES, summary=summary, summary_rows=summary_rows, today=today)


@app.route("/admin/run_migration")
@admin_required
def run_migration():
    """Shows whether every expected column exists (tables are auto-created at startup)."""
    expected = [("user", "first_name"), ("user", "last_name"), ("user", "phone"), ("feedback", "rating"),
                ("feedback", "category"), ("feedback", "placed_status"), ("feedback", "continue_status"),
                ("user", "created_at"), ("resume", "upload_date"), ("feedback", "submitted_at")]
    lines = []
    for t, c in expected:
        ok = q("""SELECT 1 FROM information_schema.columns
                  WHERE table_schema=%s AND table_name=%s AND column_name=%s""",
               (config.DB_NAME, t, c), one=True)
        lines.append(("EXISTS" if ok else "MISSING", f"{t}.{c}"))
    return render_template("migration.html", lines=lines)


if __name__ == "__main__":
    init_db()
    print("\n  Resume Analyzer ready ->  http://127.0.0.1:5000")
    print(f"  Admin login           ->  /admin_login  ({config.ADMIN_USERNAME} / {config.ADMIN_PASSWORD})\n")
    app.run(debug=True)
