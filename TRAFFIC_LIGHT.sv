`timescale 1ns / 1ps



module TRAFFIC_LIGHT (
    input  logic clk,
    input  logic rst,
    input  logic walk,
    output logic green,
    output logic red,
    output logic blue
);
   
    logic        fsm_green, fsm_red, fsm_flash;
    logic [2:0]  fsm_out;
    logic [3:0]  rom_out;
    logic        timer_done;
    logic        change;
    logic        mux_out;
 
    assign fsm_out = {fsm_green, fsm_red, fsm_flash};
 
    
    TRAFFIC_LIGHT_FSM fsm_inst (
        .clk        (clk),
        .rst        (rst),
        .walk       (walk),
        .timer_done (timer_done),
        .green      (fsm_green),
        .red        (fsm_red),
        .flash      (fsm_flash)
    );
 
   
    ROM rom_inst (
        .in  (fsm_out),
        .out (rom_out)
    );
 
    
    CHANGE_DETECTOR change_det_inst (
        .clk    (clk),
        .rst    (rst),
        .in     (fsm_out),
        .change (change)
    );
 
    
    COUNTDOWN_TIMER timer_inst (
        .clk        (clk),
        .rst        (rst),
        .load       (change),
        .timer_value(rom_out),
        .timer_done (timer_done)
    );
 
    
    MUX mux_inst (
        .in0 (~fsm_green),
        .in1 (clk),
        .sel (fsm_flash),
        .out (mux_out)
    );
 
    
    assign green = fsm_green;
    assign red   = fsm_red;
    assign blue  = mux_out;
 
endmodule