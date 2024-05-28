## DOCUMENTACIÓN DE LA API DEL CHATBOT DE PROLOG QUE AYUDA CON LA FORMACIÓN DE NUEVOS HÁBITOOS
> API de chatbot de Prolog que ayuda con la formación de nuevos hábitos.

## Tabla de Contenidos
- [Prerequisitos](#prerequisitos)
- [Instalación](#instalación)
- [API](#api)

## Prerequisitos
- [SWI-Prolog](https://www.swi-prolog.org/Download.html)
- [Python](https://www.python.org/downloads/)

## Instalación
1. Clonar el repositorio ```git clone git@github.com:LimbersMay/chabot-prolog-react-python.git```

2. (Opcional) Crear un entorno virtual de Python
```virtualenv venv```

3. Activar el entorno virtual
```source venv/bin/activate```

4. Instalar las dependencias de Python
```pip install -r requirements.txt```

5. Ejecutar el servidor de Python
```fastapi dev server.py```

Ahora puedes acceder a la API en [http://localhost:8000](http://localhost:8000)

## API
> POST /perfil
- **Descripción**: Procesa los hábitos del usuario y devuelve sugerencias de nuevos hábitos, cambios de malos hábitos o alternativas a los hábitos actuales.
- `Parámetros`:
- **objetivos**: Lista de objetivos del usuario.
- **problemas_salud**: Lista de problemas de salud del usuario.
- **habitos_perjudiciales**: Lista de hábitos perjudiciales del usuario.
- **habitos**: Lista de hábitos del usuario.
- `Respuesta`: Devuelve una lista de hábitos que ayudan a conseguir los objetivos, alternativas a los malos hábitos y alternativas a los hábitos actuales.

> POST /habitos
- **Descripción**: Procesa los hábitos del usuario y devuelve sugerencias de nuevos hábitos.
- `Parámetros`:
- **data**: Lista de hábitos del usuario, pueden ser objetivos, problemas de salud o hábitos perjudiciales.
- `Respuesta`: Devuelve una lista de hábitos que ayudan a conseguir los objetivos.

## Ejemplo de consulta, perfil del usuario
### Request
```js
fetch("http://127.0.0.1:8000/perfil", {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json'
    },
    body: JSON.stringify({
        objetivos: [
            "salud_cardiovascular",
            "resistencia"
        ],
        problemas_salud: [
            "problemas_articulares",
            "problemas_espalda"
        ],
        habitos_perjudiciales: [
            "fumar",
            "consumir_alcohol"
        ],
        habitos: [
            "caminar"
        ]
    })
});
```

### Response
```json
{
    "HabitosConseguirObjetivos": {
        "salud_cardiovascular": [
            {
                "nombre": "caminar",
                "beneficios": "mejorar tu salud general y bienestar"
            }
        ],
        "resistencia": [
            {
                "nombre": "senderismo",
                "beneficios": "fortalecer tus músculos y mejorar tu salud mental"
            }
        ]
    },
    "HabitosAlternativosAMalosHabitos": {
        "fumar": [
            {
                "nombre": "meditar",
                "beneficios": "reducir el estrés y mejorar tu salud mental"
            }
        ],
        "consumir_alcohol": [
            {
                "nombre": "meditar",
                "beneficios": "reducir el estrés y mejorar tu salud mental"
            }
        ]
    },
    "HabitosAlternativosABuenosHabitos": {
        "caminar": [
            {
                "nombre": "yoga",
                "beneficios:": "Puedes considerar yoga como una alternativa a caminar ya que ambas ayudan a flexibilidad"
            }
        ]
    }
}
```

## Ejemplo hábitos individuales, hábitos que ayuden a conseguir objetivos
### Request
```js
fetch("http://127.0.0.1:8000/habitos", {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json'
    },
    body: JSON.stringify({
        data: [
            "salud_cardiovascular",
            "flexibilidad",
        ]
    })
});
```

### Response
```json
{
    "habitos": {
        "salud_cardiovascular": [
            {
                "nombre": "caminar",
                "beneficios": "mejorar tu salud general y bienestar"
            },
            {
                "nombre": "bicicleta",
                "beneficios": "mejorar tu salud general y bienestar"
            }
        ],
        "flexibilidad": [
            {
                "nombre": "yoga",
                "beneficios": "mejorar tu flexibilidad y reducir el estrés"
            }
        ]
    }
}
```

**1. Hábitos para conseguir objetivos**
```json
{
  "habitos": [
    "salud_cardiovascular" -> "caminar",
    "flexibilidad" -> "yoga",
    "resistencia" -> "correr",
    "conocimiento" -> "leer",
    "tonificacion_muscular" -> "nadar",
    "reduccion_estres" -> "meditar",
    "salud_cardiovascular" -> "bicicleta",
    "salud_mental" -> "jardineria",
    "alimentacion_saludable" -> "cocinar",
    "expresion_personal" -> "escribir",
    "coordinacion" -> "baile",
    "creatividad" -> "pintura",
    "habilidad_musical" -> "tocar_guitarra",
    "resistencia" -> "senderismo",
    "creatividad" -> "fotografia",
    "habilidad_artesanal" -> "escultura",
    "paciencia" -> "pesca",
    "creatividad" -> "ceramica",
    "precision" -> "origami",
    "conocimiento_historico" -> "coleccionar_monedas"
  ]
}
```

**2. Hábitos perjudiciales**
```json
{
  "habitos": [
    "fumar",
    "consumir_alcohol",
    "sedentarismo",
    "saltarse_comidas",
    "dormir_poco"
    ]
}
```

**3. Problemas de salud**
```json
{
  "habitos": [
    "problemas_articulares",
    "infecciones_oreja",
    "problemas_espalda",
    "problemas_rodilla",
    "alergia_agua",
    "problemas_pies",
    "hipertension_no_controlada",
    "problemas_rodilla",
    "alergia_polvo",
    "alergia_pintura",
    "depresion_severa",
    "alergia_polen",
    "problemas_vista",
    "artritis_manos",
    "problemas_destreza",
    "alergia_arcilla",
    "problemas_manos",
    "alergia_alimentos",
    "polvo",
    "hipertension_no_controlada"
  ]
}
```
