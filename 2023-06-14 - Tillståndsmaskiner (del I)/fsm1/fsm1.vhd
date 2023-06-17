--------------------------------------------------------------------------------
-- @brief Finite state machine consisting of four states, where a push button 
--        is used to change state to next via pushdown. A LED is enabled in the
--        fourth state, else it's disabled.
--
--        The state machine contists of following states:
--
--        STATE_1 => STATE_2 => STATE_3 => STATE_4 => STATE_1...
--        where 
--            - STATE_1 is the default state.
--            - The LED is enabled in STATE_4, else it's disabled. 
--
-- @param clock
--        50 MHz system clock.
-- @param reset_n
--        Inverting reset signal connected to a push button.
-- @param button_n
--        Inverting push button for changing state to next.
-- @param led
--        LED enabled in STATE_4 of the state machine, else it's disabled.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity fsm1 is
    port(clock, reset_n, button_n: in std_logic;
         led                     : out std_logic);
end entity;

architecture behaviour of fsm1 is

--------------------------------------------------------------------------------
-- @brief Enumeration for the different states of the state machine.
--------------------------------------------------------------------------------
type state_t is (STATE_1, STATE_2, STATE_3, STATE_4);

--------------------------------------------------------------------------------
-- @brief Internal signals in the top module.
--
-- @param reset_s2_n
--        Synchronized reset signal.
-- @param button_pressed_s2
--        Synchronized event flag indicating pressdown of button_n.
-- @param state
--        Stores the current state.
--------------------------------------------------------------------------------
signal reset_s2_n       : std_logic := '1';
signal button_pressed_s2: std_logic := '0';
signal state            : state_t := STATE_1;
begin

    --------------------------------------------------------------------------------
    -- @brief Creates synchronized input signals and performs event detection for
    --        detecting pressdown of the push button.
    --------------------------------------------------------------------------------
    meta_prev1: entity work.meta_prev
    port map(clock, reset_n, button_n, reset_s2_n, button_pressed_s2);

    --------------------------------------------------------------------------------
    -- @brief Changes current state from to next at pressdown of the push button.
    --        At system reset or an errors occurs, current state is set to STATE_1.
    --------------------------------------------------------------------------------
    STATE_PROCESS: process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            state <= STATE_1;
        elsif (rising_edge(clock)) then
            case (state) is
                when STATE_1 =>
                    if (button_pressed_s2 = '1') then
                        state <= STATE_2;
                    end if;
                when STATE_2 =>
                    if (button_pressed_s2 = '1') then
                        state <= STATE_3;
                    end if;
                when STATE_3 =>
                    if (button_pressed_s2 = '1') then
                        state <= STATE_4;
                    end if;
                when STATE_4 =>
                    if (button_pressed_s2 = '1') then
                        state <= STATE_1;
                    end if;
                when others =>
                    state <= STATE_1;
            end case;
        end if;
    end process;

    --------------------------------------------------------------------------------
    -- @brief Enables the LED when current state is STATE_4, else it's disabled.
    --------------------------------------------------------------------------------
    led <= '1' when state = STATE_4 else '0';
    
end architecture;