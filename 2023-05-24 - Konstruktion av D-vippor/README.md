# 2023-05-24 - Konstruktion av D-vippor
Konstruktion samt uppbyggnad av D-vippor, både med grindar i CircuitVerse samt syntes och simulering i VHDL.
Även repetition av D-latchen, både via grindar i CircuitVerse samt syntes och simulering i VHDL.

Katalogen "d_flip_flop" innehåller kretsschema samt VHDL-kod (syntesbar kod samt testbänk) för D-vippan.

Katalogen "d_latch" innehåller kretsschema samt VHDL-kod (syntesbar kod samt testbänk) för D-latchen.

Kortfattad beskrivning av latchar och vippor:
Latchar (låskretsar) och vippor är enkla minneskretsar som kan lagra en bit. För båda kretsar kan utsignalen låsas via en enable-signal.
Skillnaden dem emellan är att vippor är synkrona, vilket innebär att utsignalen enbart uppdateras vid en klockpuls ifall vippan är öppen, 
medan latchar är asynkrona, vilket innebär att utsignalen uppdateras direkt ifall latchen är öppen. Vippor kräver mer hårdvara och är långsammare,
men medför kraftigt förbättrad kontroll av timing (då uppdatering enbart sker vid klockpuls), vilket är särskilt viktigt i större digitala system.

Att vipporna är synkroniserade kan liknas vid att medlemmar i en storbandsorkester spelar i samma takt, där systemklockan utgör trumslagaren. 
Detta ökar strukturen på låtarna, där alla spelar samma del av en låt samtidigt. Dock krävs mer resurser på grund av en trumslagare.
Latchar kan liknas vid att medlemmarna spelar i olika takt, vilket minskar mängden resurser, men samtidigt kan strukturen på låtarna
bli lidande. Därmed föredras normalt vippor framför latchar.
