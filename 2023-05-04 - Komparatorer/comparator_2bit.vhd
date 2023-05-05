--------------------------------------------------------------------------------
-- comparator_2bit.vhd: Implementation of a 2-bit comparator.
--
--                      Inputs:
--                          - ab : Single bit inputs.
--                      Outputs:
--                          - xyz: Single bit outputs.
--
--                      The comparator works as follows:
--                          a > b => xyz = 100
--                          a = b => xyz = 010
--                          a < b => xyz = 001
--
--                      Hardware implemented for FPGA card Terasic DE0.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity comparator_2bit is
 port(a, b   : in std_logic;
      x, y, z: out std_logic);
end entity;

architecture behaviour of comparator_2bit is
signal a_n, b_n: std_logic;
begin
    a_n <= not a;
    b_n <= not b;  
    x <= a and b_n;
    y <= a xnor b;
    z <= a_n and b;
end architecture;