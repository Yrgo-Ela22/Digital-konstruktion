--------------------------------------------------------------------------------
-- mux_4bit.vhd: Implementation of a 4-bit multiplexer.
--
--               Inputs:
--                   - a, b, c, d: One bit inputs.
--                   - s[1:0]    : Selector bits.
--               Outputs:
--                   - x         : One bit output.
--
--               Function:
--                    - s[1:0] = 00 => x = a
--                    - s[1:0] = 01 => x = b
--                    - s[1:0] = 10 => x = c
--                    - s[1:0] = 11 => x = d
--
--               Hardware configured for FPGA card Terasic DE0.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity mux_4bit is
    port(a, b, c, d: in std_logic;
         s         : in std_logic_vector(1 downto 0);
         x         : out std_logic);
end entity;

architecture behaviour of mux_4bit is
begin

    --------------------------------------------------------------------------------
    -- simulation: Connects ports of the top module to signals of the same name
    --             for simulation in this testbench.
    --------------------------------------------------------------------------------
    SELECTION_PROCESS: process(a, b, c, d, s) is
    begin
        case (s) is
            when "00"   => x <= a;
            when "01"   => x <= b;
            when "10"   => x <= c;
            when "11"   => x <= d;
            when others => x <= '0';
        end case;
    end process;
end architecture;