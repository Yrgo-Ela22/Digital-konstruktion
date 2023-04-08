---------------------------------------------------------------------------------------------------
-- vhdl_exercise1.vhd: Displays the number of high slide switches - 1 binary via two LEDs.           
--
--                     Inputs:
--                         - switch[2:0]: Inputs connected to three slide switches.
--                    Outputs:
--                        - led[1:0]    : Outouts connected to two LEDs.
--
--                    The truth table for the design is shown below:
--
--                    switch[2:0]     led[1:0]
--                        000            11
--                        001            00
--                        010            00
--                        011            01
--                        100            00
--                        101            01
--                        110            01
--                        111            10
--
--                     Hardware implemented for FPGA-card Terasic DE0.
----------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity vhdl_exercise1 is
    port(switch: in std_logic_vector(2 downto 0);
         led   : out std_logic_vector(1 downto 0));
end entity;

architecture behaviour of vhdl_exercise1 is
signal switch_n: std_logic_vector(2 downto 0);
begin
    switch_n <= not switch; 
    led(1) <= (switch_n(2) and switch_n(1) and switch_n(0)) or (switch(2) and switch(1) and switch(0));  
    led(0) <= switch(2) xnor (switch(1) xor switch(0));
end architecture;

