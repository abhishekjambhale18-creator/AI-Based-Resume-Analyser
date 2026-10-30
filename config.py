"""Edit these values (or set environment variables) before running."""
import os

DB_HOST = os.getenv("DB_HOST", "localhost")
DB_PORT = int(os.getenv("DB_PORT", "3306"))
DB_USER = os.getenv("DB_USER", "root")
DB_PASSWORD = os.getenv("DB_PASSWORD", "12345")          # <-- put your MySQL root password here
DB_NAME = os.getenv("DB_NAME", "resume_analyzer")   # created automatically

SECRET_KEY = os.getenv("SECRET_KEY", "change-this-secret-key")
ADMIN_USERNAME = os.getenv("ADMIN_USERNAME", "admin")
ADMIN_PASSWORD = os.getenv("ADMIN_PASSWORD", "admin123")

MAX_UPLOAD_MB = 5
ALLOWED_EXTENSIONS = {"pdf", "docx"}
