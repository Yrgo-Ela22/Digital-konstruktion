--------------------------------------------------------------------------------
-- vhdl_exercise2.vhd: Implementation of logic net consisting four inputs
--                     and two outputs.
--
--                     Inputs:
--                         - a, b, c, d: One bit inputs.
--                     Outputs:
--                         - x, y      : One bit outputs.
--                     
--                     The design is implemented as follows:
--                                  x = ab + a'c' + ad'
--                                         y = b
--                      
--                     Hardware implemented for FPGA card Terasic DE0.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity vhdl_exercise2 is
    port(a, b, c, d: in std_logic;
         x, y      : out std_logic);
end entity;

architecture behaviour of vhdl_exercise2 is
signal a_n, c_n, d_n: std_logic; 
begin

    a_n <= not a;
    c_n <= not c;
    d_n <= not d;

    x <= (a and b) or (a_n and c_n) or (a and d_n);
    y <= b;
end architecture;