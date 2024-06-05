% Base de conocimientos predefinida
:- encoding(utf8).

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
es_contraindicativo_para(correr, artritis).
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
es_contraindicativo_para(tocar_guitarra, artritis).
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

% Beneficios de cada hábito
beneficio_de(correr, 'mejorar tu resistencia cardiovascular').
beneficio_de(senderismo, 'fortalecer tus músculos y mejorar tu salud mental').
beneficio_de(leer, 'aumentar tu conocimiento y mejorar tus habilidades cognitivas').
beneficio_de(meditar, 'reducir el estrés y mejorar tu salud mental').
beneficio_de(caminar, 'mejorar tu salud general y bienestar').
beneficio_de(nadar, 'mejorar tu resistencia cardiovascular y tonificar tu cuerpo').
beneficio_de(bicicleta, 'fortalecer tus piernas y mejorar tu salud cardiovascular').
beneficio_de(yoga, 'mejorar tu flexibilidad y reducir el estrés').
beneficio_de(jardineria, 'mejorar tu salud mental y bienestar').
beneficio_de(cocinar, 'aprender a alimentarte de forma saludable y mejorar tus habilidades culinarias').
beneficio_de(escribir, 'expresar tus pensamientos y emociones de forma creativa').
beneficio_de(baile, 'mejorar tu coordinación y bienestar general').
beneficio_de(pintura, 'desarrollar tu creatividad y mejorar tu bienestar emocional').
beneficio_de(tocar_guitarra, 'mejorar tu habilidad musical y bienestar emocional').
beneficio_de(escultura, 'desarrollar tu creatividad y habilidades artesanales').
beneficio_de(pesca, 'mejorar tu paciencia y bienestar general').
beneficio_de(ceramica, 'desarrollar tu creatividad y habilidades artesanales').
beneficio_de(origami, 'mejorar tu precisión y habilidades manuales').
beneficio_de(coleccionar_monedas, 'aprender sobre historia y numismática').
beneficio_de(beber_agua, 'mantenerte hidratado y mejorar tu salud general').
beneficio_de(comer_saludable, 'nutrir tu cuerpo y mejorar tu salud general').
beneficio_de(dormir_bien, 'descansar adecuadamente y mejorar tu salud general').
beneficio_de(hacer_ejercicio, 'mejorar tu salud general y bienestar').
beneficio_de(meditar, 'reducir el estrés y mejorar tu salud mental').

% Reglas para sugerir nuevos hábitos y alternativas con beneficios
sugerir_nuevo_habito(Objetivo, HabitosUsuario, Objetivo-NuevoHabito-Beneficio) :-
    es_bueno_para(Objetivo, NuevoHabito),
    beneficio_de(NuevoHabito, Ya ),
    \+ (member(Problema, HabitosUsuario), es_contraindicativo_para(NuevoHabito, Problema)).

sugerir_contraindicacion(HabitoActual, HabitosUsuario, HabitoActual-AlternativaHabitoPerjudicial-Beneficio) :-
    alternativa_habito_malo(HabitoActual, AlternativaHabitoPerjudicial),
    beneficio_de(AlternativaHabitoPerjudicial, Beneficio),
    \+ (member(Problema, HabitosUsuario), es_contraindicativo_para(AlternativaHabitoPerjudicial, Problema)).

sugerir_alternativa(HabitoActual, HabitosUsuario, HabitoActual-Alternativa-Beneficio) :-
    alternativa_habito(HabitoActual, Alternativa),
    es_bueno_para(Beneficio, Alternativa),
    \+ (member(Problema, HabitosUsuario), es_contraindicativo_para(Alternativa, Problema)).

% Regla para obtener sugerencias en base a múltiples hábitos del usuario
obtener_sugerencias(ListaHabitos, HabitosUsuario, SugerenciaNuevosHabitos, SugerenciaAlternativaHabitosPerjudiciales, SugerenciaAlternativaHabitos) :-
    findall(Objetivo-NuevoHabito-Beneficio, (
        member(Objetivo, ListaHabitos),
        sugerir_nuevo_habito(Objetivo, HabitosUsuario, Objetivo-NuevoHabito-Beneficio)
    ), SugerenciaNuevosHabitos),

    findall(HabitoActual-AlternativaHabitoPerjudicial-Beneficio, (
        member(Habito, ListaHabitos),
        sugerir_contraindicacion(Habito, HabitosUsuario, HabitoActual-AlternativaHabitoPerjudicial-Beneficio)
    ), SugerenciaAlternativaHabitosPerjudiciales),

    findall(HabitoActual-Alternativa-Beneficio, (
        member(Habito, ListaHabitos),
        sugerir_alternativa(Habito, HabitosUsuario, HabitoActual-Alternativa-Beneficio)
    ), SugerenciaAlternativaHabitos).

imprimir_lista([]).
imprimir_lista([Aspecto-Habito-Beneficio|Cola]) :-
    write('- '), write(Aspecto), write(': '), write(Habito), write(' ('), write(Beneficio), write(')'), nl,
    imprimir_lista(Cola).

% Regla adicional para obtener sugerencias como listas separadas en lugar de imprimirlas
obtener_sugerencias_lista(ListaHabitos, HabitosUsuario, SugerenciaNuevosHabitos, SugerenciaAlternativaHabitosPerjudiciales, SugerenciaAlternativaHabitos) :-
    obtener_sugerencias(ListaHabitos, HabitosUsuario, SugerenciaNuevosHabitos, SugerenciaAlternativaHabitosPerjudiciales, SugerenciaAlternativaHabitos).

