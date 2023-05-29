/********************************************************************************
 * @brief Testbench for generic design, where an arbitrary number of LEDs are 
 *        controlled by a push button each. At pressdown of a specific push 
 *        button, the corresponding LED is toggled. All input signals are 
 *        synchronized with flip flops in order to prevent metastability.
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
module event_detection_metastability_tb();
    typedef enum { false, true } bool;
    localparam CLOCK_PERIOD = 1ns;
    logic clock = 0, reset_n = 1; 
    logic[2:0] button_n = 3'b111, led;
    bool sim_finished = false;
    
    /********************************************************************************
     * @brief Creates an instance of the top module and connects the ports to
     *        signals of the same name in this testbench for simulation.
     ********************************************************************************/
    event_detection_metastability #(.NUM_BUTTONS(3)) 
    simulation(.clock, .reset_n, .button_n, .led);
    
    /********************************************************************************
     * @brief Toggles the source clock every half clock period until the simulation
     *        is finished.
     ********************************************************************************/
    initial begin: CLOCK_PROCESS
        while (!sim_finished) begin
            clock <= !clock;
            #(CLOCK_PERIOD / 2);
        end 
    end
    
    /********************************************************************************
     * @brief Tests all combinations of the push buttons one by one, first during
     *        normal executation, then during system reset.
     ********************************************************************************/
    initial begin: BUTTON_PROCESS
        for (byte unsigned i = 0; i < 2; ++i) begin
            for (byte unsigned j = 0; j < 8; ++j) begin
                button_n <= 7 - j;
                #(5 * CLOCK_PERIOD);
                if (j > 0) begin
                    button_n <= 3'b111;
                    #(5 * CLOCK_PERIOD);
                end
            end
        end
        sim_finished <= true;
    end
endmodule 