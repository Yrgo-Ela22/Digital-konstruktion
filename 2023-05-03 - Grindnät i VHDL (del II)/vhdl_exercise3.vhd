--------------------------------------------------------------------------------
-- vhdl_exercise3.vhd: Implementation of digital system consisting of four
--                     inputs abcd and four outputs xyzv.
--
--                     Inputs:
--                         - abcd: Single bit inputs.
--                     Outputs:
--                         - xyzv: Single bit outputs.
--
--                     The system is implemented as follows:
--                         x = (a ^ c)'
--                         y = b + d
--                         z = c'
--                         v = a ^ b
--
--                     Hardware implemented for FPGA card Terasic DE0.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity vhdl_exercise3 is
    port(a, b, c, d: in std_logic;
         x, y, z, v: out std_logic);
end entity;

architecture behaviour of vhdl_exercise3 is
begin
    x <= a xnor c;
    y <= b or d;
    z <= not c;
    v <= a xor b;
end architecture;