--------------------------------------------------------------------------------
-- @brief Contains miscellaneous constant used for the design.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package misc is

--------------------------------------------------------------------------------
-- @brief Constants used for setting the frequency of timer circuits between
--        1 - 100 Hz (based on a 50 MHz system clock).
--------------------------------------------------------------------------------
constant FREQUENCY_100HZ: natural := 500000;               -- 100 Hz
constant FREQUENCY_50HZ : natural := FREQUENCY_100HZ * 2;  -- 50 Hz
constant FREQUENCY_20HZ : natural := FREQUENCY_100HZ * 5;  -- 20 Hz
constant FREQUENCY_10HZ : natural := FREQUENCY_100HZ * 10; -- 10 Hz
constant FREQUENCY_5HZ  : natural := FREQUENCY_10HZ * 2;   -- 5 Hz
constant FREQUENCY_2HZ  : natural := FREQUENCY_10HZ * 5;   -- 2 Hz
constant FREQUENCY_1HZ  : natural := FREQUENCY_10HZ * 10;  -- 1 Hz
end package;