# AI Based Resume Analyser (Resume Analyzer Pro)

Flask + MySQL + TF-IDF/Cosine-Similarity resume-to-job matching.
Frontend: HTML5, CSS3, JavaScript. Backend: Python (Flask).

## Run (Windows / Linux / macOS)
1. Install **Python 3.11+** and **MySQL 8** (make sure the MySQL server is running).
2. Open `config.py` and set `DB_PASSWORD` to your MySQL root password.
3. In this folder:
   ```
   pip install -r requirements.txt
   python app.py
   ```
4. Open http://127.0.0.1:5000

The database `resume_analyzer`, all 6 tables and 12 sample jobs are created automatically on first start.

## Logins
- User: click **Register**, then log in.
- Admin: http://127.0.0.1:5000/admin_login  ->  `admin` / `admin123` (change in `config.py`)

## Pages
User: /login /register /dashboard /upload_resume /save_resume /thankyou
Admin: /admin_login /admin_dashboard /user /jobs /admin_feedback /summary_report /date_report /admin/run_migration

## Notes
- Charts use Chart.js from a CDN, so an internet connection is needed to see them.
- Passwords are stored hashed (werkzeug), so `user.password` is VARCHAR(255).
- Optional manual schema: `database.sql`.
