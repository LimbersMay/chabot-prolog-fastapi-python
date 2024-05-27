from fastapi import FastAPI
from pydantic import BaseModel

from prolog import procesar_habitos

app = FastAPI()

class Habitos(BaseModel):
    habitos_usuario: list


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.post("/habitos")
async def say_hello(habitos_usuario: Habitos):
    return procesar_habitos(habitos_usuario.habitos_usuario)
