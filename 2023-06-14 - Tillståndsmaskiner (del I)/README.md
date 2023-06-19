# 2023-06-14 - Tillståndsmaskiner (del I)
Implementering av en enkel tillståndsmaskin, både i hårdvara och VHDL.

Tillståndsmaskinen består av fyra tillstånd:\
    - STATE_1: Motsvarar "00" i hårdvara\
    - STATE_2: Motsvarar "01" i hårdvara\
    - STATE_3: Motsvarar "10" i hårdvara\
    - STATE_4: Motsvarar "11" i hårdvara

En tryckknapp button_n används för att byta tillstånd till nästa.
Tillståndsmaskinen är sluten på så sätt att nästa tillstånd efter STATE_4 är STATE_1.

En lysdiod tänds i STATE_4, övrig tid hålls den släckt.

En inverterande reset-signal ansluten till en tryckknapp används för att återställa
tillståndet till startläget STATE_1.

Tillståndsmaskinen realiseras i form av en Moore-maskin.

Katalogen "fsm1" innehåller kretsschema, tillståndsgraf, tillståndsdiagram samt hårdvarubeskrivande kod för konstruktionen. Filen "fsm1.cv" kan öppnas i CircuitVerse för att testa kretsen.
