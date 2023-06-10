/********************************************************************************
 * @brief Design where two hex displays each displays a hexadecimal digit
 *        0x0 - 0xF. Via a push button each, incrementation of the digit
 *        displayed is toggled between enabled and disabled. As default, 
 *        incrementation is disabled and the digit 0 is displayed.
 *
 * @param clock
 *        50 MHz system clock.
 * @param reset_n
 *        Inverting reset signal connected to a push button.
 * @param button_n
 *        Inverting push buttons for toggling incrementation of the displays.
 * @param hex1
 *        Hex display incremented every 1000 ms when incrementation is enabled.
 * @param hex0
 *        Hex display incremented every 100 ms when incrementation is enabled.
 ********************************************************************************/
import misc::*;

module timed_display(input logic clock, reset_n,
                     input logic[1:0] button_n,
                     output logic[6:0] hex1, hex0);
         
    /******************************************************************************** 
     * @brief Signals used in the top module.
     *
     * @param reset_s2_n   
     *        Synchronized inverting reset signal used for the design.
     * @param button_pressed_s2
     *        Synchronized event flags indicating pressdown the buttons.
     * @param timer_enabled
     *        Enable signals for the two timers.
     * @param timer_elapsed
     *        Event flags for the timers indicating if they have elapsed.
     * param counter
     *       Array consisting of two 4-bit counters (range 0 - 15).
     ********************************************************************************/
    logic reset_s2_n = 1;            
    logic[1:0] button_pressed_s2 = 0;
    logic[1:0] timer_enabled = 0;
    logic[1:0] timer_elapsed = 0;
    logic[3:0] counter[1:0];
    
    /******************************************************************************** 
     * @brief Synchronizes all input signals with two flip flops each in order
     *        to prevent metastability. All buttons are also detected for pressdown.
     ********************************************************************************/
     meta_prev #(.NUM_BUTTONS(2)) 
     meta_prev1 (clock, reset_n, button_n, reset_s2_n, button_pressed_s2);
    
    /******************************************************************************** 
     * @brief Creates a timer that elapses every 100 ms (frequency set to 10 Hz).
     ********************************************************************************/
     timer #(FREQUENCY_10HZ) 
     timer0 (clock, reset_s2_n, timer_enabled[0], timer_elapsed[0]);
    
    /******************************************************************************** 
     * @brief Creates a timer that elapses every 1000 ms (frequency set to 1 Hz).
     ********************************************************************************/
     timer timer1 (clock, reset_s2_n, timer_enabled[1], timer_elapsed[1]);
    
    /******************************************************************************** 
     * @brief Displays the value of the first counter at hex0. The value is 
     *        updated every 100 ms when the corresponding timer is enabled.
     ********************************************************************************/
     display display0 (counter[0], hex0);
    
    /******************************************************************************** 
     * @brief Displays the value of the second counter at hex1. The value is 
     *        updated every 1000 ms when the corresponding timer is enabled.
     ********************************************************************************/
     display display1 (counter[1], hex1);
    
    /******************************************************************************** 
     * @brief Toggles each timer at pressdown of the corresponding button. 
     *        If a system reset occurs, all timers are immediately disabled.
     ********************************************************************************/
    always_ff @ (posedge clock or negedge reset_s2_n)
    begin: TIMER_PROCESS
        if (!reset_s2_n) begin
            timer_enabled <= 0;
        end else begin
            for (byte unsigned i = 0; i < 2; ++i) begin
                if (button_pressed_s2[i]) begin
                    timer_enabled[i] <= !timer_enabled[i];
                end
            end 
        end
    end
    
    /******************************************************************************** 
     * @brief Increments each counter when the corresponding timer elapses.
     *        If a system reset occurs, all counters are immediately cleared.
     ********************************************************************************/
    always_ff @ (posedge clock or negedge reset_s2_n)
    begin: COUNTER_PROCESS
        if (!reset_s2_n) begin
            for (byte unsigned i = 0; i < 2; ++i) begin
                counter[i] <= 0;
            end
        end else begin
            for (byte unsigned i = 0; i < 2; ++i) begin
                if (timer_elapsed[i]) begin
                    if (counter[i] < 15) begin
                        counter[i] <= counter[i] + 1;
                    end else begin
                        counter[i] <= 0;
                    end
                end
            end
        end
    end  
endmodule 