# nb2prod-api-service

REST API for `nb2prod`, built with FastAPI.

## 🔧 Setup Environment Variables

Create a `.env` file by copying the example:

```bash
cp .env.example .env
```

## Run
```bash
uvicorn nb2prod_api_service.main:app --reload
```

## Test
```bash
pytest
```
