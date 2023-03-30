# 2023-03-30 - Logiska grindnät i VHDL
Implementering av ADAS (Advanced Driver Assistance System) i VHDL.

Ifall föraren bromsar eller om ADAS-systemets kamera indikerar att ett objekt är framför bilen
samtidigt som ADAS-systemets sensor indikerar att objektet närmar sig bromsar bilen.
Vid fel på ADAS-systemet ignoreras signalerna från kameran och sensorn.

Hårdvara implementerad för FPGA-kort Terasic DE0.

Filen "adas.vhd" utgör syntesbar kod för ADAS-systemet.

Filen "adas_tb.vhd" utgör testbänk för ADAS-systemet.

Filen "adas.qar" utgör en arkivfil som kan öppnas för att direkt köra projektet med samtliga
pinnar samt testbänk konfigurerad.

Filen "Lösningsförslag övningsuppgifter 2023-03-29.pdf" innehåller lösningsförslag för de övningsuppgifter som
gavs efter föregående lektion.