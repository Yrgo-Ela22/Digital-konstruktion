--------------------------------------------------------------------------------
-- comparator_4bit.vhd: Implementation of a 4-bit comparator.
--
--                      Inputs:
--                          - abcd: Single bit inputs.
--                      Outputs:
--                          - xyz : Single bit outputs.
--
--                      The comparator works as follows:
--                          ab > cd => xyz = 100
--                          ab = cd => xyz = 010
--                          ab < cd => xyz = 001
--
--                      Hardware implemented for FPGA card Terasic DE0.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity comparator_4bit is
    port(a, b, c, d: in std_logic;
         x, y, z   : out std_logic);
end entity;

architecture behaviour of comparator_4bit is
signal input : std_logic_vector(3 downto 0);
signal output: std_logic_vector(2 downto 0);
begin
    process(input) is
    begin
        case (input) is
            when "0000" => output <= "010";
            when "0001" => output <= "001";
            when "0010" => output <= "001";
            when "0011" => output <= "001";
            when "0100" => output <= "100";
            when "0101" => output <= "010";
            when "0110" => output <= "001";
            when "0111" => output <= "001";
            when "1000" => output <= "100";
            when "1001" => output <= "100";
            when "1010" => output <= "010";
            when "1011" => output <= "001";
            when "1100" => output <= "100";
            when "1101" => output <= "100";
            when "1110" => output <= "100";
            when "1111" => output <= "010";
            when others => output <= "000";
        end case;
    end process;
    
    input <= (a, b, c, d); 
    (x, y, z) <= output;
end architecture;