from pydantic import BaseModel
from typing import Optional
from datetime import datetime


class BoardCreate(BaseModel):
    mood: str
    text: str

class Board(BoardCreate):
    id: str
    relative_time: Optional[str] = "just now"
    
    class Config:
        from_attributes = True


        
class ResponseCheckOwner(BaseModel):
    is_owner: bool
    
    class Config:
        from_attributes = True