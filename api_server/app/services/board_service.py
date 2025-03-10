from datetime import datetime, timezone
from sqlalchemy.orm import Session
from typing import List, Optional
import uuid

from app.models import Board
from app.schemas import board_schema

class BoardService:
    @staticmethod
    def get_all_boards(db: Session, skip: int = 0, limit: int = 100) -> List[Board]:
        boards = db.query(Board).offset(skip).limit(limit).all()
        result = []
        
        for board in boards:
            board_dict = {
                "id": str(board.id),
                "mood": board.mood,
                "text": board.text,
                "created_at": board.created_at,
                "owner_id": board.owner_id
            }
            
            now = datetime.now(timezone.utc)
            time_diff = now - board.created_at
            seconds = time_diff.total_seconds()
            
            if seconds < 60:
                board_dict["relative_time"] = f"{int(seconds)} seconds ago"
            elif seconds < 3600:
                board_dict["relative_time"] = f"{int(seconds // 60)} minutes ago"
            elif seconds < 86400:
                board_dict["relative_time"] = f"{int(seconds // 3600)} hours ago"
            elif seconds < 2592000:
                board_dict["relative_time"] = f"{int(seconds // 86400)} days ago"
            elif seconds < 31536000:
                board_dict["relative_time"] = f"{int(seconds // 2592000)} months ago"
            else:
                board_dict["relative_time"] = f"{int(seconds // 31536000)} years ago"
                
            result.append(board_dict)
        return result
    
    @staticmethod
    def create_board(db: Session, board: board_schema.BoardCreate, owner_id: int) -> Board:
        db_board = Board(id=str(uuid.uuid4()), **board.dict(), owner_id=owner_id)
        
        db.add(db_board)
        db.commit()
        db.refresh(db_board)
        return db_board
    
    @staticmethod
    def delete_board(db: Session, board_id: str, owner_id: int) -> Optional[Board]:
        db_board = db.query(Board).filter(
            Board.id == board_id, 
            Board.owner_id == owner_id
        ).first()
        
        if db_board:
            db.delete(db_board)
            db.commit()
            
        return db_board 
    
    @staticmethod
    def check_board_owner(db: Session, board_id: str, owner_id: int) -> bool:
        db_board = db.query(Board).filter(
            Board.id == board_id, 
            Board.owner_id == owner_id
        ).first()
        return db_board is not None