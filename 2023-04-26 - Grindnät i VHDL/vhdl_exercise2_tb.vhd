--------------------------------------------------------------------------------
-- vhdl_exercise2.vhd: Testbench for module vhdl_exercise2.
--
--                     Signals:
--                         - a, b, c, d: One bit inputs.
--                         - x, y      : One bit outputs.
--                     
--                     All 16 combination 0000 - 1111 of inputs abcd are
--                     tested during 10 ns each, therefore the total simulation
--                     time is 160 ns. Simulation is performed in ModelSim.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vhdl_exercise2_tb is
end entity;

architecture behaviour of vhdl_exercise2_tb is
signal a, b, c, d, x, y: std_logic := '0';
begin

    --------------------------------------------------------------------------------
    -- sim_instance: Connects the ports of module vhdl_exercise2 with signals of
    --               of the same name to simulate the design. 
    --------------------------------------------------------------------------------
    sim_instance: entity work.vhdl_exercise2
    port map(a, b, c, d, x, y);
    
    --------------------------------------------------------------------------------
    -- SIM_PROCESS: Tests all combinations 0000 - 1111 of inputs ABCD via a for
    --              loop. The value 0 - 15 of integer i is converted to bits and
    --              assigned to variable input. Each combination is tested during
    --              10 ns. The process is halted once all combinations have been
    --              tested.
    --------------------------------------------------------------------------------
    SIM_PROCESS: process is
    variable input: std_logic_vector(3 downto 0);
    begin
    for i in 0 to 15 loop
        input := std_logic_vector(to_unsigned(i, 4));
        a <= input(3);
        b <= input(2);
        c <= input(1);
        d <= input(0);
        wait for 10 ns;
    end loop;
    wait; 
    end process;

end architecture; 
