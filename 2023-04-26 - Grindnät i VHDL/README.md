# 2023-04-26 - Konstruktion av logiskt grindnät i VHDL

Konstruktion av grindnät för system innehållande insignaler ABCD samt utsignaler XY. 
Sanningstabellen för systemet visas nedan:

|    ABCD    |    XY    |\
| :--------: | :------: |\ 
|    0000    |    10    |\
|    0001    |    10    |\
|    0010    |    00    |\     
|    0011    |    00    |\    
|    0100    |    11    |\   
|    0101    |    11    |\     
|    0110    |    01    |\      
|    0111    |    01    |\      
|    1000    |    10    |\     
|    1001    |    00    |\     
|    1010    |    10    |\     
|    1011    |    10    |\     
|    1100    |    11    |\     
|    1101    |    11    |\     
|    1110    |    11    |\  
|    1111    |    11    |  

Filen "vhdl_exercise2.vhd" utgör konstruktionens toppmodul.
Filen "vhdl_exercise2_tb.vhd" utgör motsvarande testbänk.