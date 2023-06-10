--------------------------------------------------------------------------------
--  @brief Digital system where three LEDs are toggled between blinkning with 
--         different frequencies and being disabled via pressdown of a 
--         corresponding push button. All input signals are synchronized with
--         flip flops in order to prevent metastability.
-- 
--  @param clock
--         50 MHz system clock.
--  @param reset_n
--         Invertering asynchronous reset.
--  @param button_n
--         Inverting push buttons for toggling the LEDs.
--  @param led
--         LEDs toggled at pressdown of the corresponding button.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.misc.all;

entity led_blink is
    port(clock, reset_n: in std_logic;
         button_n      : in std_logic_vector(2 downto 0);
         led           : out std_logic_vector(2 downto 0));
end entity;

architecture behaviour of led_blink is
signal button_pressed_s2, led_s    : std_logic_vector(2 downto 0) := (others => '0'); 
signal timer_enabled, timer_elapsed: std_logic_vector(2 downto 0) := (others => '0'); 
signal reset_s2_n                  : std_logic := '1';
begin

    --------------------------------------------------------------------------------
    --  @brief Synchronizes all input signals with two flip flops each in order
    --         to prevent metastability. All buttons are also detected for pressdown.
    --------------------------------------------------------------------------------
    meta_prev1: entity work.meta_prev
    generic map(NUM_BUTTONS => 3)
    port map(clock, reset_n, button_n, reset_s2_n, button_pressed_s2);
    
    --------------------------------------------------------------------------------
    --  @brief Creates a timer that elapses every 100 ms (frequency set to 10 Hz).
    --------------------------------------------------------------------------------
    timer0: entity work.timer
    generic map(FREQUENCY => FREQUENCY_10HZ)
    port map(clock, reset_s2_n, timer_enabled(0), timer_elapsed(0));
    
    --------------------------------------------------------------------------------
    --  @brief Creates a timer that elapses every 200 ms (frequency set to 5 Hz).
    --------------------------------------------------------------------------------
    timer1: entity work.timer
    generic map(FREQUENCY => FREQUENCY_5HZ)
    port map(clock, reset_s2_n, timer_enabled(1), timer_elapsed(1));
    
    --------------------------------------------------------------------------------
    --  @brief Creates a timer that elapses every 1000 ms (frequency set to 1 Hz).
    --------------------------------------------------------------------------------
    timer2: entity work.timer
    port map(clock, reset_s2_n, timer_enabled(2), timer_elapsed(2));
    
    --------------------------------------------------------------------------------
    --  @brief Toggles each timer at pressdown of the corresponding button. 
    --         If a system reset occurs, all timers are immediately disabled.
    --------------------------------------------------------------------------------
    TIMER_PROCESS: process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            timer_enabled <= (others => '0');
        elsif (rising_edge(clock)) then
            for i in 0 to 2 loop
                if (button_pressed_s2(i) = '1') then
                    timer_enabled(i) <= not timer_enabled(i);
                end if;
            end loop;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    --  @brief Toggles each LED every time the corresponding timer has elapsed.
    --         If a system reset occurs, all LEDs are immediately disabled.
    --------------------------------------------------------------------------------
    LED_PROCESS: process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            led_s <= (others => '0');
        elsif (rising_edge(clock)) then
            for i in 0 to 2 loop
                if (timer_enabled(i) = '1') then
                    if (timer_elapsed(i) = '1') then
                        led_s(i) <= not led_s(i);
                    end if;
                else
                    led_s(i) <= '0';
                end if;
            end loop;
        end if;
    end process;
    
    led <= led_s;
     
end architecture;