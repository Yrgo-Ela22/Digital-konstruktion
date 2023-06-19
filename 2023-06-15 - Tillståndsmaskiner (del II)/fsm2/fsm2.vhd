--------------------------------------------------------------------------------
-- @brief Finite state machine consisting of four states, where push buttons
--        are used to change state to next or previous via pushdown. A LED is 
--        enabled in the fourth state, else it's disabled.
--
-- @param clock
--        50 MHz system clock.
-- @param reset_n
--        Inverting reset signal connected to a push button.
-- @param button_n
--        Inverting push buttons for changing state to next or previous.
-- @param led
--        LED enabled in STATE_4 of the state machine, else it's disabled.
--
--        The state machine contists of following states:
--
--        STATE_1 => STATE_2 => STATE_3 => STATE_4
--        where 
--            - STATE_1 is the default state.
--            - The LED is enabled in STATE_4, else it's disabled. 
--
--        button_n(0) is used to change state to next between 
--        STATE_1 - STATE_4, while button_n(1) is used to change state
--        between STATE_4 back to STATE_1.
--
--        The states are updated as follows:
--        1. If state == STATE_1:
--               - If button_n(0) is pressed     => state = STATE_2
--        2. If current state is STATE_2:
--              - If button_n(0) is pressed      => state = STATE_3
--              - Else if button_n(1) is pressed => state = STATE_1
--        3. If current state is STATE_3:
--              - If button_n(0) is pressed        => state = STATE_4
--              - Else if button_n(1) is pressed   => state = STATE_2
--        3. If current state is STATE_4:
--              - If button_n(1) is pressed => state = STATE_3
--
--        - If a system reset occurs, the state is set to STATE_1.
--        - If both buttons are pressed at the same, current state is
--          unchanged.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity fsm2 is
    port(clock, reset_n: in std_logic;
         button_n      : in std_logic_vector(1 downto 0);
         led           : out std_logic);
end entity;

architecture behaviour of fsm2 is

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
--        Synchronized event flags indicating pressdown of the push buttons.
-- @param next_state
--        Indicates that the current state shall be updated to next.
-- @param previous_state
--        Indicates that the current state shall be updated to previous.
-- @param state
--        Stores the current state.
--------------------------------------------------------------------------------
signal reset_s2_n       : std_logic := '1';
signal button_pressed_s2: std_logic_vector(1 downto 0) := (others => '0');
signal next_state       : std_logic := '0';
signal previous_state   : std_logic := '0';
signal state            : state_t := STATE_1;
begin

    --------------------------------------------------------------------------------
    -- @brief Creates synchronized input signals and performs event detection for
    --        detecting pressdown of the push buttons.
    --------------------------------------------------------------------------------
    meta_prev1: entity work.meta_prev
    generic map(NUM_BUTTONS => 2)
    port map(clock, reset_n, button_n, reset_s2_n, button_pressed_s2);
    
    --------------------------------------------------------------------------------
    -- @brief Changes current state from at pressdown of one of the push buttons.
    --        At system reset or an errors occurs, current state is set to STATE_1.
    --------------------------------------------------------------------------------
    STATE_PROCESS: process(clock, reset_s2_n) is
    begin
        if (reset_s2_n = '0') then
            state <= STATE_1;
        elsif (rising_edge(clock)) then
            case (state) is
                when STATE_1 =>
                    if (next_state = '1') then
                        state <= STATE_2;
                    end if;
                when STATE_2 =>
                    if (next_state = '1') then
                        state <= STATE_3;
                    elsif (previous_state = '1') then
                        state <= STATE_1;
                    end if;
                when STATE_3 =>
                    if (next_state = '1') then
                        state <= STATE_4;
                    elsif (previous_state = '1') then
                        state <= STATE_2;
                    end if;
                when STATE_4 =>
                    if (previous_state = '1') then
                        state <= STATE_3;
                    end if;
                when others =>
                    state <= STATE_1;
            end case;
        end if;
    end process;
    
    next_state <= button_pressed_s2(0) and not button_pressed_s2(1);
    previous_state <= button_pressed_s2(1) and not button_pressed_s2(0);
    led <= '1' when state = STATE_4 else '0';

end architecture;