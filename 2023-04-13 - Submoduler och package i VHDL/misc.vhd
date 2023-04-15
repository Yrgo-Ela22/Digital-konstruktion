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
-- to_natural: Converts a std_logic_vector to a natural (unsigned) number.
--
--             - vector: The vector whose content is to be converted. 
--
--             - return: Corresponding natural number.
--------------------------------------------------------------------------------
function to_natural(constant vector: std_logic_vector)
return natural;

--------------------------------------------------------------------------------
-- to_std_logic_vector: Converts a natural (unsigned) number to std_logic_vector.
--
--                      - number     : The number to be converted.
--                      - vector_size: The size (number of bits) of the 
--                                     returned vector (default = 32).
--
--                      - return: Corresponding std_logic_vector (i.e. bits).
--------------------------------------------------------------------------------
function to_std_logic_vector(constant number     : natural;
                             constant vector_size: natural := 32)
return std_logic_vector;

--------------------------------------------------------------------------------
-- add: Adds specified numbers and returns the sum as std_logic_vector.
--
--      - x          : Vector containing the first number.
--      - y          : Vector containing the second number.
--      - vector_size: The size of the returned vector (default = 32).
--
--      - return: The sum of the numbers as std_logic_vector.
--------------------------------------------------------------------------------
function add(constant x, y       : std_logic_vector;
             constant vector_size: natural := 32)
return std_logic_vector;

--------------------------------------------------------------------------------
-- subtract: Subtracts specified numbers with 2-complement and returns the 
--           difference as std_logic_vector.
--
--           - x          : Vector containing the first number.
--           - y          : Vector containing the second number.
--           - vector_size: The size of the returned vector (default = 32).
--
--           - return: The difference between the numbers as std_logic_vector.
--------------------------------------------------------------------------------
function subtract(constant x, y       : std_logic_vector;
                  constant vector_size: natural := 32)
return std_logic_vector;

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
-- to_natural: Converts a std_logic_vector to a natural (unsigned) number.
--
--             - vector: The vector whose content is to be converted. 
--
--             - return: Corresponding natural number.
--------------------------------------------------------------------------------
function to_natural(constant vector: std_logic_vector)
return natural is
begin
    return to_integer(unsigned(vector));
end function;

--------------------------------------------------------------------------------
-- to_std_logic_vector: Converts a natural (unsigned) number to std_logic_vector.
--
--                      - number     : The number to be converted.
--                      - vector_size: The size (number of bits) of the 
--                                     returned vector (default = 32).
--
--                      - return: Corresponding std_logic_vector (i.e. bits).
--------------------------------------------------------------------------------
function to_std_logic_vector(constant number     : natural;
                             constant vector_size: natural := 32)
return std_logic_vector is
begin
    return std_logic_vector(to_unsigned(number, vector_size));
end function;

--------------------------------------------------------------------------------
-- add: Adds specified numbers and returns the sum as std_logic_vector.
--
--      - x          : Vector containing the first number.
--      - y          : Vector containing the second number.
--      - vector_size: The size of the returned vector (default = 32).
--
--      - return: The sum of the numbers as std_logic_vector.
--------------------------------------------------------------------------------
function add(constant x, y       : std_logic_vector;
             constant vector_size: natural := 32)
return std_logic_vector is
constant sum: natural := to_natural(x) + to_natural(y);
begin
   return to_std_logic_vector(sum, vector_size);
end function;

--------------------------------------------------------------------------------
-- subtract: Subtracts specified numbers with 2-complement and returns the 
--           difference as std_logic_vector.
--
--           - x          : Vector containing the first number.
--           - y          : Vector containing the second number.
--           - vector_size: The size of the returned vector (default = 32).
--
--           - return: The difference between the numbers as std_logic_vector.
--------------------------------------------------------------------------------
function subtract(constant x, y       : std_logic_vector;
                  constant vector_size: natural := 32)
return std_logic_vector is
constant difference: natural := to_natural(x) + (2 ** vector_size - to_natural(y));
begin
   return to_std_logic_vector(difference, vector_size);
end function;

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