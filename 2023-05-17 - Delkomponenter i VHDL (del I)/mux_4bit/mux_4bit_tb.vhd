--------------------------------------------------------------------------------
-- mux_4bit_tb.vhd: Testbench for a 4-bit multiplexer.
--
--                   Signals:
--                       - a, b, c, d: One bit inputs.
--                       - s[1:0]    : Selector bits.
--                       - x         : One bit output.
--
--                   Function:
--                       - s[1:0] = 00 => x = a
--                       - s[1:0] = 01 => x = b
--                       - s[1:0] = 10 => x = c
--                       - s[1:0] = 11 => x = d
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_4bit_tb is
end entity;

architecture behaviour of mux_4bit_tb is
signal a, b, c, d, x: std_logic := '0';
signal s            : std_logic_vector(1 downto 0) := (others => '0');
begin

    --------------------------------------------------------------------------------
    -- simulation: Connects ports of the top module to signals of the same name
    --             for simulation in this testbench.
    --------------------------------------------------------------------------------
    simulation: entity work.mux_4bit
    port map(a, b, c, d, s, x);
    
    --------------------------------------------------------------------------------
    -- SIM_PROCESS: Tests all combinations of inputs abcd and selectors s[1:0] one
    --              at a time every 10 ns. Simulation stops when all combinations
    --              have been tested.
    --------------------------------------------------------------------------------
    SIM_PROCESS: process is
    begin
        for i in 0 to 2**6 - 1 loop
            (s(1), s(0), a, b, c, d) <= std_logic_vector(to_unsigned(i, 6));
            wait for 10 ns;
        end loop;
        wait;
    end process;

end architecture;