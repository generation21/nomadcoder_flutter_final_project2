from fastapi import APIRouter, Depends, HTTPException, Header, status
from sqlalchemy.orm import Session
from typing import List

from app.schemas import board_schema, base_schema
from app.database import get_db
from app.services.board_service import BoardService

router = APIRouter(
    prefix="/boards",
    tags=["boards"],
    responses={404: {"description": "Not found"}},
)

@router.get("/all", response_model=List[board_schema.Board])
async def get_all_boards(
    skip: int = 0, 
    limit: int = 100, 
    db: Session = Depends(get_db),
):
    boards = BoardService.get_all_boards(db, skip, limit)
    return boards

@router.post("/create", response_model=base_schema.ResponseBase, status_code=status.HTTP_201_CREATED)
async def create_board(
    board: board_schema.BoardCreate, 
    db: Session = Depends(get_db),
    current_user_id: str = Header(...),
):
    """새 아이템을 생성합니다."""
    BoardService.create_board(db, board, current_user_id)
    return base_schema.ResponseBase(message="Board successfully created")

@router.delete("/delete/{board_id}", response_model=base_schema.ResponseBase)
async def delete_board(
    board_id: str,
    db: Session = Depends(get_db),
    current_user_id: str = Header(...),
):
    """특정 보드를 삭제합니다."""
    db_board = BoardService.delete_board(db, board_id, current_user_id)
    if db_board is None:
        raise HTTPException(status_code=404, detail="Board not found")
    
    return base_schema.ResponseBase(message="Board successfully deleted") 

@router.get("/check_owner/{board_id}", response_model = board_schema.ResponseCheckOwner)
async def check_board_owner(
    board_id: str,
    db: Session = Depends(get_db),
    current_user_id: str = Header(...),
):
    is_owner = BoardService.check_board_owner(db, board_id, current_user_id)
    return board_schema.ResponseCheckOwner(is_owner=is_owner) 