--------------------------------------------------------------------------------
-- vhdl_exercise3_tb.vhd: Testbench for a digital system consisting of four
--                        inputs abcd and four outputs xyzv.
--
--                        The system is implemented as follows:
--                            x = (a ^ c)'
--                            y = b + d
--                            z = c'
--                            v = a ^ b
--
--                        All combinations 0000 - 1111 of input signals abcd
--                        are simulated during 10 ns each. Therefore the total
--                        simulation time is 160 ns.
--
--                        As usual, the testbench is implemented as follows:
--                            1. Signals that correspond to the ports to test
--                               are declared with starting value 0.
--                            2. These signals are connected to corresponding 
--                               ports for testing via port mapping. To do
--                               this, an instance of the top module is created.
--                            3. The simulation is performed via a process. 
--                               All input combinations are tested one by one.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vhdl_exercise3_tb is
end entity;

architecture behaviour of vhdl_exercise3_tb is
signal a, b, c, d, x, y, z, v: std_logic := '0'; 
begin

    --------------------------------------------------------------------------------
    -- simulation: Instance of the top module, whose ports are connected to the
    --             corresponding signals in the testbench for simulation.
    --------------------------------------------------------------------------------
    simulation: entity work.vhdl_exercise3
    port map(a, b, c, d, x, y, z, v);
    
    --------------------------------------------------------------------------------
    -- SIM_PROCESS: Testing all combinations 0000 - 1111 of inputs one at a time.
    --              A for loop is run 16 times, where integer i iterates from
    --              0 - 15. The value of i gets converted to four bits and is
    --              is assigned to local variable input. Note that the value of
    --              i first is converted to a 4-bit unsigned integer, then to a
    --              std_logic_vector, i.e. bits. These four bits are then
    --              assigned to signals abcd. Every combination is held for 10 ns.
    --              After all combinations have been tested, the process is halted
    --              via the wait command to stop the simulation. 
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