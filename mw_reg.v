`timescale 1ns / 1ps
module mw_reg(
RegWriteM,ResultSrcM, ALUResultM, ReadDataM, RdM,
RegWriteW, ResultSrcW, ALUResultW, ReadDataW, RdW,
clk
    );
    
input clk;

input           RegWriteM;
input           ResultSrcM;
input [31:0]    ALUResultM;
input [31:0]    ReadDataM;
input [4:0]     RdM;

output reg           RegWriteW;
output reg           ResultSrcW;
output reg [31:0]    ALUResultW;
output reg [31:0]    ReadDataW;
output reg [4:0]     RdW;

always @(posedge clk)
begin
    RegWriteW   <= RegWriteM; 
    ResultSrcW  <= ResultSrcM;
    ALUResultW  <= ALUResultM;
    ReadDataW   <= ReadDataM; 
    RdW         <= RdM;       
end

    
endmodule
