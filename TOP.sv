`timescale 1ns / 1ps


module TOP (
    input  logic clk,
    input  logic rst_clk,
    input  logic rst_tf,
    input  logic walk,
    output logic clk_delay,
    output logic green,
    output logic red,
    output logic blue
);
    logic clk_slow;
 
    CLK_DELAY clk_delay_inst (
        .clk       (clk),
        .rst       (rst_clk),
        .clk_delay (clk_slow)
    );
 
    assign clk_delay = clk_slow;
 
    TRAFFIC_LIGHT tf_inst (
        .clk   (clk_slow),
        .rst   (rst_tf),
        .walk  (walk),
        .green (green),
        .red   (red),
        .blue  (blue)
    );
endmodule
 