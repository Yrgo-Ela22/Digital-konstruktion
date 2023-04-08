--------------------------------------------------------------------------------
-- misc.vhd: Contains miscellaneous functions and constants via package misc.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package misc is

--------------------------------------------------------------------------------
-- Binary codes for hexadecimal digits 0x00 - 0x0F:
--------------------------------------------------------------------------------
constant OFF  : std_logic_vector(6 downto 0) := "1111111";
constant ZERO : std_logic_vector(6 downto 0) := "1000000";
constant ONE  : std_logic_vector(6 downto 0) := "1111001";
constant TWO  : std_logic_vector(6 downto 0) := "0100100";
constant THREE: std_logic_vector(6 downto 0) := "0110000";
constant FOUR : std_logic_vector(6 downto 0) := "0011001";
constant FIVE : std_logic_vector(6 downto 0) := "0010010";
constant SIX  : std_logic_vector(6 downto 0) := "0000010";
constant SEVEN: std_logic_vector(6 downto 0) := "1111000";
constant EIGHT: std_logic_vector(6 downto 0) := "0000000";
constant NINE : std_logic_vector(6 downto 0) := "0010000";
constant A    : std_logic_vector(6 downto 0) := "0001000";
constant B    : std_logic_vector(6 downto 0) := "0000011";
constant C    : std_logic_vector(6 downto 0) := "1000110";
constant D    : std_logic_vector(6 downto 0) := "0100001";
constant E    : std_logic_vector(6 downto 0) := "0000110";
constant F    : std_logic_vector(6 downto 0) := "0001110";

--------------------------------------------------------------------------------
-- get_binary_code: Returns the binary code of specified hexadecimal digit.
--
--                  - digit: Hexadecimal digit whose binary code is returned.
--
--                  - return: The binary code of specified digit.
--------------------------------------------------------------------------------
function get_binary_code(constant digit: std_logic_vector(3 downto 0))
return std_logic_vector;

end package;

package body misc is

--------------------------------------------------------------------------------
-- get_binary_code: Returns the binary code of specified hexadecimal digit.
--
--                  - digit: Hexadecimal digit whose binary code is returned.
--
--                  - return: The binary code of specified digit.
--------------------------------------------------------------------------------
function get_binary_code(constant digit: std_logic_vector(3 downto 0))
return std_logic_vector is
begin
    case (digit) is
        when "0000" => return ZERO;
        when "0001" => return ONE;
        when "0010" => return TWO;
        when "0011" => return THREE;
        when "0100" => return FOUR;
        when "0101" => return FIVE;
        when "0110" => return SIX;
        when "0111" => return SEVEN;
        when "1000" => return EIGHT;
        when "1001" => return NINE;
        when "1010" => return A;
        when "1011" => return B;
        when "1100" => return C;
        when "1101" => return D;
        when "1110" => return E;
        when "1111" => return F;
        when others => return OFF;
    end case;
end function;

end package body;