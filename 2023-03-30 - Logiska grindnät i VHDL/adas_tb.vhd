--------------------------------------------------------------------------------
-- adas_tb.vhd: Testbench for ADAS (Advanced Driver Assistance System) for
--              engine break assistance.
--         
--              Signals:
--                 - driver      : Break signal from driver (break pedal).
--                 - camera      : Camera sensing objects in front of the car.
--                 - sensor      : Sensor indicating an object is approaching.
--                 - adas_ok     : Indicates if ADAS is working correctly.
--                 - engine_break: Output signal for engine break.
--
--              If the driver breaks or the camera senses an object in front 
--              of the car and the sensor is indicating that the object is 
--              approaching, the engine break is enabled. If ADAS isn't
--              working correctly, the camera and sensor signals are ignored.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adas_tb is
end entity;

architecture behaviour of adas_tb is
signal driver, camera, sensor, adas_ok, engine_break: std_logic := '0';
begin

   --------------------------------------------------------------------------------
   -- adas_sim: Creates adas object and connects ports to signals of the same name
   --           in this test bench for simulation. 
   --------------------------------------------------------------------------------
   adas_sim: entity work.adas
   port map(driver, camera, sensor, adas_ok, engine_break);
   
   --------------------------------------------------------------------------------
   -- SIMULATION_PROCESS: Simulates all 16 combinations 0000 - 1111 of input
   --                     signals (driver, camera, sensor and adas_ok) of the
   --                     adas module one by one during 10 ns each. The process
   --                     is halted once the simulation is finished.
   --------------------------------------------------------------------------------
   SIMULATION_PROCESS: process is
   variable number: std_logic_vector(3 downto 0);
   begin
      for i in 0 to 15 loop 
         number  := std_logic_vector(to_unsigned(i, 4)); 
         driver  <= number(3);
         camera  <= number(2);
         sensor  <= number(1);
         adas_ok <= number(0);
         wait for 10 ns;
      end loop;
      wait;
   end process;

end architecture;