--------------------------------------------------------------------------------
-- @brief Contains miscellaneous constants used in the design.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package misc is

--------------------------------------------------------------------------------
-- @brief Contains for frequency selection of timers.
--------------------------------------------------------------------------------
constant FREQUENCY_100HZ: natural := 500000;
constant FREQUENCY_50HZ : natural := FREQUENCY_100HZ * 2;
constant FREQUENCY_20HZ : natural := FREQUENCY_100HZ * 5;
constant FREQUENCY_10HZ : natural := FREQUENCY_100HZ * 10;
constant FREQUENCY_5HZ  : natural := FREQUENCY_10HZ * 2;
constant FREQUENCY_2HZ  : natural := FREQUENCY_10HZ * 5;
constant FREQUENCY_1HZ  : natural := FREQUENCY_10HZ * 10;
end package;