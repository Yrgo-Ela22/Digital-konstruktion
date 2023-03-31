# 2023-03-29 - OR-grind i VHDL
Syntes samt simulering av en 2-ingångars OR-grind i VHDL, där inportar a och b ansluts 
till två slide-switchar SWITCH[1:0] och utport x ansluts till lysdiod LED[0] på FPGA-kortet Terasic DE0.

Filen "or_gate.vhd" utgör en modul för syntes av en OR-grind. 

Filen "or_gate_tb.vhd" utgör en testbänk för simulering av OR-grinden.

Filen "or_gate.qar" utgör en Quartus arkivfil som kan användas för att direkt öppna
projektet med satta pinnar, implementerad testbänk med mera.

Filen "Lösningsförslag övningsuppgifter 2023-03-23.pdf" utgör lösningsförslag för de övningsuppgifter
som gavs i samband med föregående lektion.