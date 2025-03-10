from sqlalchemy import Column, String, DateTime, ForeignKey, Text
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func

from app.database import Base

class Board(Base):
    __tablename__ = "boards"

    id = Column(String, primary_key=True, index=True)
    mood = Column(String, index=True)
    text = Column(Text)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    owner_id = Column(String, ForeignKey("users.firebase_uid"))
    owner = relationship("User", back_populates="boards")