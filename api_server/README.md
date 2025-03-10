# Flutter Firebase Auth FastAPI 백엔드

이 프로젝트는 Flutter 앱에서 Firebase 인증을 사용하여 사용자 ID를 받아 FastAPI 백엔드와 연동하는 서버 애플리케이션입니다. PostgreSQL 데이터베이스를 사용하여 사용자 정보와 관련 데이터를 저장합니다.

## 기능

- Firebase 인증 토큰 검증
- 사용자 정보 관리 (조회, 수정)
- 사용자별 아이템 관리 (생성, 조회, 수정, 삭제)

## 기술 스택

- FastAPI: 고성능 Python API 프레임워크
- SQLAlchemy: ORM(Object-Relational Mapping)
- PostgreSQL: 관계형 데이터베이스
- Firebase Admin SDK: 인증 토큰 검증
- Pydantic: 데이터 유효성 검사 및 설정 관리

## 시작하기

### 전제 조건

- Python 3.7+
- PostgreSQL
- Firebase 프로젝트

### 설치

1. 저장소를 클론합니다:

```bash
git clone <repository-url>
cd <repository-directory>
```

2. 가상 환경을 생성하고 활성화합니다:

```bash
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
```

3. 필요한 패키지를 설치합니다:

```bash
pip install -r requirements.txt
```

4. 환경 변수를 설정합니다:

`.env` 파일을 프로젝트 루트에 생성하고 다음 값을 설정합니다:

```
DATABASE_URL=postgresql://username:password@localhost:5432/dbname
SECRET_KEY=your_secret_key_here
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
FIREBASE_CREDENTIALS_PATH=path/to/firebase-credentials.json
```

5. Firebase 관리자 SDK 설정:

Firebase 프로젝트 설정에서 서비스 계정 키를 다운로드하여 `firebase-credentials.json` 파일로 저장합니다.

### 데이터베이스 설정

PostgreSQL 데이터베이스를 생성합니다:

```bash
createdb dbname
```

### 실행

```bash
uvicorn app.main:app --reload
```

서버는 기본적으로 http://localhost:8000 에서 실행됩니다.

## API 문서

FastAPI는 자동으로 API 문서를 생성합니다. 다음 URL에서 접근할 수 있습니다:

- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

## Flutter 앱 연동

Flutter 앱에서 Firebase 인증을 사용하여 ID 토큰을 얻은 후, 이 토큰을 API 요청의 인증 헤더에 포함시켜 요청합니다:

```dart
final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
final response = await http.get(
  Uri.parse('http://localhost:8000/users/me'),
  headers: {
    'Authorization': 'Bearer $idToken',
  },
);
```

## 라이센스

이 프로젝트는 MIT 라이센스 하에 배포됩니다. 