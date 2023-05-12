--------------------------------------------------------------------------------
-- mux_2bit_tb.vhd: Testbench for a 2-bit multiplexer.
--
--                   Signals:
--                       - s, a, b: One bit inputs, where s is the selector.
--                       - x      : One bit output.
--
--                   Function:
--                       - s = 0 => x = a
--                       - s = 1 => x = b
--
--                   Each combination 000 - 111 of inputs sab is tested during 
--                   10 ns each, therefore a total simulation time of 80 ns.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_2bit_tb is
end entity;

architecture behaviour of mux_2bit_tb is
signal s, a, b, x: std_logic := '0';
begin

    --------------------------------------------------------------------------------
    -- simulation: Connects signals sabx to ports of the same name in the top module.
    --------------------------------------------------------------------------------
    simulation: entity work.mux_2bit
    port map(s, a, b, x);
    
    --------------------------------------------------------------------------------
    -- SIM_PROCESS: Tests all combinations 000 - 111 of input sab via a for-loop.
    --              The value of integer i (0 - 7) is converted to binary form
    --              and is assigned to variable input. After 10 ns, the next
    --              combination is tested.
    --------------------------------------------------------------------------------
    SIM_PROCESS: process is
    begin
       for i in 0 to 7 loop
           (s, a, b) <= std_logic_vector(to_unsigned(i, 3));
           wait for 10 ns;
       end loop;
       wait;
    end process;

end architecture;