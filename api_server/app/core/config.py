import os 
from dotenv import load_dotenv

load_dotenv()


class Settings:
    PROJECT_NAME: str = "Mood App"
    PROJECT_DESCRIPTION: str = "Mood App API"
    PROJECT_VERSION: str = "1.0.0"
    
class DatabaseConfig:
    DATABASE_URL: str = os.getenv("DATABASE_URL")

settings = Settings()