# 2023-06-08 - Timerkretsar (del II)
Implementering av timerkretsar med valbar frekvens i VHDL samt SystemVerilog.
Också konstruktion av timerkretsar via sammankoppling av heltalsadderare* för hand i CircuitVerse.
Implementeringen genomförs med D-vippor, både för hand i CircuitVerse samt i VHDL.

Tre timerkretsar implementeras för att toggla tre lysdioder med olika frekvenser (10 Hz, 5 Hz och 1 Hz) i aktiverat tillstånd.
Timerkretsarna togglas via var sin tryckknapp.

Katalogen "led_blink" innehåller kretsschema samt hårdvarubeskrivande kod för konstruktionen.
Filen "led_blink.cv" kan öppnas i CircuitVerse för att testa kretsen.

Filen "timer_display" innehåller hårdvarubeskrivande kod i VHDL samt SystemVerilog för ytterligare en konstruktion, 
där två hexadecimala tal 0x0 - 0xF skrivs ut på var sin display och räknas upp med olika frekvenser (10 Hz respektive 1 Hz). Uppräkningen av talen kan startas/stoppas via nedtryckning av var sin tryckknapp.