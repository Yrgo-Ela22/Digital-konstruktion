--------------------------------------------------------------------------------
-- @brief Module for creating a timer with selectable frequency.
--
-- @param FREQUENCY
--        The timer frequency as an unsigned integer (default = 1 Hz).
-- @param clock
--        50 MHz system clock.
-- @param reset_s2_n
--        Synchronized inverting reset connected to a push button.
-- @param elapsed
--        Indicates that the timer has elapsed.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.misc.all;

entity timer is
    generic(FREQUENCY: natural := FREQUENCY_1HZ);
    port(clock, reset_s2_n: in std_logic;
         elapsed          : out std_logic);
end entity;

architecture behaviour of timer is

--------------------------------------------------------------------------------
-- @brief Signals and constants used in the component.
-- 
-- @param COUNTER_MAX 
--        Constant containing the max value of the timer (equal to FREQUENCY).
-- @param counter
--        Signals used as a counter (counts from 0 - COUNTER_MAX).
--------------------------------------------------------------------------------
constant COUNTER_MAX: natural := FREQUENCY;
signal counter      : natural range 0 to COUNTER_MAX;
begin
   
     --------------------------------------------------------------------------------
     -- @brief Increments the count at rising edge of the clock. If counter is equal
     --        to COUNTER_MAX, the timer has elapsed and the counter is cleared.
     --        At system reset, the counter is cleared.
     --------------------------------------------------------------------------------
     COUNTER_PROCESS: process(clock, reset_s2_n) is
     begin
         if (reset_s2_n = '0') then
             counter <= 0;
             elapsed <= '0';
         elsif (rising_edge(clock)) then
             if (counter < COUNTER_MAX) then
                 counter <= counter + 1;
                 elapsed <= '0';
             else
                 counter <= 0;
                 elapsed <= '1';
             end if;
         end if;
     end process;
     
end architecture;