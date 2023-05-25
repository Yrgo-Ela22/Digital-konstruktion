--------------------------------------------------------------------------------
-- @brief Toggling a LED at pressdown (falling edge) of an inverting push button.
--
-- @param clock
--        50 MHz system clock.
-- @param reset_n
--        Invertering asynchronous reset.
-- @param button_n
--        Inverting button for toggling the LED.
-- @param led     
--        LED toggled at pressdown of the button.
--
-- Function:
--    - reset_n = 0 (system reset) => led = 0
--    - reset_n = 1 (normal execution) && button_pressed = 1 => led = !led.
-------------------------------------------------------------------------------- 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity event_detection_falling_edge_tb is
end entity;

architecture behaviour of event_detection_falling_edge_tb is
constant CLOCK_PERIOD   : time := 1 ns;
signal clock, led       : std_logic := '0';
signal reset_n, button_n: std_logic := '1';
signal sim_finished     : boolean := false;
begin

    --------------------------------------------------------------------------------
    -- @brief Creates an instance of the top module and connects the ports to
    --        signals of the same name in this testbench for simulation.
    --------------------------------------------------------------------------------
    simulation:  entity work.event_detection_falling_edge
    port map(clock, reset_n, button_n, led);
    
    --------------------------------------------------------------------------------
    -- @brief Toggles the clock every half period until the simulation is finished.
    --------------------------------------------------------------------------------
    CLOCK_PROCESS: process is
    begin
        if (sim_finished = false) then
           clock <= not clock;
           wait for CLOCK_PERIOD / 2;
         else
             wait;
        end if;
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief Keeps reset_n high during 30 clock periods, then low for 30 clock
    --        periods. The process is then halted.
    --------------------------------------------------------------------------------
    RESET_PROCESS: process is
    begin
        wait for 30 * CLOCK_PERIOD;
        reset_n <= '0';
        wait for 30 * CLOCK_PERIOD;
        wait;
    end process;
    
    --------------------------------------------------------------------------------
    -- @brief Toggles the button every fifth clock period 15 times. The process
    --        is then halted and the simulation is finished.
    --------------------------------------------------------------------------------
    BUTTON_PROCESS: process is
    begin
        for i in 0 to 14 loop
            wait for 5 * CLOCK_PERIOD;
            button_n <= not button_n;
        end loop;
        sim_finished <= true;
        wait;
    end process;
    
end architecture;