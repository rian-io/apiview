# 📘 API DocGen – API Documentation Generator

A SaaS tool to visually generate and host documentation from JSON/YAML OpenAPI specs. Built with Swift (Vapor), React 19, and TailwindCSS. Optimized for solo developers and monorepo projects.

---

## 🧱 Tech Stack

- **Backend**: Swift (Vapor), SQLite
- **Frontend**: React 19 + Vite + TailwindCSS
- **Dev Tools**: pnpm, ESLint, Prettier, Vitest, pre-commit
- **Project Layout**: Monorepo

---

## 📁 Project Structure

```
apiview/
├── backend/
│   ├── app/
│   │   ├── main.swift
│   │   └── api/, models/
│   ├── Package.swift
│   └── Tests/
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

- Swift 5.4+ and Vapor
- Node.js 18+
- pnpm (`npm i -g pnpm`)

---

### ✅ Setup

1. Clone the repo:

```bash
git clone https://github.com/your-user/api-docgen.git
cd api-docgen
```

2. Install all dependencies (backend and frontend):

```bash
make install
```

---

### 🧪 Development

To run both backend and frontend in dev mode:

```bash
make dev
```

- Backend: <http://localhost:8080>
- Frontend: <http://localhost:5173>

You can also run them separately:

```bash
make run-backend
make run-frontend
```

---

## 🧪 Testing & Code Quality

- **Run tests** (Vitest):

  ```bash
  make test
  ```

- **Lint backend** (ESLint):

  ```bash
  make lint
  ```

- **Format code** (Prettier):

  ```bash
  make format
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
