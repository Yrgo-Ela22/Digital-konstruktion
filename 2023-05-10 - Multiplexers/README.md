# 2023-05-10 - Konstruktion av multiplexers i VHDL

Konstruktion av 2-bitars multiplexer innefattande inportar AB, selektorsignal S samt utport S.

Konstruktionen fungerar enligt nedan:
    - S = 0 => X = A
    - S = 1 => X = B

Sanningstabellen för systemet visas nedan:

|    SAB    |    X    |
| :-------: | :-----: | 
|    000    |    0    |
|    001    |    0    |
|    010    |    1    |     
|    011    |    1    |    
|    100    |    0    |
|    101    |    1    |
|    110    |    0    |     
|    111    |    1    |    

Filen "multiplexer_2bit.vhd" utgör konstruktionens toppmodul.
Filen "multiplexer_2bit_tb.vhd" utgör motsvarande testbänk.
Filen "multiplexer_2bit.qar" utgör hela projektet i arkiverad form.
Filen "multiplexer_2bit.pnq" visar motsvarande grindnät i CircuitVerse.

Komparatorfilerna utgör lösningsförslag för övningsuppgiften som gav föregående lektion,
som handlade om konstruktion av en 4-bitars komparator:
Filen "comparator_4bit.pnq" visar grindnäten för komparatorn i CircuitVerse.
Filen "comparator_4bit.vhd" utgör konstruktionens toppmodul.
Filen "comparator_4bit_tb.vhd" utgör motsvarande testbänk.
Filen "comparator_4bit.qar" utgör hela komparatorkonstruktionen i arkiverad form.


