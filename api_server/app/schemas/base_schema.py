from pydantic import BaseModel
from typing import Optional

# 일반 응답 스키마
class ResponseBase(BaseModel):
    success: bool = True
    message: str = "Operation completed successfully"

# 오류 응답 스키마
class ErrorResponse(ResponseBase):
    success: bool = False
    message: str
    error_code: Optional[str] = None 