`timescale 1ns / 1ps

module main_test;

reg rst, clk;
wire alu_z;
wire [7:0] Anode_Activate;	
wire  [6:0] LED_out;	
reg [15:0] BTN_in;
reg interrupt;



main UUT(rst, clk, alu_z, Anode_Activate, LED_out, BTN_in, interrupt);

    always begin
        clk = 0;
        forever #1 clk = ~clk;
    end
    
    initial begin
        rst = 0;
        interrupt = 0;
        BTN_in[7:0] = 25;
        BTN_in[15:8] = 10;
        #170
        interrupt = 1;
        #2
        interrupt = 0;
        #10
        
    
    $finish;  
    end

endmodule
