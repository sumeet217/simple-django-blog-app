# ---------- Stage 1: Base ----------
FROM python:3.13-slim AS base

# Prevent Python from writing .pyc files and enable unbuffered output
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app 

# ---------- Stage 2: Dependencies ----------
FROM base AS deps

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ---------- Stage 3: Application ----------
FROM deps AS app

# Copy project source code
COPY . .

# Collect static files (no input required)
RUN python manage.py collectstatic --noinput 2>/dev/null || true

# Run migrations at build time (SQLite is bundled with the image)
RUN python manage.py migrate --noinput

# Expose Django's default development port
EXPOSE 8000

# Start the development server, listening on all interfaces
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
