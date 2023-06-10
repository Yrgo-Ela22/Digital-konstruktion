# Timerkretsar (del I)
Implementering av timerkretsar med valbar frekvens i VHDL.
Också konstruktion av timerkretsar via sammankoppling av heltalsadderare* för hand i CircuitVerse.
Implementeringen genomförs med D-vippor, både för hand i CircuitVerse samt i VHDL.

Tre timerkretsar implementeras för att toggla tre lysdioder med olika frekvenser (10 Hz, 5 Hz och 1 Hz) i aktiverat tillstånd.
Timerkretsarna togglas via var sin tryckknapp.

Katalogen "full_adder" innehåller kretsschema för en heltalsadderare (som används för att realisera en 4-bitars räknare för timerkretsen i CircuitVerse).
Filen "full_adder_rtl.cv" kan öppnas i CircuitVerse för att testa kretsen.

Katalogen "led_blink" innehåller hårdvarubeskrivande kod i VHDL för en konstruktion, där en lysdiod blinkar var 100:e ms via en timerkrets.

Katalogen "timer_system" innehåller hårdvarubeskrivande kod i VHDL för en konstruktion, där tre lysdioder blinkar med olika frekvenser
via var sin timerkrets.

Filen "timer_circuit.cv" demonstrerar kretsschemat för en 4-bitars timerkrets som används för att toggla en lysdiod vid uppräkning till overflow,
vilket för en 4-bitars timerkrets sker vid uppräkning till 16 (0b1000).

*Grindnät för addition av två bitar A och B till en summa sum med funktionalitet för Carry-in (Cin) samt Carry-out (Cout).
Cout utgör Carry-bit från aktuell bitoperation, t.ex. 1 + 1 = 2, vilket medför 0b10, där 0 utgör summan och 1 utgör C-out,
som kopplas som Cin på nästa heltasadderare.

Sanningstabell för heltalsadderaren:

|  A  |  B  | Cin | Cout | sum |
| :-: | :-: | :-: | :-:  | :-: |
|  0  |  0  |  0  |  0   |  0  |
|  0  |  0  |  1  |  0   |  1  |
|  0  |  1  |  0  |  0   |  1  |
|  0  |  1  |  1  |  1   |  0  |
|  1  |  0  |  0  |  0   |  1  |
|  1  |  0  |  1  |  1   |  0  |
|  1  |  1  |  0  |  1   |  0  |
|  1  |  1  |  1  |  1   |  1  |

Via Karnaughdiagram kan följande ekvationer härledas:\
Cout = AB + (A + B)Cin\
sum = A ^ (B ^ Cin)
