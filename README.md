# 📝 Simple Django Blog App

A clean, lightweight blog application built with **Django 6.0**. Users can browse all published posts on the home page and read individual posts on dedicated detail pages. Content is managed through the built-in Django admin panel.

---

## ✨ Features

- **Home Page** — Lists all blog posts in reverse chronological order with truncated previews
- **Post Detail Page** — Displays the full content of a selected blog post
- **Admin Panel** — Create, edit, and delete posts via Django's built-in admin interface
- **SQLite Database** — Zero-configuration database for local development
- **PostgreSQL Support** — Production-ready PostgreSQL via Docker Compose

---

## 🛠 Tech Stack

| Layer      | Technology                          |
| ---------- | ----------------------------------- |
| Language   | Python 3.13+                        |
| Framework  | Django 6.0.3                        |
| Database   | SQLite 3 (local) / PostgreSQL (prod)|
| Templating | Django Templates                    |
| Styling    | Inline CSS                          |
| Container  | Docker & Docker Compose             |

---

## 📁 Project Structure

```
simple-django-blog-app/
├── blogs/                  # Django project configuration
│   ├── __init__.py
│   ├── asgi.py             # ASGI entry point
│   ├── settings.py         # Project settings (SQLite / PostgreSQL)
│   ├── urls.py             # Root URL configuration
│   └── wsgi.py             # WSGI entry point
│
├── posts/                  # Blog application
│   ├── __init__.py
│   ├── admin.py            # Admin registration for Post model
│   ├── apps.py             # App configuration
│   ├── migrations/         # Database migrations
│   ├── models.py           # Post data model
│   ├── tests.py            # Unit tests
│   ├── urls.py             # App-level URL routes
│   └── views.py            # View functions (index, post detail)
│
├── templates/              # HTML templates
│   ├── index.html          # Home page — lists all posts
│   └── posts.html          # Detail page — single post view
│
├── .dockerignore           # Files excluded from Docker build
├── .gitignore
├── docker-compose.yaml     # Multi-container setup (Django + PostgreSQL)
├── Dockerfile              # Multi-stage Docker image definition
├── manage.py               # Django management script
├── requirements.txt        # Python dependencies
└── README.md
```

---

## 🗄 Database Strategy

| Environment          | Database   | Configuration              |
| -------------------- | ---------- | -------------------------- |
| Local development    | SQLite 3   | Default — no setup needed  |
| Docker Compose       | PostgreSQL | Automatic via env vars     |
| GitLab CI / Production | PostgreSQL | Set `USE_POSTGRES=True`  |

The app uses SQLite by default. When the environment variable `USE_POSTGRES=True` is set (automatically done in `docker-compose.yaml`), it switches to PostgreSQL using `POSTGRES_*` env vars.

---

## 🚀 Getting Started (Local)

### Prerequisites

- **Python 3.13+** installed on your system

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/sumeet217/simple-django-blog-app.git
   cd simple-django-blog-app
   ```

2. **Create and activate a virtual environment**

   ```bash
   python3 -m venv venv
   source venv/bin/activate        # macOS / Linux
   venv\Scripts\activate           # Windows
   ```

3. **Install dependencies**

   ```bash
   pip install -r requirements.txt
   ```

4. **Run database migrations**

   ```bash
   python manage.py migrate
   ```

5. **Create an admin user** _(optional, for managing posts)_

   ```bash
   python manage.py createsuperuser
   ```

6. **Start the development server**

   ```bash
   python manage.py runserver
   ```

7. **Open in your browser**

   ```
   http://127.0.0.1:8000/
   ```

---

## 🐳 Run with Docker Compose (Recommended)

Spins up Django + PostgreSQL together with a single command. Migrations run automatically on startup.

### Prerequisites

- **Docker** and **Docker Compose** installed ([Get Docker](https://docs.docker.com/get-docker/))

### Start the application

```bash
docker compose up --build
```

This will:
- Build the Django image
- Start a PostgreSQL 15 database with a healthcheck
- Run migrations automatically once the database is ready
- Serve the app at **http://localhost:8000/**

### Create an admin user

```bash
docker compose exec web python manage.py createsuperuser
```

### Stop the application

```bash
docker compose down
```

### Useful commands

| Command | Description |
| --- | --- |
| `docker compose up -d` | Start in detached (background) mode |
| `docker compose logs -f web` | Follow Django container logs |
| `docker compose logs -f db` | Follow PostgreSQL logs |
| `docker compose down -v` | Stop and **delete database data** |
| `docker compose exec web python manage.py shell` | Open Django shell |

---

## 🐳 Run with Docker (Standalone — SQLite)

If you only need the Django app without PostgreSQL, you can use Docker directly. This runs with SQLite.

### Build and run

```bash
docker build -t django-blog .
docker run -d -p 8000:8000 --name blog django-blog
```

The app will be available at **http://localhost:8000/**.

### Create an admin user inside the container

```bash
docker exec -it blog python manage.py createsuperuser
```

### Useful commands

| Command | Description |
| --- | --- |
| `docker logs blog` | View container logs |
| `docker stop blog` | Stop the container |
| `docker start blog` | Restart a stopped container |
| `docker rm blog` | Remove the container |
| `docker rmi django-blog` | Remove the image |

---

## 🔗 URL Routes

| Route            | View       | Description                    |
| ---------------- | ---------- | ------------------------------ |
| `/`              | `index`    | Home page — all posts          |
| `/post/<id>`     | `post`     | Detail page — single post      |
| `/admin/`        | _built-in_ | Django admin panel             |

---

## 📦 Data Model

### `Post`

| Field        | Type              | Description                          |
| ------------ | ----------------- | ------------------------------------ |
| `title`      | `CharField(255)`  | Title of the blog post               |
| `body`       | `CharField(1M)`   | Full body content of the post        |
| `created_at` | `DateTimeField`   | Timestamp when the post was created  |

---

## 📄 License

This project is open source and available for personal and educational use.
