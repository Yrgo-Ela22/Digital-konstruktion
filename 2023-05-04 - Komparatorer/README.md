# 2023-05-04 - Konstruktion av komparatorer i VHDL

Konstruktion av 2-bitars komparator innefattande inportar AB samt utportar XYZ.

Konstruktionen fungerar enligt nedan:
    - A > B => XYZ = 100
    - A = B => XYZ = 010
    - A < B => XYZ = 001

Sanningstabellen för systemet visas nedan:

|    AB    |    XYZ    |
| :------: | :-------: | 
|    00    |    010    |
|    01    |    001    |
|    10    |    100    |     
|    11    |    010    |    

Filen "comparator_2bit.vhd" utgör konstruktionens toppmodul.
Filen "comparator_2bit_tb.vhd" utgör motsvarande testbänk.
