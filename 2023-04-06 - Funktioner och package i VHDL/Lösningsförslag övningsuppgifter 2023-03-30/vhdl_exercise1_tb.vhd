---------------------------------------------------------------------------------------------------
-- vhdl_exercise1_tb.vhd: Testbench for module displaying the number of high slide switches - 1 
--                        binary via two LEDs.           
--
--                        Signals:
--                            - switch[2:0]: Inputs connected to three slide switches.
--                            - led[1:0]    : Outouts connected to two LEDs.
--
--                       The truth table for the design is shown below:
--
--                       switch[2:0]     led[1:0]
--                           000            11
--                           001            00
--                           010            00
--                           011            01
--                           100            00
--                           101            01
--                           110            01
--                           111            10
--
--                        All combinations of inputs switch[2:0] are tested one by one during
--                        10 ns each. Therefore the total simulation time is 80 ns.
----------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vhdl_exercise1_tb is
end entity;

architecture behaviour of vhdl_exercise1_tb is
signal switch: std_logic_vector(2 downto 0);
signal led   : std_logic_vector(1 downto 0);
begin

    --------------------------------------------------------------------------------
    -- vhdl_exercise1_sim: Creates an object of the top module and connects the 
    --                     ports with corresponding names for simulation.
    --------------------------------------------------------------------------------
    vhdl_exercise1_sim: entity work.vhdl_exercise1
    port map(switch, led);
    
    --------------------------------------------------------------------------------
    -- SIM_PROCESS: Tests all combinations 000 - 111 of inputs switch[2:0] via a
    --              for loop. The value 0 - 7 of integer i gets converted to bits,
    --              first 3-bit unsigned form, then to bits (std_logic_vector). 
    --              After 10 ns, the next combination of switch[2:0] is tested. 
    --              When all combinations have been tested, the process is halted.
    --------------------------------------------------------------------------------
    SIM_PROCESS: process is
    begin
        for i in 0 to 7 loop
            switch <= std_logic_vector(to_unsigned(i, 3));
            wait for 10 ns;
        end loop;
        wait;
    end process;

end architecture;