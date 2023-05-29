/******************************************************************************** 
 * @brief Module for syncronizing input signals by letting them pass through two 
 *        flip flops each in order to stabilize the input signals and therefore 
 *        preventing metastability. The synchronized signals are marked s2, 
 *        indicating synchronization with two flip flops each.
 *
 *        The input signals consists of an inverting reset signal and an
 *        arbitrary number of inverting push buttons. Pressdown of the push 
 *        buttons is detected via edge detection on falling edge.
 *
 * @param NUM_BUTTONS
 *        The number of buttons (default = 1).
 * @param clock
 *        50 MHz source clock.
 * param reset_n
 *        Inverting reset signal.
 * @param button_n[NUM_BUTTONS-1:0]
 *        Inverting push buttons.
 * @param reset_s2_n
 *        Synchronized reset signal.
 * @param button_pressed_s2[NUM_BUTTONS-1:0]
 *        Event flags indicating pressdown for each and every push button.
 ********************************************************************************/
module meta_prev #(byte unsigned NUM_BUTTONS = 1)
                  (input logic clock, reset_n,
                   input logic[NUM_BUTTONS-1:0] button_n,
                   output logic reset_s2_n,
                   output logic[NUM_BUTTONS-1:0] button_pressed_s2);

    logic reset_s1_n;
    logic[NUM_BUTTONS-1:0] button_s1_n, button_s2_n, button_s3_n;
    
    /******************************************************************************** 
     * @brief Process for synchronization of the inverting reset signal via flip 
     *        flops. If a reset occurs, the synchronized reset signal and the output 
     *        of the flip flops are immediately cleared. Else the input reset signal
     *        is delayed two clock cycles by passage through two flip flops before 
     *        being assigned to the synchronized reset signal.
     ********************************************************************************/
    always_ff @ (posedge clock or negedge reset_n)
    begin: RESET_PROCESS
        if (!reset_n) begin
            reset_s1_n <= 0;
            reset_s2_n <= 0;
        end else begin
            reset_s1_n <= 1;
            reset_s2_n <= reset_s1_n;
        end
    end
    
    /******************************************************************************** 
     * @brief Process for synchronization of the inverting push button input signals
     *        via flip flops. If a reset occurs, all button signals are immediately 
     *        set. Else the input signals are delayed two clock cycles by passage 
     *        through two flip flops each before being assigned to the corresponding 
     *        synchronized signals.
     *
     *        A third flip flop is used for edge detection of the corresponding 
     *        push button, where the current synchronized input signal (output of 
     *        the second flip flop) is compared with the previous synchronized 
     *        input signal (output of the third flip flop).
     ********************************************************************************/
    always_ff @ (posedge clock or negedge reset_s2_n)
    begin: BUTTON_PROCESS
        if (!reset_s2_n) begin
            button_s1_n <= {NUM_BUTTONS{1'b1}};
            button_s2_n <= {NUM_BUTTONS{1'b1}};
            button_s3_n <= {NUM_BUTTONS{1'b1}};
        end else begin
            button_s1_n <= button_n;
            button_s2_n <= button_s1_n;
            button_s3_n <= button_s2_n;
        end
    end
    
    /******************************************************************************** 
     * @brief Process for detection of pressdown (falling edge) of each and every 
     *        push button. If the current synchronized input signal (output of the 
     *        second flip flop) is low (button pressed) and the previous synchronized 
     *        input signal (output of the third flip flop) is high (button not 
     *        pressed), a pressdown is detected (on falling edge) and the 
     *        corresponding event flag is set, else it's cleared.                     
     ********************************************************************************/
    always_ff @ (posedge clock or negedge reset_s2_n)
    begin: BUTTON_PRESSED_PROCESS
        if (!reset_s2_n) begin
            button_pressed_s2 <= 0;
        end else begin
            for (byte unsigned i = 0; i < NUM_BUTTONS; ++i) begin
                if (button_s2_n[i] == 0 && button_s3_n[i] == 1) begin
                    button_pressed_s2[i] <= 1;
                end else begin
                    button_pressed_s2[i] <= 0;
                end
            end
        end
    end
endmodule 