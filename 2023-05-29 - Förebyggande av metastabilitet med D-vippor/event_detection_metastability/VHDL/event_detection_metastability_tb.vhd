--------------------------------------------------------------------------------
-- @brief Testbench for generic design, where an arbitrary number of LEDs are 
--        controlled by a push button each. At pressdown of a specific push 
--        button, the corresponding LED is toggled. All input signals are 
--        synchronized with flip flops in order to prevent metastability.
--
-- @param CLOCK_PERIOD
--        Clock period used for simulation (1 ns).
-- @param NUM_BUTTONS
--        The number of buttons (and LEDs) in the system (default = 3).
-- @param clock
--        System clock (clock period set to 1 ns).
-- @param reset_n
--        Invertering asynchronous reset.
-- @param button_n
--        Inverting push buttons for toggling the LEDs.
-- @param led
--        LEDs toggled at pressdown of corresponding buttons.
-- @param sim_finished
--        Indidicates if simulation is finished (for stopping the system clock).
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity event_detection_metastability_tb is
end entity;

architecture behaviour of event_detection_metastability_tb is
constant CLOCK_PERIOD: time := 1 ns;
constant NUM_BUTTONS : natural := 3;
signal clock         : std_logic := '0';
signal reset_n       : std_logic := '1'; 
signal button_n      : std_logic_vector(NUM_BUTTONS - 1 downto 0) := (others => '1');
signal led           : std_logic_vector(NUM_BUTTONS - 1 downto 0) := (others => '0');
signal sim_finished  : boolean := false;
begin

    --------------------------------------------------------------------------------
    -- @brief Creates an instance of the top module and connects the ports to
    --        signals of the same name in this testbench for simulation.
    --------------------------------------------------------------------------------
    simulation: entity work.event_detection_metastability
    generic map(NUM_BUTTONS)
    port map(clock, reset_n, button_n, led);
    
    --------------------------------------------------------------------------------
    -- @brief Toggles the source clock every half clock period until the simulation
    --        is finished.
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
    -- @brief Tests all combinations of the push buttons one by one, first during
    --        normal executation, then during system reset. All buttons are 
    --        released after every pressdown.
    --------------------------------------------------------------------------------
    BUTTON_PROCESS: process is
    constant MAX_VAL: natural := 2**NUM_BUTTONS-1;
    begin
        for i in 0 to 1 loop
            for i in MAX_VAL downto 0 loop
                button_n <= std_logic_vector(to_unsigned(i, NUM_BUTTONS));
                wait for 5 * CLOCK_PERIOD;
                if (i < MAX_VAL) then
                    button_n <= (others => '1');
                    wait for 5 * CLOCK_PERIOD;
                end if;
            end loop;
            reset_n <= not reset_n;
        end loop;
        sim_finished <= true;
        wait;
    end process;
    
end architecture;