`timescale 1ns / 1ps
module de_reg(
RegWriteD, ResultSrcD, MemWriteD,beqD, FunctionD, ALUSrcD, RD1D, RD2D, PCD, RdD,ImmExtD,Rs1D, Rs2D, retD,
RegWriteE, ResultSrcE, MemWriteE, beqE, FunctionE, ALUSrcE, RD1E, RD2E, PCE, RdE, ImmExtE, Rs1E, Rs2E, retE,
clk, Flush
);
input clk;
input RegWriteD;
input ResultSrcD;
input MemWriteD;
input beqD;
input [3:0] FunctionD;
input ALUSrcD;
input [31:0] RD1D;
input [31:0] RD2D;
input [31:0] PCD;
input [4:0] RdD;
input [31:0] ImmExtD;
input [0:4] Rs1D;
input [0:4] Rs2D;
input Flush;
input retD;

output reg RegWriteE;
output reg ResultSrcE;
output reg MemWriteE;
output reg beqE;
output reg [3:0] FunctionE;
output reg ALUSrcE;
output reg [31:0] RD1E;
output reg [31:0] RD2E;
output reg [31:0] PCE;
output reg [4:0] RdE;
output reg [31:0] ImmExtE;
output reg [0:4] Rs1E;
output reg [0:4] Rs2E;
output reg retE;

initial begin
    beqE = 0;
    ResultSrcE = 0;
    RdE = 0;
    beqE = 0;
    Rs1E = 0;
    Rs2E = 0;
    ALUSrcE = 0;
    retE = 0;
end

always @(posedge clk)
begin
    if (Flush)
    begin
      RegWriteE    <=   0   ;
      ResultSrcE   <=   0   ;
      MemWriteE    <=   0   ;
      beqE         <=   0   ;
      FunctionE    <=   0   ;
      ALUSrcE      <=   0   ;
      RD1E         <=   0   ;
      RD2E         <=   0   ;
      PCE          <=   0   ;
      RdE          <=   0   ;
      ImmExtE      <=   0   ;
      Rs1E         <=   0   ;
      Rs2E         <=   0   ;
      retE <= 0;          
    end
    else begin
            RegWriteE    <=   RegWriteD    ;
            ResultSrcE   <=   ResultSrcD   ;
            MemWriteE    <=   MemWriteD    ;
            beqE         <=   beqD         ;
            FunctionE    <=   FunctionD    ;
            ALUSrcE      <=   ALUSrcD      ;
            RD1E         <=   RD1D         ;
            RD2E         <=   RD2D         ;
            PCE          <=   PCD          ;
            RdE          <=   RdD          ;
            ImmExtE      <=   ImmExtD      ;
            Rs1E         <=   Rs1D;
            Rs2E <= Rs2D;
            retE <= retD;
    end
end
endmodule
