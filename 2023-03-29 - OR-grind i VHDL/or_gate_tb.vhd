--------------------------------------------------------------------------------
-- or_gate_tb.vhd: Testbench for a 2-input OR gate.
--
--                 Signals:
--                    - a: First input connected to a slide switch.
--                    - b: Second input connected to a slide switch.
--                    - x: Output connected to a LED.
--
--                 All combinations 00 - 11 of inputs a and b are tested
--                 during 10 ns each. Therefore the simulation is performed
--                 during 40 ns.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity or_gate_tb is
end entity;

architecture behaviour of or_gate_tb is
signal a, b, x: std_logic := '0'; 
begin
   
   --------------------------------------------------------------------------------
   -- or_gate_sim: Creates an OR gate and connects the ports to signals of the
   --              same name in this testbench for simulation.
   --------------------------------------------------------------------------------
   or_gate_sim: entity work.or_gate
   port map(a, b, x);
   
   --------------------------------------------------------------------------------
   -- SIMULATION_PROCESS: Tests all combinations 00 - 11 of signal a and b during
   --                     10 ns each. After 40 ns, the simulation is finished
   --                     and the process is halted.
   --------------------------------------------------------------------------------
   SIMULATION_PROCESS: process is
   begin
      a <= '0';
      b <= '0';
      wait for 10 ns;    
      a <= '0';
      b <= '1';
      wait for 10 ns; 
      a <= '1';
      b <= '0';
      wait for 10 ns;     
      a <= '1';
      b <= '1';
      wait for 10 ns;     
      wait;
   end process;
   
end architecture;

