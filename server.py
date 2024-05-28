from fastapi import FastAPI
from pydantic import BaseModel

from prolog import procesar_perfil, procesar_habitos_individuales
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

origins = [
    "http://localhost",
    "http://localhost:5173",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def main():
    return {"message": "Hello World"}

class Perfil(BaseModel):
    objetivos: list[str]
    problemas_salud: list[str]
    habitos_perjudiciales: list[str]
    habitos: list[str]

class Habitos(BaseModel):
    data: list[str]

@app.post("/perfil")
async def say_hello(perfil_usuario: Perfil):

    habitos = []
    habitos.extend(perfil_usuario.objetivos)
    habitos.extend(perfil_usuario.problemas_salud)
    habitos.extend(perfil_usuario.habitos_perjudiciales)
    habitos.extend(perfil_usuario.habitos)

    return procesar_habitos(habitos)

@app.post("/habitos")
async def procesarHabitos(habitos: Habitos):
    return procesar_habitos_individuales(habitos.data)
