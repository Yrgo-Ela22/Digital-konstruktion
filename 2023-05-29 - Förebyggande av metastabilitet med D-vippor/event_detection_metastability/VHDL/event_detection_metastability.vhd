--------------------------------------------------------------------------------
-- @brief Design where 1 - 3 buttons can be used to toggle corresponding 
--        LEDs via pressdown. All inputs are synchronized via the double flop
--        technique to prevent metastability.
--
-- @param NUM_BUTTONS
--        The number of buttons (and LEDs) in the system (default = 3).    
-- @param clock                    
--        50 MHz system clock.
-- @param reset_n                  
--        Invering reset signal.
-- @param button_n
--        Inverting push buttons.
-- @param led     
--        LEDs toggled by pressdown.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity event_detection_metastability is
    generic(NUM_BUTTONS: natural range 1 to 3 := 3);
    port(clock, reset_n: in std_logic;
         button_n      : in std_logic_vector(NUM_BUTTONS - 1 downto 0);
         led           : out std_logic_vector(NUM_BUTTONS - 1 downto 0));
end entity;

architecture behaviour of event_detection_metastability is
signal reset_s2_n       : std_logic := '0'; 
signal button_pressed_s2: std_logic_vector(NUM_BUTTONS - 1 downto 0) := (others => '0');
signal led_s            : std_logic_vector(NUM_BUTTONS - 1 downto 0) := (others => '0');
begin

     --------------------------------------------------------------------------------
     -- @brief Synchronizes input signals to prevent metastability. 
     --        Pressdown detection of the buttons is also performed.
     --------------------------------------------------------------------------------
    meta_prev1: entity work.meta_prev
    generic map(NUM_BUTTONS)
    port map(clock, reset_n, button_n, reset_s2_n, button_pressed_s2);
    
     --------------------------------------------------------------------------------
     -- @brief Toggles the LED at pressdown of button_n during normal execution. 
     --        The LED is immediately disabled at system reset.
     --------------------------------------------------------------------------------
    LED_PROCESS: process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            led_s <= (others => '0');
        elsif (rising_edge(clock)) then
            for i in 0 to NUM_BUTTONS - 1 loop
                if (button_pressed_s2(i) = '1') then
                    led_s(i) <= not led_s(i);
                end if;
            end loop;
        end if;
    end process;

    led <= led_s;
    
end architecture;





