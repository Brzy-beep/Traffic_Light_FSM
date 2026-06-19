`timescale 1ns / 1ps


module CHANGE_DETECTOR (
    input  logic       clk,
    input  logic       rst,
    input  logic [2:0] in,
    output logic       change
);
    logic [2:0] prev;
 
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            prev   <= 3'b000;
            change <= 1'b0;
        end else begin
            if (in != prev) begin
                change <= 1'b1;
            end else begin
                change <= 1'b0;
            end
            prev <= in;
        end
    end
endmodule