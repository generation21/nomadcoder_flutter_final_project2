from fastapi import FastAPI, Depends, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
import uvicorn

from app.models import user_model

from app.schemas import base_schema
from app.database import engine
from app.api import users_router, board_router
from app.core.config import settings
# 데이터베이스 테이블 생성
user_model.Base.metadata.create_all(bind=engine)

app = FastAPI(
    title=settings.PROJECT_NAME,
    description=settings.PROJECT_DESCRIPTION,
    version=settings.PROJECT_VERSION
)

# CORS 설정
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 실제 환경에서는 특정 도메인만 허용하는 것이 좋습니다
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 전역 예외 처리
@app.exception_handler(Exception)
async def global_exception_handler(request: Request, exc: Exception):
    return JSONResponse(
        status_code=500,
        content=base_schema.ErrorResponse(
            success=False,
            message=f"Internal server error: {str(exc)}",
        ).dict(),
    )

# 건강 체크 엔드포인트
@app.get("/health", response_model=base_schema.ResponseBase)
async def health_check():
    return base_schema.ResponseBase(message="API is running")

# API 라우터 등록
app.include_router(users_router)
app.include_router(board_router)
# 애플리케이션 실행
if __name__ == "__main__":
    uvicorn.run("app.main:app", host="0.0.0.0", port=8000, reload=True) 