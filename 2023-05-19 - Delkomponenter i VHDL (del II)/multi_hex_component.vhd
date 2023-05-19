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
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multi_hex_component is
    port(switch                : in std_logic_vector(7 downto 0);
         hex3, hex2, hex1, hex0: out std_logic_vector(6 downto 0));
end entity;

architecture behaviour of multi_hex_component is
begin

    --------------------------------------------------------------------------------
    -- display_hexadecimal: Displays entered number 0x00 - 0xFF in hexadecimal 
    --                      form on hex[3:2].
    --------------------------------------------------------------------------------
    display_hexadecimal: entity work.dual_display
    port map(switch, hex3, hex2);
    
    --------------------------------------------------------------------------------
    -- display_decimal: Displays entered number 00 - 99 in decimal form on hex[1:0].
    --------------------------------------------------------------------------------
    display_decimal: entity work.dual_display
    generic map(RADIX => 10)
    port map(switch, hex1, hex0);

end architecture;














