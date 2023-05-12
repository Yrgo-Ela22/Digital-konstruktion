--------------------------------------------------------------------------------
-- comparator_2bit_tb.vhd: Testbench for a 4-bit comparator consisting of
--                         inputs abcd and outputs xyz.
--
--                         The comparator works as follows:
--                             - ab > cd => xyz = 100
--                             - ab = cd => xyz = 010
--                             - ab < cd => xyz = 001
--
--                         All combinations 0000 - 1111 of inputs abcd are
--                         tested during 10 ns each. Therefore the total
--                         simulation time is 160 ns.
--
--                         As usual, the testbench is implemented as follows:
--                             1. Signals that correspond to the ports to test
--                                are declared with starting value 0.
--                             2. The signals are connected to corresponding 
--                                ports via port for testing. To do this, an
--                                instance of the top module is created.
--                             3. The simulation is performed via a process. 
--                                All input combinations are tested one by one.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator_4bit_tb is
end entity;

architecture behaviour of comparator_4bit_tb is
signal a, b, c, d, x, y, z: std_logic := '0';
begin

    --------------------------------------------------------------------------------
    -- simulation: Instance of the top module, whose ports are connected to the
    --             corresponding signals in the testbench for simulation.
    --------------------------------------------------------------------------------
    simulation: entity work.comparator_4bit
    port map(a, b, c, d, x, y, z);
    
    --------------------------------------------------------------------------------
    -- SIM_PROCESS: Testing all combinations 0000 - 1111 of inputs one at a time.
    --              A for loop is run 16 times, where integer i iterates from
    --              0 - 15. The value of i gets converted to bits and is assigned
    --              to signals abcd. Every combination is held for 10 ns. When all
    --              combinations have been tested, the process is halted via the
    --              the wait command to stop the simulation. 
    --------------------------------------------------------------------------------
    SIM_PROCESS: process is
    begin
        for i in 0 to 15 loop
            (a, b, c, d) <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;
        end loop;
        wait;
    end process;

end architecture;