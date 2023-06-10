--------------------------------------------------------------------------------
-- @brief Design where two hex displays each displays a hexadecimal digit
--        0x0 - 0xF. Via a push button each, incrementation of the digit
--        displayed is toggled between enabled and disabled. As default, 
--        incrementation is disabled and the digit 0 is displayed.
--
-- @param clock
--        50 MHz system clock.
-- @param reset_n
--        Inverting reset signal connected to a push button.
-- @param button_n
--        Inverting push buttons for toggling incrementation of the displays.
-- @param hex1
--        Hex display incremented every 1000 ms when incrementation is enabled.
-- @param hex0
--        Hex display incremented every 100 ms when incrementation is enabled.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.misc.all;

entity timed_display is
    port(clock, reset_n: in std_logic;
         button_n      : in std_logic_vector(1 downto 0);
         hex1, hex0    : out std_logic_vector(6 downto 0));
end entity;

architecture behaviour of timed_display is

--------------------------------------------------------------------------------
-- @brief Array containing two 4-bit counters (range 0 - 15).
--------------------------------------------------------------------------------
type counter_array_t is array (0 to 1) of natural range 0 to 15;

--------------------------------------------------------------------------------
-- @brief Signals used in the top module.
--
-- @param reset_s2_n
--        Synchronized inverting reset signal used for the design.
-- @param button_pressed_s2
--        Synchronized event flags indicating pressdown of the buttons.
-- @param timer_enabled
--        Enable signals for the two timers.
-- @param timer_elapsed
--        Event flags for the timers indicating if they have elapsed.
-- @param counter
--        Array consisting of two 4-bit counters (range 0 - 15).
--------------------------------------------------------------------------------
signal reset_s2_n                  : std_logic := '1';
signal button_pressed_s2           : std_logic_vector(1 downto 0) := (others => '0');
signal timer_enabled, timer_elapsed: std_logic_vector(1 downto 0) := (others => '0');
signal counter                     : counter_array_t := (others => 0);
begin

    --------------------------------------------------------------------------------
    -- @brief Synchronizes all input signals with two flip flops each in order
    --        to prevent metastability. All buttons are also detected for pressdown.
    --------------------------------------------------------------------------------
    meta_prev1: entity work.meta_prev
    generic map(NUM_BUTTONS => 2)
    port map(clock, reset_n, button_n, reset_s2_n, button_pressed_s2);
    
    --------------------------------------------------------------------------------
    -- @brief Creates a timer that elapses every 100 ms (frequency set to 10 Hz).
    --------------------------------------------------------------------------------
    timer0: entity work.timer
    generic map(FREQUENCY => FREQUENCY_10HZ)
    port map(clock, reset_s2_n, timer_enabled(0), timer_elapsed(0));
    
    --------------------------------------------------------------------------------
    -- @brief Creates a timer that elapses every 1000 ms (frequency set to 1 Hz).
    --------------------------------------------------------------------------------
    timer1: entity work.timer
    port map(clock, reset_s2_n, timer_enabled(1), timer_elapsed(1));
    
    --------------------------------------------------------------------------------
    -- @brief Displays the value of the first counter at hex0. The value is 
    --        updated every 100 ms when the corresponding timer is enabled.
    --------------------------------------------------------------------------------
    display0: entity work.display
    port map(counter(0), hex0);
    
    --------------------------------------------------------------------------------
    -- @brief Displays the value of the second counter at hex1. The value is 
    --        updated every 1000 ms when the corresponding timer is enabled.
    --------------------------------------------------------------------------------
    display1: entity work.display
    port map(counter(1), hex1);
    
    --------------------------------------------------------------------------------
    -- @brief Toggles each timer at pressdown of the corresponding button. 
    --        If a system reset occurs, all timers are immediately disabled.
    --------------------------------------------------------------------------------
    TIMER_PROCESS: process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            timer_enabled <= (others => '0');
        elsif (rising_edge(clock)) then
            for i in 0 to 1 loop
                if (button_pressed_s2(i) = '1') then
                    timer_enabled(i) <= not timer_enabled(i);
                end if;
            end loop;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief Increments each counter when the corresponding timer elapses.
    --        If a system reset occurs, all counters are immediately cleared.
    --------------------------------------------------------------------------------
    COUNTER_PROCESS: process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            counter <= (others => 0);
        elsif (rising_edge(clock)) then
            for i in 0 to 1 loop
                if (timer_elapsed(i) = '1') then
                    if (counter(i) < 15) then
                        counter(i) <= counter(i) + 1;
                    else
                        counter(i) <= 0;
                    end if;
                end if;
            end loop;
        end if;
    end process;

end architecture;