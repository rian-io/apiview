# 📄 API Viewer – Project Specification

## 1. Overview

**API Viwer** is a SaaS application designed to help developers generate and host interactive API documentation from OpenAPI specifications (JSON or YAML). It provides a user-friendly frontend interface and a backend API that handles file uploads, parsing, and rendering.

---

## 2. Goals

- Upload OpenAPI files (.json or .yaml)
- Store uploaded files and extract metadata
- Generate a public link to view interactive documentation
- Support API versioning and health check endpoints
- Clean, responsive frontend using TailwindCSS
- Developer-focused UX with future authentication support

---

## 3. Architecture

```text
Frontend (React 19 + Vite + TailwindCSS)
     |
     |  HTTP (REST)
     v
Backend (Swift Vapor)
     |
     |  SQLite / Local File Storage
     v
File System + DB
```

---

## 4. Tech Stack

### Frontend

- React 19
- Vite
- TailwindCSS
- pnpm

### Backend

- Swift (Vapor)
- SQLite (local database)
- Swift Package Manager

### DevOps & Tooling

- Makefile for unified commands
- pnpm
- ESLint + Prettier + Vitest + Pre-commit

---

## 5. Backend Endpoints

| Method | Endpoint             | Description                         |
|--------|----------------------|-------------------------------------|
| GET    | `/api/v1/health`     | Health check                        |
| POST   | `/api/v1/upload`     | Upload OpenAPI file                 |
| GET    | `/api/v1/view/{slug}`| Render HTML from uploaded file      |
| GET    | `/uploads/{filename}`| Serve static uploaded file          |

---

## 6. Data Model

### APIDocument (Swift Model)

| Field       | Type      | Description                 |
|-------------|-----------|-----------------------------|
| id          | Integer   | Primary key                 |
| filename    | String    | Original uploaded file name |
| slug        | String    | Short unique ID             |
| filetype    | String    | `json` or `yaml`            |
| uploaded_at | DateTime  | Upload timestamp            |

---

## 7. Frontend Pages

- `/` → Home page with upload form
- `/health` → Frontend health UI
- `/view/:slug` → Rendered API documentation viewer

---

## 8. Makefile Commands

| Command        | Description                          |
|----------------|--------------------------------------|
| make install   | Install all dependencies             |
| make dev       | Start both backend and frontend      |
| make test      | Run tests                            |
| make lint      | Lint frontend code                   |
| make format    | Format frontend code                 |
| make clean     | Clear build and temp files           |

---

## 9. Testing

- Unit tests for backend (Swift)
- Endpoint coverage for `/health`, `/upload`, `/view`
- Linting and formatting via pre-commit

---

## 10. Future Features

- User authentication and dashboard
- Persistent cloud file storage (S3, etc.)
- Searchable API doc viewer
- Collaboration features (public/private share)

---

## 11. License

MIT © [Your Name]
