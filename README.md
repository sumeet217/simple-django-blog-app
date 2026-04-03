# Django Blog Project

A simple blog application built with Django where users can browse all posts on the home page and open each post on its own detail page.

## Features

- View all blog posts on the home page
- Open a single blog post by ID
- Access Django admin at `/admin/`
- Use SQLite for local development

## Tech Stack

- Python
- Django 6.0.2
- SQLite
- HTML and CSS

## App Overview

- `posts` contains the blog model, views, URLs, and admin registration area.
- `blogs` contains the main project settings and root URL configuration.

## Project Structure

```text
.
├── blogs/          # Project settings and root URL configuration
├── posts/          # Blog app with models, views, and routes
├── templates/      # HTML templates
├── manage.py
├── README.md
└── requirements.txt
```

## Setup

1. Create and activate a virtual environment

```bash
python3 -m venv venv
source venv/bin/activate
```

2. Install dependencies

```bash
pip install -r requirements.txt
```

3. Apply migrations

```bash
python manage.py migrate
```

4. Run the development server

```bash
python manage.py runserver
```

5. Open the project in your browser

```text
http://127.0.0.1:8000/
```

## Routes

| Route | Description |
| --- | --- |
| `/` | Display all blog posts |
| `/post/<id>` | Display a single blog post |
| `/admin/` | Open the Django admin panel |

## Data Model

The `Post` model includes:

- `title`
- `body`
- `created_at`

## Notes

- The project uses `db.sqlite3` for local development.
- You can create an admin user with `python manage.py createsuperuser`.
