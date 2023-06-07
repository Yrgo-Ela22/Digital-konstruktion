--------------------------------------------------------------------------------
-- @brief Toggles a LED every 100 ms via a timer circuit.
--
-- @param clock
--        50 MHz system clock.
-- @param reset_n
--        Inverting reset connected to a push button.
-- @param led
--        Led toggled every 100 ms.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.misc.all;

entity led_blink is
    port(clock, reset_n: in std_logic;
         led           : out std_logic);
end entity;

architecture behaviour of led_blink is

--------------------------------------------------------------------------------
-- @brief Signals used in the top module.
--
-- @param reset_s1_n
--        Signal used for synchronizing reset_n with the double flop technique.
-- @param reset_s2_n
--        Synchronized reset signal used in the design.
-- @param led_s
--        Holds the value of the led.
-- @param timer_elapsed
--        Indicates if the 10 Hz timer has elapsed.
--------------------------------------------------------------------------------
signal reset_s1_n, reset_s2_n: std_logic := '1';
signal led_s, timer_elapsed  : std_logic := '0';

begin
    
    --------------------------------------------------------------------------------
    -- @brief Synchronizes the reset signal to prevent metastability. At system
    --        reset, the reset signals are immediately cleared. Else at rising edge
    --        of the clock, the reset signals are updated (reset_s1_n = 1 and
    --        reset_s2_n = reset_s1_n).
    --------------------------------------------------------------------------------
    RESET_PROCESS: process(clock, reset_n) is
    begin
        if (reset_n = '0') then
            reset_s1_n <= '0';
            reset_s2_n <= '0';
        elsif (rising_edge(clock)) then
            reset_s1_n <= '1';
            reset_s2_n <= reset_s1_n;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief Creates a 10 Hz timer.
    --------------------------------------------------------------------------------
    timer0: entity work.timer
    generic map(FREQUENCY => FREQUENCY_10HZ)
    port map(clock, reset_s2_n, timer_elapsed);
    
    --------------------------------------------------------------------------------
    -- @brief Toggles the LED when the timer elapses. If a system reset occurs,
    --        the LED is immediately disabled.
    --------------------------------------------------------------------------------
    LED_PROCESS: process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            led_s <= '0';
        elsif (rising_edge(clock)) then
            if (timer_elapsed = '1') then
                led_s <= not led_s;
            end if;
        end if;
    end process;
    
    led <= led_s;

end architecture;