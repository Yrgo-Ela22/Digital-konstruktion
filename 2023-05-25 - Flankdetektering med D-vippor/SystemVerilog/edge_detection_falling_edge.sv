/********************************************************************************
 * @brief Toggling a LED at pressdown (falling edge) of an inverting push button.
 *
 * @param clock
 *        50 MHz system clock.
 * @param reset_n
 *        Invertering asynchronous reset.
 * @param button_n
 *        Inverting button for toggling the LED.
 * @param led     
 *        LED toggled at pressdown of the button.
 *
 * Function:
 *    - reset_n = 0 (system reset) => led = 0
 *    - reset_n = 1 (normal execution) && button_pressed = 1 => led = !led.
 ********************************************************************************/
module edge_detection_falling_edge(input logic clock, reset_n, button_n, 
                                   output logic led);                                  
    logic button_pressed = 0, button_n_previous = 1, led_s = 0;
    
    /********************************************************************************
     * @brief Detects falling edge (pressdown) of button_n, i.e. current value = 0
     *        and previous value = 1. Then the signal button_pressed is set, else
     *        it's cleared.
     ********************************************************************************/
    always_ff @ (posedge clock or negedge reset_n)
    begin: BUTTON_PROCESS
        if (!reset_n) begin
            button_pressed <= 0;
            button_n_previous <= 1;
        end else begin
            if (button_n == 0 && button_n_previous == 1) begin
                button_pressed <= 1;
            end else begin
                button_pressed <= 0;
            end
            button_n_previous <= button_n;
        end
    end
    
    /********************************************************************************
     * @brief Sets the output of the LED. If the button is pressed, the LED is 
     *        toggled. At system reset, the LED is disabled.
     ********************************************************************************/
    always_ff @ (posedge clock or negedge reset_n)
    begin: LED_PROCESS
        if (!reset_n) begin
            led_s <= 0;
        end else begin
            if (button_pressed) begin
                led_s <= !led_s;
            end
        end
    end
    
    assign led = led_s;
endmodule 