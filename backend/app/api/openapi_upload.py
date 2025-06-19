from fastapi import APIRouter
from fastapi import File
from fastapi import HTTPException
from fastapi import UploadFile

from app.models.database import APIDocument
from app.models.database import SessionLocal

import shutil
import uuid


router = APIRouter()


@router.post("/upload", tags=["Upload"])
async def upload_api_doc(file: UploadFile = File(...)):
    filename = file.filename
    if not filename:
        raise HTTPException(status_code=400, detail="No file provided.")

    ext = filename.split(".")[-1].lower()
    if ext not in ["json", "yaml", "yml"]:
        raise HTTPException(
            status_code=400, detail="Only JSON or YAML files are accepted."
        )

    slug = str(uuid.uuid4())[:8]
    save_path = f"app/uploads/{slug}.{ext}"

    with open(save_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    db = SessionLocal()
    doc = APIDocument(
        filename=file.filename,
        slug=slug,
        filetype=ext,
    )
    db.add(doc)
    db.commit()
    db.refresh(doc)
    db.close()

    return {"slug": slug, "url": f"api/uploads/{slug}.{ext}"}
