# --- Base stage ---
FROM python:3.11-slim AS base

WORKDIR /app

# Set env vars
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# --- Dependencies stage ---
FROM base AS builder

# Install build tools and pip tools
RUN apt-get update \
    && apt-get install -y build-essential curl \
    && pip install --upgrade pip setuptools wheel pip-tools

# Copy metadata and install deps
COPY pyproject.toml .
COPY requirements/requirements.txt .
# COPY .env .env

# Export env vars from .env (for Gemfury)
RUN --mount=type=secret,id=env \
    export $(cat /run/secrets/env | grep -v '^#' | xargs) \
    && pip install --extra-index-url \
    "https://${GEMFURY_USERNAME}:${GEMFURY_PASSWORD}@pypi.fury.io/${GEMFURY_USERNAME}/" \
    -r requirements.txt

# --- Final stage ---
FROM base

# COPY --from=builder /usr/local/lib/python3.11 /usr/local/lib/python3.11
COPY --from=builder /usr/local /usr/local
COPY nb2prod_api_service/ /app/app

EXPOSE 8000

CMD [ "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000" ]