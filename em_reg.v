`timescale 1ns / 1ps
module em_reg(
 RegWriteE ,ResultSrcE,MemWriteE ,ALUResultE,WriteDataE,RdE,
 RegWriteM, ResultSrcM, MemWriteM ,ALUResultM, WriteDataM,RdM ,clk, FlushM      
);
input clk;
input           RegWriteE;
input           ResultSrcE;
input           MemWriteE;
input [31:0]    ALUResultE;
input [31:0]    WriteDataE;
input [4:0]     RdE;
output reg          RegWriteM;
output reg          ResultSrcM;
output reg          MemWriteM;
output reg [31:0]   ALUResultM;
output reg [31:0]   WriteDataM;
output reg [4:0]    RdM;

input FlushM;

always @(posedge clk)
begin
    if (FlushM)
    begin
        RegWriteM   <=  0;
        ResultSrcM  <=  0;
        MemWriteM   <=  0;
        ALUResultM  <=  0;
        WriteDataM  <=  0;
        RdM         <=  0;
        RdM         <=  0;
        RdM         <=  0;
        RdM         <=  0;
    end
    else begin
        RegWriteM   <=  RegWriteE; 
        ResultSrcM  <=  ResultSrcE;
        MemWriteM   <=  MemWriteE; 
        ALUResultM  <=  ALUResultE;
        WriteDataM  <=  WriteDataE;
        RdM         <=  RdE;       
        RdM         <=  RdE;       
        RdM         <=  RdE;       
        RdM         <=  RdE;
    end       
end


endmodule
