# 📘 API DocGen – API Documentation Generator

A SaaS tool to visually generate and host documentation from JSON/YAML OpenAPI specs. Built with FastAPI, React 19, and TailwindCSS. Optimized for solo developers and monorepo projects.

---

## 🧱 Tech Stack

- **Backend**: FastAPI, Uvicorn, SQLite
- **Frontend**: React 19 + Vite + TailwindCSS
- **Environment**: Conda (`web`)
- **Dev Tools**: pnpm, Ruff, Black, Pytest, pre-commit
- **Project Layout**: Monorepo

---

## 📁 Project Structure

```
apiview/
├── backend/
│   ├── app/
│   │   ├── main.py
│   │   └── api/, models/
│   ├── requirements.txt
│   ├── requirements-dev.txt
│   └── tests/
├── frontend/
│   ├── src/
│   ├── package.json
│   ├── vite.config.ts
│   └── tailwind.config.js
├── Makefile
└── README.md
```

---

## 🚀 Getting Started

### 🔧 Prerequisites

- Python 3.10+ and Conda
- Node.js 18+
- pnpm (`npm i -g pnpm`)

---

### ✅ Setup

1. Clone the repo:

```bash
git clone https://github.com/your-user/api-docgen.git
cd api-docgen
```

2. Create and activate the Conda environment:

```bash
conda create -n web python=3.10
conda activate web
```

3. Install all dependencies (backend and frontend):

```bash
make install
```

---

### 🧪 Development

To run both backend and frontend in dev mode:

```bash
make dev
```

- Backend: <http://localhost:8000>
- Frontend: <http://localhost:5173>

You can also run them separately:

```bash
make run-backend
make run-frontend
```

---

## 🧪 Testing & Code Quality

- **Run tests** (Pytest):

  ```bash
  make test
  ```

- **Lint backend** (Ruff):

  ```bash
  make lint
  ```

- **Format code** (Black):

  ```bash
  make format
  ```

---

### 🪝 Pre-commit Hooks

Install pre-commit hooks to auto-format and lint before commits:

```bash
pre-commit install
pre-commit run --all-files
```

---

## 🏗️ Building Frontend

To build the frontend for production:

```bash
cd frontend
pnpm build
```

Static files will be in `frontend/dist`.

---

## 🧹 Cleaning

Remove cache and Python bytecode:

```bash
make clean
```

---

## 📌 Status

🚧 MVP in development: file upload, spec parsing, live preview & public sharing.

---

## 📄 License

MIT © [Rian I. de Oliveira](https://github.com/rian-io)
