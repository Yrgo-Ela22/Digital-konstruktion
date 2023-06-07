--------------------------------------------------------------------------------
-- @brief Module for constructing timers capable of frequencies between 
--       12 mHz - 50 Mhz. As default a frequency of 1 Hz is used.
--
-- @param FREQUENCY
--        The timer frequency implemented as a max value based on a 50 MHz 
--        system clock (default = 1 Hz).
-- @param clock
--        50 MHz system clock.
-- @param reset_s2_n
--        Synchronized inverting reset signal.
-- @param elapsed
--        Event flag indicating when the timer has elapsed.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.misc.all;

entity timer is
    generic(FREQUENCY: natural := FREQUENCY_1HZ);
    port(clock, reset_s2_n: in std_logic;
         elapsed    : out std_logic);
end entity;

--------------------------------------------------------------------------------
-- @brief Implementing the timer as a counter, where a counter signal is used
--        to count up to a specified max count value. The timer elapsed when
--        the counter value is equal to the max count value.
--
-- @param MAX_COUNT
--        The max count value.
-- @param counter
--        The counter used to count to the max count value.
--------------------------------------------------------------------------------
architecture behaviour of timer is
constant MAX_COUNT: natural := FREQUENCY;
signal counter    : natural range 0 to MAX_COUNT;
begin

    --------------------------------------------------------------------------------
    -- @brief Increments the counter at every clock pulse. When the counter value
    --        is equal to the specified max count value, the timer has elapsed.
    --        If a system reset occurs, the counter is immediately cleared.
    --------------------------------------------------------------------------------
    COUNTER_PROCESS: process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            counter <= 0;
            elapsed <= '0';
        elsif (rising_edge(clock)) then
            if (counter < MAX_COUNT) then
                counter <= counter + 1;
                elapsed <= '0';
            else
                counter <= 0;
                elapsed <= '1';
            end if;
        end if;
    end process;

end architecture;

