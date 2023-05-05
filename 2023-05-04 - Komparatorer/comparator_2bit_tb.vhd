--------------------------------------------------------------------------------
-- comparator_2bit_tb.vhd: Testbench for a 2-bit comparator consisting of
--                         inputs ab and outputs xyz.
--
--                         The comparator works as follows:
--                             a > b => xyz = 100
--                             a = b => xyz = 010
--                             a < b => xyz = 001
--
--                         All combinations 00 - 11 of input signals ab are
--                         tested during 10 ns each. Therefore the total
--                         simulation time is 40 ns.
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

entity comparator_2bit_tb is
end entity;

architecture behaviour of comparator_2bit_tb is
signal a, b, x, y, z: std_logic := '0';
begin

    --------------------------------------------------------------------------------
    -- simulation: Instance of the top module, whose ports are connected to the
    --             corresponding signals in the testbench for simulation.
    --------------------------------------------------------------------------------
    simulation: entity work.comparator_2bit
    port map(a, b, x, y, z);
    
    --------------------------------------------------------------------------------
    -- SIM_PROCESS: Testing all combinations 00 - 11 of inputs one at a time.
    --              A for loop is run four times, where integer i iterates from
    --              0 - 3. The value of i gets converted to bits and is assigned
    --              to signals ab. Every combination is held for 10 ns. After all
    --              combinations have been tested, the process is halted via the
    --              wait command to stop the simulation. 
    --------------------------------------------------------------------------------
    SIM_PROCESS: process is
    variable input: std_logic_vector(1 downto 0);
    begin
        for i in 0 to 3 loop
        input := std_logic_vector(to_unsigned(i, 2));
        a <= input(1);
        b <= input(0);
        wait for 10 ns;
        end loop;
        wait;
    end process;

end architecture;