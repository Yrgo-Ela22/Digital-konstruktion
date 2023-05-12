--------------------------------------------------------------------------------
-- mux_2bit.vhd: Implementation of a 2-bit multiplexer.
--
--               Inputs:
--                   - s, a, b: One bit inputs, where s is the selector.
--               Outputs:
--                   - x      : One bit output.
--
--               Function:
--                    - s = 0 => x = a
--                    - s = 1 => x = b
--
--               Hardware configured for FPGA card Terasic DE0.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity mux_2bit is
    port(s, a, b: in std_logic;
         x      : out std_logic);
end entity;

architecture behaviour of mux_2bit is
begin
    process (s, a, b) is
	 begin
	    case (s) is
		    when '0'    => x <= a;
			 when '1'    => x <= b;
			 when others => x <= '0';
		 end case;
	 end process;
end architecture;