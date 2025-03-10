from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List

from ..models import user_model

from ..schemas import user_schema
from ..database import get_db

router = APIRouter(
    prefix="/users",
    tags=["users"],
    responses={404: {"description": "Not found"}},
)

@router.get("/{user_id}", response_model=user_schema.User)
async def read_user(
    user_id: int, 
    db: Session = Depends(get_db),
    
):
    db_user = db.query(user_model.User).filter(user_model.User.id == user_id).first()
    if db_user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return db_user


@router.post("/create", response_model=user_schema.User)
async def create_user(
    user: user_schema.UserCreate,
    db: Session = Depends(get_db),
):
    db_user = user_model.User(
        firebase_uid=user.firebase_uid,
        email=user.email,
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    
    print(db_user.__dict__)
    
    return db_user