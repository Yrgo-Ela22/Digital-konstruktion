--------------------------------------------------------------------------------
-- or_gate.vhd: Implementation of a 2-input OR gate.
--
--              Inputs:
--                 - a: First input connected to a slide switch.
--                 - b: Second input connected to a slide switch.
--              Outputs:
--                 - x: Output connected to a LED.
--
--              Hardware implemented for FPGA card Terasic DE0.
--------------------------------------------------------------------------------
library ieee; 
use ieee.std_logic_1164.all; 

entity or_gate is
   port(a, b: in std_logic;
        x   : out std_logic);
end entity;

architecture behaviour of or_gate is
begin
   x <= a or b;
end architecture; 
