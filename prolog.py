from swiplserver import PrologMQI, PrologThread, create_posix_path

with PrologMQI() as mqi:
    with mqi.create_thread() as prolog:
        path = create_posix_path("chatbot.pl")
        prolog.query(f'consult("{path}").')
        result = prolog.query("hola")

