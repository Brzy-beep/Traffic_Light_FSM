`timescale 1ns / 1ps



module COUNTDOWN_TIMER (
    input  logic       clk,
    input  logic       rst,
    input  logic       load,
    input  logic [3:0] timer_value,
    output logic       timer_done
);
    logic [3:0] count;
 
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            count      <= 4'hF;
            timer_done <= 1'b0;
        end else if (load) begin
            count      <= timer_value;
            timer_done <= 1'b0;
        end else begin
            if (count == 4'h0) begin
                timer_done <= 1'b1;
            end else begin
                count      <= count - 1;
                timer_done <= 1'b0;
            end
        end
    end
endmodule