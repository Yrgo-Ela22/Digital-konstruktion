--------------------------------------------------------------------------------
-- @brief Module for synchronize input signals via the double flop technique 
--        to prevent metastability. Postfix s2 indicates that the input signals 
--        have been synchronized via two flip flops.
--            
-- @param NUM_BUTTONS      
--        The number of push buttons.  
-- @param clock            
--        50 MHz system clock.
-- @param reset_n          
--        Inverting reset signal.
-- @param button_n         
--        Inverting push buttons.
-- @param reset_s2_n       
--        Synchronized reset signal.
-- @param button_pressed_s2
--        Event flags indicating button pressdown.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity meta_prev is
    generic(NUM_BUTTONS   : natural range 1 to 3 := 1);
    port(clock, reset_n   : in std_logic;
         button_n         : in std_logic_vector(NUM_BUTTONS - 1 downto 0);
         reset_s2_n       : out std_logic;
         button_pressed_s2: out std_logic_vector(NUM_BUTTONS - 1 downto 0));
end entity;

architecture behaviour of meta_prev is
signal reset_s1_n_s, reset_s2_n_s           : std_logic;
signal button_s1_n, button_s2_n, button_s3_n: std_logic_vector(NUM_BUTTONS - 1 downto 0);
begin

    --------------------------------------------------------------------------------
    -- @brief Process for synchronization of the inverting push button input signals
    --        via flip flops. If a reset occurs, all button signals are immediately 
    --        set. Else the input signals are delayed two clock cycles by passage 
    --        through two flip flops each before being assigned to the corresponding 
    --        synchronized signals.
    --
    --        A third flip flop is used for edge detection of the corresponding 
    --        push button, where the current synchronized input signal (output of 
    --        the second flip flop) is compared with the previous synchronized 
    --        input signal (output of the third flip flop).
    --------------------------------------------------------------------------------
    RESET_PROCESS: process(clock, reset_n) is
    begin
        if (reset_n = '0') then
            reset_s1_n_s <= '0';
            reset_s2_n_s <= '0';
        elsif (rising_edge(clock)) then
            reset_s1_n_s <= '1';
            reset_s2_n_s <= reset_s1_n_s;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief Process for synchronization of the inverting push button input signals
    --        via flip flops. If a reset occurs, all button signals are immediately 
    --        set. Else the input signals are delayed two clock cycles by passage  
    --        through two flip flops each before being assigned to the corresponding 
    --        synchronized signals.
    --
    --        A third flip flop is used for edge detection of the corresponding 
    --        push button, where the current synchronized input signal (output of 
    --        the second flip flop) is compared with the previous synchronized 
    --        input signal (output of the third flip flop).
    --------------------------------------------------------------------------------
    BUTTON_PROCESS: process(clock, reset_s2_n_s) is
    begin
        if (reset_s2_n_s = '0') then
            button_s1_n <= (others => '1');
            button_s2_n <= (others => '1');
            button_s3_n <= (others => '1');
        elsif (rising_edge(clock)) then
            button_s1_n <= button_n;
            button_s2_n <= button_s1_n;
            button_s3_n <= button_s2_n;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief Process for detection of pressdown (falling edge) of each and every 
    --        push button. If the current synchronized input signal (output of the 
    --        second flip flop) is low (button pressed) and the previous 
    --        synchronized input signal (output of the third flip flop) is high 
    --        (button not pressed), a pressdown is detected (on falling edge) and 
    --        the corresponding event flag is set, else it's cleared.                       
    --------------------------------------------------------------------------------
    BUTTON_PRESSED_PROCESS: process(button_s1_n, button_s2_n) is
    begin
        for i in 0 to NUM_BUTTONS - 1 loop
            if (button_s2_n(i) = '0' and button_s3_n(i) = '1') then
                button_pressed_s2(i) <= '1';
            else
                button_pressed_s2(i) <= '0';
            end if;
        end loop;
    end process;
    
    reset_s2_n <= reset_s2_n_s;

end architecture;