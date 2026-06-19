`timescale 1ns / 1ps



module CLK_DELAY (
    input  logic clk,
    input  logic rst,
    output logic clk_delay
);
    logic [31:0] count;
 
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            count <= 32'h0;
        else
            count <= count + 1;
    end
 
    assign clk_delay = count[27];
endmodule
 