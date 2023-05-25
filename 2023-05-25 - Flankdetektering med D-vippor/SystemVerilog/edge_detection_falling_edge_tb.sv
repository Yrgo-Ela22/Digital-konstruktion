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
module edge_detection_falling_edge_tb();
    typedef enum { false, true } bool;
    localparam CLOCK_PERIOD = 1ns;
    logic clock = 0, reset_n = 1, button_n = 1, led;
    bool sim_finished = false;
    
    /********************************************************************************
     * @brief Creates an instance of the top module and connects the ports to
     *        signals of the same name in this testbench for simulation.
     ********************************************************************************/
    edge_detection_falling_edge simulation(clock, reset_n, button_n, led);
    
    /********************************************************************************
     * @brief Creates an instance of the top module and connects the ports to
     *        signals of the same name in this testbench for simulation.
     ********************************************************************************/
    initial begin: CLOCK_PROCESS
        while (!sim_finished) begin
            clock <= !clock;
            #(CLOCK_PERIOD / 2);
        end 
    end
    
    /********************************************************************************
     * @brief Runs normal execution during 30 clock cycles, followed by system reset 
     *        during 30 clock cycles.
     ********************************************************************************/
    initial begin: RESET_PROCESS
        #(30 * CLOCK_PERIOD);
        reset_n <= 0;
        #(30 * CLOCK_PERIOD);
    end
    
    /********************************************************************************
     * @brief Simulates pressing the button up and down 15 times every fifth 
     *        clock cycle.
     ********************************************************************************/
    initial begin: BUTTON_PROCESS
        for (int i = 0; i < 15; ++i) begin
            #(5 * CLOCK_PERIOD);
            button_n = !button_n;
        end
        sim_finished <= true;
    end 
endmodule 