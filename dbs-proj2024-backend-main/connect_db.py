import os
from dotenv import load_dotenv
import psycopg2

# Load environment variables from .env
load_dotenv()

def get_connection():       #fn to connect to db
    url = os.environ.get('DB_URL')
    connection = psycopg2.connect(url)
    return connection

# Optional test
if __name__ == "__main__":
    try:
        conn = get_connection()
        print(" Connected to Neon DB")
        conn.close()
    except Exception as e:
        print(" Failed to connect:", e)
