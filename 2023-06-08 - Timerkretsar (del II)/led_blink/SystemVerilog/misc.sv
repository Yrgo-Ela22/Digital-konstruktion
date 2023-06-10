/********************************************************************************
 * @brief Contains miscellaneous constant used for the design.
 ********************************************************************************/
package misc;

/********************************************************************************
 * @brief Constants used for setting the frequency of timer circuits between
 *        1 - 100 Hz (based on a 50 MHz system clock).
 ********************************************************************************/
localparam FREQUENCY_100HZ = 500000;               /* 100 Hz */
localparam FREQUENCY_50HZ  = FREQUENCY_100HZ * 2;  /* 50 Hz */
localparam FREQUENCY_20HZ  = FREQUENCY_100HZ * 5;  /* 50 Hz */
localparam FREQUENCY_10HZ  = FREQUENCY_100HZ * 10; /* 50 Hz */
localparam FREQUENCY_5HZ   = FREQUENCY_10HZ * 2;   /* 50 Hz */
localparam FREQUENCY_2HZ   = FREQUENCY_10HZ * 5;   /* 50 Hz */
localparam FREQUENCY_1HZ   = FREQUENCY_10HZ * 10;  /* 50 Hz */
endpackage 