--------------------------------------------------------------------------------
-- d_latch.vhd: Design of a simple D latch, i.e. an asynchronous memory ciruit
--              that has the ability to store a single bit when locked.
--              A clock source can be added to create a D flip flop, i.e. a 
--              synchronous memory circuit.
--
--              Inputs:
--                  - d     : Latch input.
--                  - enable: Enable signal for locking/unlocking the output.
--              Outputs:
--                  - q     : Latch output.
--                  - q_n   : Inverse of the latch output.
--
--              Function:
--                  - enable = 0 (latch locked) => q = q, q_n = q_n
--                  - enable = 1 (latch open)   => q = d, q_n = !d
--
--              Hardware configured for FPGA card Terasic DE0.            
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity d_latch is
    port(d, enable: in std_logic;
         q, q_n   : out std_logic);
end entity;

architecture behaviour of d_latch is
signal q_s: std_logic := '0'; -- Starting value for simulation only.
begin
    q_s <= d when enable = '1' else q_s;
    q   <= q_s;
    q_n <= not q_s;
end architecture;