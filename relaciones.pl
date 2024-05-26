% Base de conocimientos predefinida

% Es bueno para
es_bueno_para(salud_cardiovascular, caminar).
es_bueno_para(flexibilidad, yoga).
es_bueno_para(resistencia, correr).
es_bueno_para(conocimiento, leer).
es_bueno_para(tonificacion_muscular, nadar).
es_bueno_para(reduccion_estres, meditar).
es_bueno_para(salud_cardiovascular, bicicleta).
es_bueno_para(salud_mental, jardineria).
es_bueno_para(alimentacion_saludable, cocinar).
es_bueno_para(expresion_personal, escribir).
es_bueno_para(coordinacion, baile).
es_bueno_para(creatividad, pintura).
es_bueno_para(habilidad_musical, tocar_guitarra).
es_bueno_para(resistencia, senderismo).
es_bueno_para(creatividad, fotografia).
es_bueno_para(habilidad_artesanal, escultura).
es_bueno_para(paciencia, pesca).
es_bueno_para(creatividad, ceramica).
es_bueno_para(precision, origami).
es_bueno_para(conocimiento_historico, coleccionar_monedas).

% Hábitos y sus contraindicaciones
es_contraindicativo_para(correr, problemas_articulares).
es_contraindicativo_para(nadar, infecciones_oreja).
es_contraindicativo_para(bicicleta, problemas_espalda).
es_contraindicativo_para(senderismo, problemas_rodilla).
es_contraindicativo_para(pesca, alergia_agua).
es_contraindicativo_para(caminar, problemas_pies).
es_contraindicativo_para(yoga, hipertension_no_controlada).
es_contraindicativo_para(baile, problemas_rodilla).
es_contraindicativo_para(escultura, alergia_polvo).
es_contraindicativo_para(pintura, alergia_pintura).
es_contraindicativo_para(meditar, depresion_severa).
es_contraindicativo_para(jardineria, alergia_polen).
es_contraindicativo_para(fotografia, problemas_vista).
es_contraindicativo_para(tocar_guitarra, artritis_manos).
es_contraindicativo_para(origami, problemas_destreza).
es_contraindicativo_para(ceramica, alergia_arcilla).
es_contraindicativo_para(escribir, problemas_manos).
es_contraindicativo_para(cocinar, alergia_alimentos).
es_contraindicativo_para(coleccionar_monedas, polvo).
es_contraindicativo_para(andar_bicicleta, hipertension_no_controlada).

% Hábitos y sus alternativas
alternativa_habito(correr, caminar).
alternativa_habito(nadar, bicicleta).
alternativa_habito(bicicleta, caminar).
alternativa_habito(senderismo, caminar).
alternativa_habito(pesca, jardineria).
alternativa_habito(caminar, yoga).
alternativa_habito(yoga, meditar).
alternativa_habito(baile, caminar).
alternativa_habito(escultura, pintura).
alternativa_habito(pintura, escribir).
alternativa_habito(meditar, yoga).
alternativa_habito(jardineria, pescar).
alternativa_habito(fotografia, pintura).
alternativa_habito(tocar_guitarra, escribir).
alternativa_habito(origami, ceramica).
alternativa_habito(ceramica, escultura).
alternativa_habito(escribir, leer).
alternativa_habito(cocinar, jardineria).
alternativa_habito(coleccionar_monedas, leer).
alternativa_habito(correr, nadar).

alternativa_habito_malo(fumar, meditar).
alternativa_habito_malo(consumir_alcohol, meditar).
alternativa_habito_malo(sedentarismo, caminar).
alternativa_habito_malo(saltarse_comidas, comer_saludable).
alternativa_habito_malo(dormir_poco, dormir_bien).

% Reglas para sugerir nuevos hábitos y alternativas
sugerir_nuevo_habito(AspectoMejorar, HabitosUsuario, NuevoHabito) :-
    es_bueno_para(AspectoMejorar, NuevoHabito),
    \+ (member(Problema, HabitosUsuario), es_contraindicativo_para(NuevoHabito, Problema)),
    format('Si quieres mejorar en el aspecto de ~w, entonces te sugiero considerar: ~w.~n', [AspectoMejorar, NuevoHabito]).

sugerir_contraindicacion(HabitoActual, HabitosUsuario, AlternativaHabitoPerjudicial) :-
    alternativa_habito_malo(HabitoActual, AlternativaHabitoPerjudicial),
    \+ (member(Problema, HabitosUsuario), es_contraindicativo_para(AlternativaHabitoPerjudicial, Problema)),
    format('Sugiero ~w como alternativa más saludable a ~w.~n', [AlternativaHabitoPerjudicial, HabitoActual]).

sugerir_alternativa(HabitoActual, HabitosUsuario, Alternativa) :-
    alternativa_habito(HabitoActual, Alternativa),
    es_bueno_para(Beneficio, Alternativa),
    \+ (member(Problema, HabitosUsuario), es_contraindicativo_para(Alternativa, Problema)),
    format('Puedes considerar ~w como alternativa a ~w ya que ambos sirven para: ~w.~n', [Alternativa, HabitoActual, Beneficio]).

% Regla para obtener sugerencias en base a múltiples hábitos del usuario
obtener_sugerencias(ListaHabitos, HabitosUsuario, Sugerencias) :-
    findall(NuevoHabito, (
        member(AspectoMejorar, ListaHabitos),
        sugerir_nuevo_habito(AspectoMejorar, HabitosUsuario, NuevoHabito)
    ), SugerenciasHabitos),

    findall(AlternativaHabitoPerjudicial, (
        member(Habito, ListaHabitos),
        sugerir_contraindicacion(Habito, HabitosUsuario, AlternativaHabitoPerjudicial)
    ), SugerenciasHabitoPerjudiciales),

    findall(Alternativa, (
        member(Habito, ListaHabitos),
        sugerir_alternativa(Habito, HabitosUsuario, Alternativa)
    ), SugerenciasAlternativas),

    append([SugerenciasHabitos, SugerenciasHabitoPerjudiciales, SugerenciasAlternativas], SugerenciasTotales),
    list_to_set(SugerenciasTotales, Sugerencias).

% Interacción con el usuario
inicio :-
    write('Hola, soy tu asistente de hábitos. Te ayudaré a mejorar tus hábitos.'),
    nl,
    write('Por favor, ingresa tus hábitos actuales (buenos y malos).'),
    nl,
    obtener_habitos_usuario(Habitos),
    analizar_habitos(Habitos).

obtener_habitos_usuario(Habitos) :-
    write('¿Qué aspectos quieres mejorar? (Ingresa una lista de aspectos con formato [aspecto1, aspecto2, ...]): '),
    read(AspectosMejorar),
    write('¿Cuáles son tus hábitos malos? (Ingresa una lista de hábitos con formato [habito1, habito2, ...]): '),
    read(HabitosMalos),
    write('¿Qué hábitos tienes actualmente? (Ingresa una lista de hábitos con formato [habito1, habito2, ...]): '),
    read(HabitosActuales),
    write('¿Tienes algún problema de salud que deba considerar? (Ingresa una lista de problemas con formato [problema1, problema2, ...]): '),
    read(ProblemasSalud),
    append([AspectosMejorar, HabitosMalos, HabitosActuales, ProblemasSalud], Habitos).

analizar_habitos(Habitos) :-
    obtener_sugerencias(Habitos, Habitos, Sugerencias),
    nl,
    write('Basado en tus hábitos actuales, te sugiero considerar los siguientes nuevos hábitos o alternativas:'),
    nl,
    imprimir_lista(Sugerencias).

imprimir_lista([]).
imprimir_lista([Cabeza|Cola]) :-
    write('- '), write(Cabeza), nl,
    imprimir_lista(Cola).
