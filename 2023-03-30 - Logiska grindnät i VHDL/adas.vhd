--------------------------------------------------------------------------------
-- adas.vhd: Implementation of ADAS (Advanced Driver Assistance System) for
--           engine break assistance.
--         
--           Inputs:
--              - driver      : Break signal from driver (break pedal).
--              - camera      : Camera sensing objects in front of the car.
--              - sensor      : Sensor indicating an object is approaching.
--              - adas_ok     : Indicates if ADAS is working correctly.
--           Outputs:
--              - engine_break: Output signal for engine break.
--
--           If the driver breaks or the camera senses an object in front 
--           of the car and the sensor is indicating that the object is 
--           approaching, the engine break is enabled. If ADAS isn't working
--           correctly, the camera and sensor signals are ignored.
--
--           Hardware implemented for FPGA card Terasic DE0.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity adas is
   port(driver, camera, sensor, adas_ok: in std_logic; 
        engine_break                   : out std_logic);
end entity;

architecture behaviour of adas is
signal adas_break: std_logic;
begin

   adas_break   <= camera and sensor and adas_ok;
   engine_break <= driver or adas_break;

end architecture;