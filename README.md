# 📘 API DocGen – API Documentation Generator

A SaaS tool to automatically and visually generate API documentation from JSON/YAML OpenAPI specs, with an integrated playground and local storage.

---

## 🧱 Stack

- **Backend**: [FastAPI](https://fastapi.tiangolo.com/)
- **Frontend**: [React 19](https://react.dev/) + [TailwindCSS](https://tailwindcss.com/)
- **Bundler**: [Vite](https://vitejs.dev/)
- **Linter**: [Ruff](https://docs.astral.sh/ruff/), [ESLint](https://eslint.org/)
- **Formatter**: [Black](https://black.readthedocs.io/)
- **Hooks**: [pre-commit](https://pre-commit.com/)
- **Tests**: [Pytest](https://docs.pytest.org/)
- **Environment Management**: Conda (env `web`)

---

## 📁 Project Structure

```
apiview/
├── backend/
│   ├── app/
│   │   ├── main.py
│   │   └── ...
│   ├── requirements.txt
│   └── requirements-dev.txt
├── frontend/
│   ├── index.html
│   ├── tailwind.config.js
│   ├── package.json
│   └── src/
├── Makefile
└── README.md
```

---

## 🚀 Getting Started Locally

### 🔧 Prerequisites

- Python 3.10+
- Conda
- Node.js 18+
- pnpm

### 🐍 Backend (FastAPI)

1. Create the environment:

   ```bash
   conda create -n web python=3.10
   conda activate web
   ```

2. Install dependencies:

   ```bash
   make install
   ```

3. Start the backend:

   ```bash
   make run-backend
   ```

4. Run tests and linting:

   ```bash
   make test
   make lint
   ```

### ⚛️ Frontend (React + Vite)

1. Install dependencies:

   ```bash
   cd frontend
   pnpm install
   ```

2. Run the dev server:

   ```bash
   pnpm dev
   ```

3. Build for production:

   ```bash
   pnpm build
   ```

4. Lint:

   ```bash
   pnpm lint
   ```

---

## 🔄 Unified Dev Command

To run both frontend and backend together:

```bash
make dev
```

Make sure you’ve run `make install` first and your Conda environment (`web`) is activated or accessible.

---

## 🧪 Tests & Quality

- **Backend**: Pytest + Ruff + Black + pre-commit
- **Frontend**: ESLint + TypeScript checks + Tailwind CSS

Install pre-commit hooks:

```bash
pre-commit install
pre-commit run --all-files
```

---

## 📦 Production

- Backend: Serve via Uvicorn/Gunicorn or container
- Frontend: Static files in `frontend/dist/`

---

## 📌 Status

🚧 MVP in development. JSON/YAML OpenAPI file upload and interactive doc viewer underway.

---

## 📄 License

MIT © [Your Name](https://github.com/your-user)
