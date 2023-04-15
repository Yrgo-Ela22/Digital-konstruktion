--------------------------------------------------------------------------------
-- multi_hex.vhd: Implementation of system consisting of four hex displays, 
--                where two hexadecimal digits are entered in binary form via 
--                eight slide switches. The entered digits are shown on the hex
--                displays along with the 4-bit sum and difference between them.
--
--                Inputs:
--                   - switch[7:0]  : Slide switches for entering two 
--                                    digits, where switch[7:4] = digit1
--                                    and switch[3:0] = digit0.
--                Outputs:
--                   - display3[6:0]: Displays the sum of the entered digits.
--                   - display2[6:0]: Displays the difference between the 
--                                    entered digits.
--                   - display1[6:0]: Displays the first entered digit.
--                   - display0[6:0]: Displays the second entered digit.
--
--                Inputs switch[7:4] and switch[3:0] are used for entering
--                digit1 and digit0 respectively. 
--
--                Hardware implemented for FPGA card Terasic DE0.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.misc.all;

entity multi_hex is
    port(switch                                : in std_logic_vector(7 downto 0);
         display3, display2, display1, display0: out std_logic_vector(6 downto 0));
end entity;

architecture behaviour of multi_hex is
signal digit1, digit0, sum, difference: std_logic_vector(3 downto 0);
begin
   
    display3 <= get_binary_code(difference);
    display2 <= get_binary_code(sum);
    display1 <= get_binary_code(digit1);
    display0 <= get_binary_code(digit0);
    
    digit1     <= switch(7 downto 4);
    digit0     <= switch(3 downto 0);
    sum        <= add(digit1, digit0, 4);
    difference <= subtract(digit1, digit0, 4);
   
end architecture;