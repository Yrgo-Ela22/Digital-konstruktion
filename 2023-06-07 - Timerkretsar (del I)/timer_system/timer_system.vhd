--------------------------------------------------------------------------------
-- @brief Digital system where three LEDs are toggled with different frequencies
--        via three different timer circuits.
--
-- @param clock
--        50 MHz system clock.
-- @param reset_n
--        Inverting asynchronous reset signal.
-- @param led
--        LEDs toggled via the timers.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.misc.all;

entity timer_system is
    port(clock, reset_n: in std_logic;
         led           : out std_logic_vector(2 downto 0));
end entity;

--------------------------------------------------------------------------------
-- @brief Creates synchronized reset signal and three timers for toggling
--        the LEDs every 100 ms, 200 ms and 1000 ms respectively.
--
-- @param reset_s1_n
--        Signal used for synchronizing reset_n, used to create a flip flop
--        containing the unstable condition (if a metastable condition occurs).
-- @param reset_s2_n
--        Synchronized inverting reset signal that shall be used in the rest 
--        of the design instead or reset_n to prevent metastability.
-- @param led_s
--        Signals containing the values of the LEDs, i.e. the internal
--        versions of the led outputs. These signals are used since outputs
--        cannot be read in VHDL-93, hence the led outputs cannot be used 
--        for toggling.
--------------------------------------------------------------------------------
architecture behaviour of timer_system is
signal reset_s1_n, reset_s2_n: std_logic := '1';
signal timer_elapsed         : std_logic_vector(2 downto 0) := (others => '0');
signal led_s                 : std_logic_vector(2 downto 0) := (others => '0');
begin

    --------------------------------------------------------------------------------
    -- @brief Creates a timer that elapses every 100 ms (frequency set to 10 Hz).
    --------------------------------------------------------------------------------
    timer0: entity work.timer
    generic map(FREQUENCY => FREQUENCY_10HZ)
    port map(clock, reset_n, timer_elapsed(0));
    
    --------------------------------------------------------------------------------
    -- @brief Creates a timer that elapses every 200 ms (frequency set to 5 Hz).
    --------------------------------------------------------------------------------
    timer1: entity work.timer
    generic map(FREQUENCY => FREQUENCY_5HZ)
    port map(clock, reset_n, timer_elapsed(1));
    
    --------------------------------------------------------------------------------
    -- @brief Creates a timer that elapses every 1000 ms (frequency set to 1 Hz).
    --------------------------------------------------------------------------------
    timer2: entity work.timer
    port map(clock, reset_n, timer_elapsed(2));

    --------------------------------------------------------------------------------
    -- @brief Synchronizes the reset signal via the double flop technique to
    --        prevent metastability. The synchronized reset signal reset_s2_n
    --        shall be used in the rest of the design. 
    --------------------------------------------------------------------------------
    RESET_SYNC_PROCESS: process(clock, reset_n) is
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
    -- @brief Toggles each LED every time the corresponding timer has elapsed.
    --        If a system reset occurs, all LEDs are immediately disabled.
    --------------------------------------------------------------------------------
    LED_PROCESS: process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            led_s <= (others => '0');
        elsif (rising_edge(clock)) then
            for i in 0 to 2 loop
                if (timer_elapsed(i) = '1') then
                    led_s(i) <= not led_s(i);
                end if;
            end loop;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief The led outputs are continuously assigned the value of the internal
    --        led signals.
    --------------------------------------------------------------------------------
    led <= led_s;

end architecture;