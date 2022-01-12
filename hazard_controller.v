`timescale 1ns / 1ps

module hazard_controller(ForwardAE, ForwardBE, StallF, StallD, FlushD, Rs1D, Rs2D, FlushE, RdE, beq, jump_flag, ResultSrcE, Rs1E, Rs2E, RdM, RegWriteM, RdW, RegWriteW);
output [1:0] ForwardAE, ForwardBE;
output StallF, StallD, FlushD, FlushE; 
input [4:0] Rs1D, Rs2D, RdE;
input beq, jump_flag, ResultSrcE;
input [4:0] Rs1E, Rs2E, RdM;
input RegWriteM;
input [4:0] RdW;
input RegWriteW;

assign ForwardAE = 
    ((Rs1E == RdM) & RegWriteM & (Rs1E!=0))? 2 :
    (
        ((Rs1E == RdW) & RegWriteW &(Rs1E!=0))? 1:0
    );
assign ForwardBE = 
        ((Rs2E == RdM) & RegWriteM & (Rs2E!=0))? 2 :
        (
            ((Rs2E == RdW) & RegWriteW &(Rs2E!=0))? 1:0
        );    

wire lwStall;

assign lwStall = ResultSrcE & ((Rs1D==RdE) | (Rs2D == RdE));
assign StallF = lwStall;
assign StallD = lwStall;
assign FlushD = beq & jump_flag;
assign FlushE = lwStall | FlushD;

endmodule
