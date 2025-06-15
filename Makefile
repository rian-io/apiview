# Unified Makefile (runs from root of the project)
# Assumes Conda env: web, FastAPI backend in backend/, React frontend in frontend/

ENV_NAME=web

.PHONY: create-conda-env install install-backend install-frontend dev run-backend run-frontend lint test format clean

## Setup

create-conda-env:
	@echo "🔧 Creating Conda environment..."
	conda create -n $(ENV_NAME) python=3.11 -y
	@echo "✅ Conda environment '$(ENV_NAME)' created."

install: install-backend install-frontend
	@echo "✅ All dependencies installed."

install-backend:
	conda run -n $(ENV_NAME) pip install -r backend/requirements.txt

install-frontend:
	cd frontend && pnpm install

## Run

run-backend:
	cd backend && conda run -n $(ENV_NAME) uvicorn app.main:app --reload --log-level debug

run-frontend:
	cd frontend && pnpm dev

dev:
	@echo "🚀 Starting both backend and frontend..."
	# Start frontend in background
	cd frontend && conda run -n $(ENV_NAME) pnpm dev &
	# Start backend with correct path
	cd backend && conda run -n $(ENV_NAME) uvicorn app.main:app --reload

## Quality

lint:
	conda run -n $(ENV_NAME) ruff backend

format:
	conda run -n $(ENV_NAME) black backend

test:
	conda run -n $(ENV_NAME) pytest backend/tests

## Utilities

clean:
	find . -type d -name "__pycache__" -exec rm -r {} +
	find . -type d -name ".pytest_cache" -exec rm -r {} +
	@echo "🧹 Cache and pycache cleaned."
