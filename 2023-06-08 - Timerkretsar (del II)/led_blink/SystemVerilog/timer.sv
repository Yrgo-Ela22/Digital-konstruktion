/********************************************************************************
 * @brief Module for constructing timers capable of frequencies between 
 *       12 mHz - 50 Mhz. As default a frequency of 1 Hz is used.
 *
 * @param FREQUENCY
 *        The timer frequency implemented as a max value based on a 50 MHz 
 *        system clock (default = 1 Hz).
 * @param clock
 *        50 MHz system clock.
 * @param reset_s2_n
 *        Synchronized inverting reset signal.
 * @param enabled
 *        Indicates if the timer is enabled (else the timer never elapses).
 * @param elapsed
 *        Event flag indicating when the timer has elapsed.
 ********************************************************************************/
import misc::*;
 
module timer #(int unsigned FREQUENCY = FREQUENCY_1HZ)
              (input logic clock, reset_s2_n, enabled,
               output logic elapsed);
             
    localparam MAX_COUNT = FREQUENCY; /* The max count value of the timer. */
    logic[31:0] counter;              /* Counter incremented from 0 - MAX_COUNT. */
    
    /********************************************************************************
     * @brief Increments the counter at every clock pulse if the timer is enabled. 
     *        When the counter value is equal to the specified max count value, 
     *        the timer has elapsed. If a system reset occurs, the counter is 
     *        immediately cleared.
     ********************************************************************************/
    always_ff @ (posedge clock or negedge reset_s2_n) 
    begin: COUNTER_PROCESS
        if (!reset_s2_n) begin
            counter <= 0;
            elapsed <= 0;
        end else begin
            if (enabled) begin
                if (counter < MAX_COUNT) begin
                    counter <= counter + 1;
                    elapsed <= 0;
            end else begin
                    counter <= 0;
                    elapsed <= 1;
                end
            end else begin
                elapsed <= 0;
            end
        end
    end
endmodule 