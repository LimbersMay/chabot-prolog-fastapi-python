habito(sueno).
habito(ejercicio).
habito(agua).

% Definir habitos buenos
es_habito_bueno(sueno, 7, 9).
es_habito_bueno(ejercicio, 30).
es_habito_bueno(agua, 2).




% Respuestas del usuario
usuario_dice(sueno, Horas) :-
  write('Cuantas horas de sueno sueles tener cada noche? '),
  read(Horas).

usuario_dice(ejercicio, Minutos) :-
  write('Cuantos minutos de ejercicio sueles hacer cada dia? '),
  read(Minutos).

usuario_dice(agua, Litros) :-
  write('Cuantos litros de agua sueles beber cada dia? '),
  read(Litros).

% Analizar habitos
analizar_habito(sueno, Horas) :-
  es_habito_bueno(sueno, Minimo, Maximo),
  ( Horas >= Minimo, Horas =< Maximo ->
    write('Tu sueno parece estar en buen camino. ');
    write('Podrias considerar dormir de '), write(Minimo), write(' a '), write(Maximo), write(' horas cada noche.')).

analizar_habito(ejercicio, Minutos) :-
  es_habito_bueno(ejercicio, Ideal),
  ( Minutos >= Ideal ->
    write('Excelente trabajo manteniendote activo! ');
    write('Considera al menos hacer '), write(Ideal), write(' minutos de ejercicio diario')).


analizar_habito(agua, Litros) :-
  es_habito_bueno(agua, Ideal),
  ( Litros >= Ideal ->
    write('Mantenerse hidratado es fantastico! ');
    write('Considera alcanzar '), write(Ideal), write(' litros de agua diariamente.')).

% Bucle principal
chatbot :-
  repeat,
    write('Que habito te gustaria discutir (sueno, ejercicio, agua o salir)? '),
    read(Habito),
    Habito \= salir ->
      usuario_dice(Habito, Valor),
      analizar_habito(Habito, Valor),
      nl,
    !;
    write('Gracias por usar la ayuda de habitos!').  % Salir en 'salir'
