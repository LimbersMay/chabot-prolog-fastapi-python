from swiplserver import PrologMQI, create_posix_path
import json

# Función para transformar los resultados en el formato específico
def transformar_resultado(result):
    response = {
        "HabitosConseguirObjetivos": {},
        "HabitosAlternativosAMalosHabitos": {},
        "HabitosAlternativosABuenosHabitos": {}
    }

    # Función auxiliar para evitar duplicados
    def agregar_sin_duplicados(diccionario, clave, entrada):
        if clave not in diccionario:
            diccionario[clave] = []
        if entrada not in diccionario[clave]:
            diccionario[clave].append(entrada)

    # Procesar las sugerencias de nuevos hábitos
    for sugerencia in result[0]['SugerenciaNuevosHabitos']:
        aspecto, habito, beneficio = sugerencia['args'][0]['args'][0], sugerencia['args'][0]['args'][1], sugerencia['args'][1]
        entrada = {"nombre": habito, "beneficios": beneficio}
        agregar_sin_duplicados(response["HabitosConseguirObjetivos"], aspecto, entrada)

    # Procesar las sugerencias de alternativas a hábitos perjudiciales
    for sugerencia in result[0]['SugerenciaAlternativaHabitosPerjudiciales']:
        habito_malo, alternativa, beneficio = sugerencia['args'][0]['args'][0], sugerencia['args'][0]['args'][1], sugerencia['args'][1]
        entrada = {"nombre": alternativa, "beneficios": beneficio}
        agregar_sin_duplicados(response["HabitosAlternativosAMalosHabitos"], habito_malo, entrada)

    # Procesar las sugerencias de hábitos alternativos
    for sugerencia in result[0]['SugerenciaAlternativaHabitos']:
        habito_actual, alternativa, beneficio = sugerencia['args'][0]['args'][0], sugerencia['args'][0]['args'][1], sugerencia['args'][1]
        entrada = {"nombre": alternativa, "beneficios": f"Puedes considerar {alternativa} como una alternativa a {habito_actual} ya que ambas ayudan a {beneficio}"}
        agregar_sin_duplicados(response["HabitosAlternativosABuenosHabitos"], habito_actual, entrada)

    return response

def procesar_habitos(habitos_usuario):

    with PrologMQI() as mqi:
        with mqi.create_thread() as prolog:
            path = create_posix_path("relaciones.pl")
            prolog.query(f'consult("{path}").')
            
            # Consultamos a Prolog para obtener sugerencias
            result = prolog.query(f"obtener_sugerencias_lista({habitos_usuario}, {habitos_usuario}, SugerenciaNuevosHabitos, SugerenciaAlternativaHabitosPerjudiciales, SugerenciaAlternativaHabitos)")

            if result:
                response = transformar_resultado(result)
                return response
            else:
                print("No se encontraron sugerencias.")

            prolog.stop_query()
