from sqlalchemy import create_engine, Column, Integer, String, DateTime
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from datetime import datetime

DATABASE_URL = "sqlite:///./app/db.sqlite3"

engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
SessionLocal = sessionmaker(bind=engine)

Base = declarative_base()


class APIDocument(Base):
    __tablename__ = "api_documents"

    id = Column(Integer, primary_key=True, index=True)
    filename = Column(String, nullable=False)
    slug = Column(String, unique=True, index=True)
    filetype = Column(String, nullable=False)  # json ou yaml
    uploaded_at = Column(DateTime, default=datetime.now)


def init_db():
    Base.metadata.create_all(bind=engine)
