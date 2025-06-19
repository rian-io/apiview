from fastapi import APIRouter

from app.api import health
from app.api import openapi_upload


v1_prefix = "/api/v1"


router = APIRouter()


router.include_router(health.router, prefix=v1_prefix)
router.include_router(openapi_upload.router, prefix=v1_prefix)
