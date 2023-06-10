/********************************************************************************
 * @brief Component for displaying a number 0 - F on a hex display.
 *
 * @param digit
 *        The digit 0 - 15 to display.
 * @param hex
 *        Hex display for displaying the digit.  
 ********************************************************************************/
module display(input logic[3:0] digit,
               output logic[6:0] hex);

    /********************************************************************************
     * @brief Binary codes for displaying digits 0x0 - 0xF on hex-displays.
     ********************************************************************************/
    localparam DISPLAY_0   = 7'b1000000;
    localparam DISPLAY_1   = 7'b1111001;
    localparam DISPLAY_2   = 7'b0100100;
    localparam DISPLAY_3   = 7'b0110000;
    localparam DISPLAY_4   = 7'b0011001;
    localparam DISPLAY_5   = 7'b0010010;
    localparam DISPLAY_6   = 7'b0000010;
    localparam DISPLAY_7   = 7'b1111000;
    localparam DISPLAY_8   = 7'b0000000;
    localparam DISPLAY_9   = 7'b0010000;
    localparam DISPLAY_A   = 7'b0001000;
    localparam DISPLAY_B   = 7'b0000011;
    localparam DISPLAY_C   = 7'b1000110;
    localparam DISPLAY_D   = 7'b0100001;
    localparam DISPLAY_E   = 7'b0000110;
    localparam DISPLAY_F   = 7'b0001110;
    localparam DISPLAY_OFF = 7'b1111111;
    
    /********************************************************************************
     * @brief Setting new binary code of the hex display at every change of the 
     *        input digit, i.e. changes the digit displayed on the hex display.
     ********************************************************************************/
    always_comb
    begin: OUTPUT_PROCESS
        case (digit)
            0      : hex = DISPLAY_0;
            1      : hex = DISPLAY_1;
            2      : hex = DISPLAY_2;
            3      : hex = DISPLAY_3;
            4      : hex = DISPLAY_4;
            5      : hex = DISPLAY_5;
            6      : hex = DISPLAY_6;
            7      : hex = DISPLAY_7;
            8      : hex = DISPLAY_8;
            9      : hex = DISPLAY_9;
            10     : hex = DISPLAY_A;
            11     : hex = DISPLAY_B;
            12     : hex = DISPLAY_C;
            13     : hex = DISPLAY_D;
            14     : hex = DISPLAY_E;
            15     : hex = DISPLAY_F;
            default: hex = DISPLAY_OFF;
        endcase
    end
endmodule 





