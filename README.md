# API Visualizer

A tool to visualize and test APIs from OpenAPI specifications.

## Project Structure

```
backend/
  app/
    main.py
    ...
  requirements.txt
  requirements-dev.txt
  ...
frontend/
  src/
    ...
  package.json
  ...
```

---

## Backend

- **Framework:** FastAPI
- **Database:** SQLite (default: `db.sqlite3`)
- **Static uploads:** Served from `/api/uploads`

### Setup

1. **Install dependencies:**

   ```sh
   cd backend
   python -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   ```

2. **Run the server:**

   ```sh
   uvicorn app.main:app --reload
   ```

3. **Testing & Linting:**
   - Run tests:

     ```sh
     pytest
     ```

   - Lint & format:

     ```sh
     ruff .
     ```

---

## Frontend

- **Framework:** React 19 + TypeScript
- **Bundler:** Vite
- **Styling:** Tailwind CSS

### Setup

1. **Install dependencies:**

   ```sh
   cd frontend
   pnpm install
   ```

2. **Run the development server:**

   ```sh
   pnpm dev
   ```

3. **Build for production:**

   ```sh
   pnpm build
   ```

4. **Lint:**

   ```sh
   pnpm lint
   ```

---

## Development Notes

- Uploaded files are stored in `backend/app/uploads` and served at `/api/uploads`.
- The backend database is initialized automatically on startup.
- ESLint and Ruff are configured for code quality in frontend and backend, respectively.

---

## License

MIT
