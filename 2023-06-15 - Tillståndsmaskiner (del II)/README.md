# 2023-06-15 - Tillståndsmaskiner (del II)
Implementering av en enkel tillståndsmaskin, både i hårdvara och VHDL.

Tillståndsmaskinen består av fyra tillstånd:\
    - STATE_1: Motsvarar "00" i hårdvara\
    - STATE_2: Motsvarar "01" i hårdvara\
    - STATE_3: Motsvarar "10" i hårdvara\
    - STATE_4: Motsvarar "11" i hårdvara

Två tryckknappar button_n[1:0] = AB används för att byta tillstånd till nästa respektive föregående enligt nedan:\
    STATE1: Nästa tillstånd blir STATE2 om AB = 10\
    STATE2: Nästa tillstånd blir STATE3 om AB = 10 och STATE1 om AB = 01\
    STATE3: Nästa tillstånd blir STATE4 om AB = 10 och STATE2 om AB = 01\
    STATE4: Nästa tillstånd blir STATE3 om AB = 01

En lysdiod tänds i STATE_4, övrig tid hålls den släckt.

En inverterande reset-signal ansluten till en tryckknapp används för att återställa
tillståndet till startläget STATE_1.

Tillståndsmaskinen realiseras i form av en Moore-maskin.

Katalogen "fsm2" innehåller kretsschema, tillståndsgraf, tillståndsdiagram samt hårdvarubeskrivande kod för konstruktionen. Filen "fsm2.cv" kan öppnas i CircuitVerse för att testa kretsen.