--------------------------------------------------------------------------------
-- multi_hex_component.vhd: Design containing hex displays for displaying
--                          decimal and hexadecimal numbers.
--
--                          Inputs:
--                              - switch[7:0]: Slide switches for selecting
--                                             number 0 - 255 to display.
--                          Outputs:
--                              - hex3[6:0]  : Displays MSD in hexadecimal form.
--                              - hex2[6:0]  : Displays LSD in hexadecimal form.
--                              - hex1[6:0]  : Displays MSD in decimal form.
--                              - hex0[6:0]  : Displays LSD in decimal form.
--
--                          hex3-hex2 displays a hexadecimal number 0x00 - 0xFF.
--                          hex1-hex0 displays a decimal number 00 - 99,
--                          where entered numbers over 99 is ignored.
--
--                          Note: The design isn't finished. Currently, the
--                          entered number 0x00 - 0xFF is displayed at both
--                          hex3-hex2 and hex1-hex0.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multi_hex_component is
    port(switch                : in std_logic_vector(7 downto 0);
         hex3, hex2, hex1, hex0: out std_logic_vector(6 downto 0));
end entity;

architecture behaviour of multi_hex_component is


signal digit1, digit0: natural range 0 to 15;
begin
    digit1 <= to_integer(unsigned(switch(7 downto 4))); -- Most significant digit (MSD).
    digit0 <= to_integer(unsigned(switch(3 downto 0))); -- Least significant digit (LSD).
    
	 --------------------------------------------------------------------------------
	 -- display3: Testing hex3 by displaying MSD of entered number 0x00 - 0xFF.
	 --------------------------------------------------------------------------------
    display3: entity work.display
    port map(digit1, hex3);
    
	 --------------------------------------------------------------------------------
	 -- display2: Testing hex2 by displaying LSD of entered number 0x00 - 0xFF.
	 --------------------------------------------------------------------------------
    display2: entity work.display
    port map(digit0, hex2);
    
	 --------------------------------------------------------------------------------
	 -- display1: Testing hex1 by displaying MSD of entered number 0x00 - 0xFF.
	 --------------------------------------------------------------------------------
    display1: entity work.display
    port map(digit1, hex1);
    
	 --------------------------------------------------------------------------------
	 -- display0: Testing hex0 by displaying LSD of entered number 0x00 - 0xFF.
	 --------------------------------------------------------------------------------
    display0: entity work.display
    port map(digit0, hex0);
    
end architecture;














