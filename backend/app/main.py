from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles

from app.api.routes import router
from app.models.database import init_db

import os

app = FastAPI(
    title="API Visualizer",
    description="A tool to visualize and test APIs from OpenAPI specifications",
)

# Cria pasta de uploads se não existir
os.makedirs("app/uploads", exist_ok=True)

# Inicializa o banco de dados
init_db()

# Rota de upload
app.include_router(router)

# Servir arquivos enviados
app.mount("/api/uploads", StaticFiles(directory="app/uploads"), name="uploads")
