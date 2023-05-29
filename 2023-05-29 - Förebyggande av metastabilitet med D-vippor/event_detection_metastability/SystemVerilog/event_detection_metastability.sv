/********************************************************************************
 * @brief Generic design, where an arbitrary number of LEDs are controlled by
 *        a push button each. At pressdown of a specific push button, the
 *        corresponding LED is toggled. All input signals are synchronized with
 *        flip flops in order to prevent metastability.
 *
 * @param NUM_BUTTONS
 *        The number of buttons (and LEDs) in the system (default = 3).
 * @param clock
 *        50 MHz system clock.
 * @param reset_n
 *        Invertering asynchronous reset.
 * @param button_n[NUM_BUTTONS-1:0]
 *        Inverting push buttons for toggling the LEDs.
 * @param led[NUM-BUTTONS-1:0]
 *        LEDs toggled at pressdown of the corresponding button.
 ********************************************************************************/
module event_detection_metastability #(byte unsigned NUM_BUTTONS = 3)
                                      (input logic clock, reset_n,
                                       input logic[NUM_BUTTONS-1:0] button_n,
                                       output logic[NUM_BUTTONS-1:0] led);
                                       
    logic reset_s2_n;                         /* Synchronized inverting reset signal. */
    logic[NUM_BUTTONS-1:0] button_pressed_s2; /* Indicates pressdown of each button. */
    logic[NUM_BUTTONS-1:0] led_s = 0;         /* Contains the value of each LED. */
    
    /********************************************************************************
     * @brief Synchronizes all input signals with two flip flops each in order
     *        to prevent metastability. All buttons are also detected for pressdown.
     ********************************************************************************/
    meta_prev #(NUM_BUTTONS) 
    meta_prevention(clock, reset_n, button_n, reset_s2_n, button_pressed_s2);
    
    /********************************************************************************
     * @brief Sets the output of the LEDs. If a specific button is pressed, the 
     *        corresponding LED is toggled. At system reset, the LED is disabled.
     ********************************************************************************/
    always_ff @ (posedge clock or negedge reset_s2_n)
    begin: LED_PROCESS
        if (!reset_s2_n) begin
            led_s <= 0;
        end else begin
            for (byte unsigned i = 0; i < NUM_BUTTONS; ++i) begin
                if (button_pressed_s2[i]) begin
                    led_s[i] <= !led_s[i];
                end
            end
        end
    end
    
    assign led = led_s;
endmodule 