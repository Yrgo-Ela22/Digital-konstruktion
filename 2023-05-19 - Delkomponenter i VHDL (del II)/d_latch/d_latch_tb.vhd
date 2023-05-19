--------------------------------------------------------------------------------
-- d_latch_tb.vhd: Testbench for a simple D latch without any reset or preset
--                 signals.
--             
--                  Signals:
--                      - d     : Latch input.
--                      - enable: Enable signal for locking/unlocking the output.
--                      - q     : Latch output.
--                      - q_n   : Inverse of the latch output.
--
--                  Function:
--                      - enable = 0 (latch locked) => q = q, q_n = q_n
--                      - enable = 1 (latch open)   => q = d, q_n = !d
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity d_latch_tb is
end entity;

architecture behaviour of d_latch_tb is
signal d, enable, q, q_n: std_logic := '0';
begin

    simulation: entity work.d_latch
    port map(d, enable, q, q_n);
    
    SIM_PROCESS: process is
    begin
        for i in 0 to 3 loop
            (enable, d) <= std_logic_vector(to_unsigned(i, 2));
            wait for 10 ns;
        end loop;
        wait;
    end process;

end architecture;