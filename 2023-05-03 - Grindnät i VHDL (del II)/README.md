# 2023-05-03 - Konstruktion av logiskt grindnät i VHDL

Konstruktion av grindnät för system innehållande insignaler ABCD samt utsignaler XY. 
Sanningstabellen för systemet visas nedan:

|    ABCD    |    XYZV    |
| :--------: | :--------: | 
|    0000    |    1010    |
|    0001    |    1110    |
|    0010    |    0000    |     
|    0011    |    0100    |    
|    0100    |    1111    |   
|    0101    |    1111    |     
|    0110    |    0101    |      
|    0111    |    0101    |      
|    1000    |    0011    |     
|    1001    |    0111    |     
|    1010    |    1001    |     
|    1011    |    1101    |     
|    1100    |    0110    |     
|    1101    |    0110    |     
|    1110    |    1100    |  
|    1111    |    1100    |  

Filen "vhdl_exercise3.vhd" utgör konstruktionens toppmodul.
Filen "vhdl_exercise3_tb.vhd" utgör motsvarande testbänk.
