`timescale 1ns / 1ps
module Data_Memory(output reg [31:0] Data_Out, input [31:0] Data_In, input [7:0] D_Addr, input wr, input clk
    ,output [31:0] seg_out, output [31:0] seg_en, input [15:0] buttons_in);
    reg [31:0] Mem [255:0];			// Data Memory
    always @(negedge clk) //Write operation is synchronous
    begin
        if (wr)
        begin
           if (D_Addr != 2)
           begin
             Mem[D_Addr] <= Data_In;
           end
        end
    end
    always @(*) //Read is asynchronous
    begin
        if (D_Addr == 2)
        begin
            Data_Out <= buttons_in;
        end
        else begin
            Data_Out <= Mem[D_Addr];
        end
    end
    assign seg_out = Mem[0];
    assign seg_en = Mem[1];
endmodule
