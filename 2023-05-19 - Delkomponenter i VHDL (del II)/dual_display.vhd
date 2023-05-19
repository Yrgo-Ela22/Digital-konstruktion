--------------------------------------------------------------------------------
-- dual_display.vhd: Component for displaying a 2-digit number with a radix
--                   between 2 and 16. If the entered number is larger than
--                   what can be displayed on two displays, it's set to the
--                   max value, such as 99 for decimal numbers.
--
--                   Generics:
--                       - RADIX: The radix to use (default = 16).
--                   Inputs:
--                       - input[7:0]: Input number in bits.
--                   Outputs:
--                       - hex1[6:0]: Displays the most significant digit.
--                       - hex0[6:0]: Displays the least significant digit.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dual_display is 
    generic(RADIX  : natural range 2 to 16 := 16);
    port(input     : in std_logic_vector(7 downto 0);
         hex1, hex0: out std_logic_vector(6 downto 0));
end entity;

architecture behaviour of dual_display is
constant MAX_VAL         : natural := RADIX**2 - 1; 
signal input_uint, number: natural range 0 to 255;
signal digit1, digit0    : natural range 0 to 15;
begin

    input_uint <= to_integer(unsigned(input));
    number <= MAX_VAL when input_uint >= MAX_VAL else input_uint;
    
    --------------------------------------------------------------------------------
    -- DIGIT_EXTRACTION_PROCESS: Extracts digits out of specified number at every
    --                           change of the number.
    --------------------------------------------------------------------------------
    DIGIT_EXTRACTION_PROCESS: process(number) is
    begin
        for i in 0 to RADIX - 1 loop
           if (number >= RADIX * i and number < RADIX * (i + 1)) then
               digit1 <= i; 
               digit0 <= number - digit1 * RADIX; 
           end if;
        end loop;
    end process;
    
    display_digit1: entity work.display 
    port map(digit1, hex1);
    
    display_digit0: entity work.display
    port map(digit0, hex0);
    
end architecture;



