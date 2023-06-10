/********************************************************************************
 * @brief Digital system where three LEDs are toggled between blinkning with 
 *        different frequencies and being disabled via pressdown of a 
 *        corresponding push button. All input signals are synchronized with
 *        flip flops in order to prevent metastability.
 *
 * @param clock
 *        50 MHz system clock.
 * @param reset_n
 *        Invertering asynchronous reset.
 * @param button_n
 *        Inverting push buttons for toggling the LEDs.
 * @param led
 *        LEDs toggled at pressdown of the corresponding button.
 ********************************************************************************/
import misc::*;
     
module led_blink(input logic clock, reset_n,
                 input logic[2:0] button_n,
                 output logic[2:0] led);
                 
    logic[2:0] button_pressed_s2 = 0; /* Event flags indicating pressdown of the buttons. */
    logic[2:0] led_s = 0;             /* Signals containing the values of the LEDs. */
    logic[2:0] timer_enabled = 0;     /* Signals for enabling/disabling the timers. */
    logic[2:0] timer_elapsed = 0;     /* Signals indicating if the timers have elapsed. */
    logic reset_s2_n = 1;             /* Synchronized inverting reset signal. */
    
    /********************************************************************************
     * @brief Synchronizes all input signals with two flip flops each in order
     *        to prevent metastability. All buttons are also detected for pressdown.
     ********************************************************************************/
    meta_prev #(.NUM_BUTTONS(3)) 
    meta_prevention (clock, reset_n, button_n, reset_s2_n, button_pressed_s2);
    
    /********************************************************************************
     * @brief Creates a timer that elapses every 100 ms (frequency set to 10 Hz).
     ********************************************************************************/
    timer #(FREQUENCY_10HZ) timer0 (clock, reset_s2_n, timer_enabled[0], timer_elapsed[0]);
     
    /********************************************************************************
     * @brief Creates a timer that elapses every 200 ms (frequency set to 5 Hz).
     ********************************************************************************/
     timer #(FREQUENCY_5HZ) timer1 (clock, reset_s2_n, timer_enabled[1], timer_elapsed[1]);
     
    /********************************************************************************
     * @brief Creates a timer that elapses every 1000 ms (frequency set to 1 Hz).
     ********************************************************************************/
    timer timer2 (clock, reset_s2_n, timer_enabled[2], timer_elapsed[2]);
     
    /********************************************************************************
     * @brief Toggles each timer at pressdown of the corresponding button. 
     *        If a system reset occurs, all timers are immediately disabled.
     ********************************************************************************/
    always_ff @ (posedge clock or negedge reset_s2_n) 
    begin: TIMER_PROCESS
        if (!reset_s2_n) begin
            timer_enabled <= 0;
        end else begin
            for (byte unsigned i = 0; i < 3; ++i) begin
                if (button_pressed_s2[i]) begin
                    timer_enabled[i] = !timer_enabled[i];
                end
            end
        end
    end
     
    /********************************************************************************
     * @brief Toggles each LED every time the corresponding timer has elapsed.
     *        If a system reset occurs, all LEDs are immediately disabled.
     ********************************************************************************/
    always_ff @ (posedge clock or negedge reset_s2_n)
    begin: LED_PROCESS
         if (!reset_s2_n) begin
             led_s <= 0;
         end else begin
             for (byte unsigned i = 0; i < 3; ++i) begin
                 if (timer_elapsed[i]) begin
                     led_s[i] <= !led_s[i];
                 end
             end
         end
    end
    
    assign led = led_s; /* The LEDs are continuously assigned the values of the led_s signal. */
    
endmodule 