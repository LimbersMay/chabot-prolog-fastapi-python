from fastapi import FastAPI
from pydantic import BaseModel

from prolog import procesar_habitos

app = FastAPI()

class Habitos(BaseModel):
    objetivos: list[str]
    problemas_salud: list[str]
    habitos_perjudiciales: list[str]
    habitos: list[str]


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.post("/habitos")
async def say_hello(habitos_usuario: Habitos):

    habitos = []
    habitos.extend(habitos_usuario.objetivos)
    habitos.extend(habitos_usuario.problemas_salud)
    habitos.extend(habitos_usuario.habitos_perjudiciales)
    habitos.extend(habitos_usuario.habitos)

    return procesar_habitos(habitos)
