# 2023-04-06 - Funktioner och package i VHDL
Demonstration av hur motsvarigheten till funktioner och headerfiler i C implementeras i VHDL för mindre repetitiv kod
samt för att kunna dela VHDL-kod mellan moduler. 

Ett system med där två hexadecimala tal 0x0 - 0xF kan matas in via fyra slide-switchar var och där de två talen samt summan och differensen
av dem skrivs ut på var sin 7-segmentsdisplay ska förenklas via användning av ett flertal funktioner. I aktuellt tillstånd har en funktion implementeras
för att erhålla binärkoden för en siffra 0x0 - 0xF utefter angiven siffra 0000 - 1111. Under nästa lektion ska ytterligare funktioner implementeras
för enkel omvandling mellan naturliga tal och bitar, beräkning av summa och differens med mera.

Hårdvara implementerad för FPGA-kort Terasic DE0.

Filen "multi_hex.vhd" utgör konstruktionens toppmodul.
Filen "misc.vhd" innehåller package misc, som innehåller konstanter för binärkoder samt deklaration samt definition av funktionen get_binary_code.

Filen "multi_hex_de0.qar" utgör en arkivfil som kan öppnas för att direkt köra projektet med samtliga pinnar för FPGA-kort Terasic DE0 konfigurerade.

Katalogen "Lösningsförslag övningsuppgifter 2023-03-30" innehåller lösningsförslag för de övningsuppgifter som gavs efter föregående lektion.