# ---------- Stage 1: Base ----------
FROM python:3.13-slim AS base

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app 

# ---------- Stage 2: Dependencies ----------
FROM base AS deps

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ---------- Stage 3: Application ----------
FROM deps AS app

COPY . .

# Static files (safe)
RUN python manage.py collectstatic --noinput 2>/dev/null || true

EXPOSE 8000

# Default command (docker-compose overrides this with migrate + runserver)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]