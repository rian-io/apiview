# Unified Makefile (runs from root of the project)
# For React frontend in frontend/ and Vapor (Swift) backend in backend-swift/

.PHONY: install install-backend install-frontend build-backend build-frontend run-backend run-frontend dev clean

## Setup

install: install-backend install-frontend
	@echo "✅ All dependencies installed."

install-backend:
	cd backend && swift package resolve

install-frontend:
	cd frontend && pnpm install

## Build

build-backend:
	cd backend && swift build -c release

build-frontend:
	cd frontend && pnpm build

## Run

run-backend:
	cd backend && swift run

run-frontend:
	cd frontend && pnpm dev

dev:
	@echo "🚀 Starting both backend and frontend..."
	# Start frontend in background
	cd frontend && pnpm dev &
	# Start backend
	cd backend && swift run

## Utilities

clean:
	cd backend && swift package clean
	cd frontend && pnpm clean || true
	find . -type d -name "node_modules" -exec rm -rf {} +
	@echo "🧹 Cleaned Swift, Node, and build artifacts."
