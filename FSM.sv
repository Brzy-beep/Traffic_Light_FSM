`timescale 1ns / 1ps



module TRAFFIC_LIGHT_FSM (
    input  logic clk,
    input  logic rst,
    input  logic walk,
    input  logic timer_done,
    output logic green,
    output logic red,
    output logic flash
);
    // States encoded as parameters
    localparam [1:0]
        GREEN_STATE  = 2'b00,
        YELLOW_STATE = 2'b01,
        RED_STATE    = 2'b10,
        FLASH_STATE  = 2'b11;
 
    logic [1:0] state, next_state;
 
    // State register
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            state <= GREEN_STATE;
        else
            state <= next_state;
    end
 
    // Next state logic
    always_comb begin
        case (state)
            GREEN_STATE:  next_state = walk       ? YELLOW_STATE : GREEN_STATE;
            YELLOW_STATE: next_state = timer_done ? RED_STATE    : YELLOW_STATE;
            RED_STATE:    next_state = timer_done ? FLASH_STATE  : RED_STATE;
            FLASH_STATE:  next_state = timer_done ? GREEN_STATE  : FLASH_STATE;
            default:      next_state = GREEN_STATE;
        endcase
    end
 
    // Output logic
    always_comb begin
        case (state)
            GREEN_STATE:  begin green = 1; red = 0; flash = 0; end
            YELLOW_STATE: begin green = 1; red = 1; flash = 0; end
            RED_STATE:    begin green = 0; red = 1; flash = 0; end
            FLASH_STATE:  begin green = 0; red = 1; flash = 1; end
            default:      begin green = 0; red = 0; flash = 0; end
        endcase
    end
endmodule