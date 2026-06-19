`timescale 1ns / 1ps



module ROM (
    input  logic [2:0] in,
    output logic [3:0] out
);
    always_comb begin
        case (in)
            3'b100: out = 4'b0100; // GREEN_STATE  -> 4 cycles
            3'b110: out = 4'b0010; // YELLOW_STATE -> 2 cycles
            3'b010: out = 4'b0100; // RED_STATE    -> 4 cycles
            3'b011: out = 4'b0011; // FLASH_STATE  -> 3 cycles
            default: out = 4'bxxxx;
        endcase
    end
endmodule
 