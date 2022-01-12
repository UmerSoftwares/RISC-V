`timescale 1ns / 1ps
module Instruction_Memory (input [31:0] pc,output reg [31:0] instruction);
always @ (pc)
begin
    case (pc)
      32'd0: instruction = 32'h00000033;
      32'd4: instruction = 32'h00202083;
      32'd8: instruction = 32'h00800613;
      32'd12: instruction = 32'h00c0d133;
      32'd16: instruction = 32'h0ff00613;
      32'd20: instruction = 32'h00c0f0b3;
      32'd24: instruction = 32'h01f00593;
      32'd28: instruction = 32'h402081b3;
      32'd32: instruction = 32'h00b1d1b3;
      32'd36: instruction = 32'h00018a63;
      32'd40: instruction = 32'h00100233;
      32'd44: instruction = 32'h002000b3;
      32'd48: instruction = 32'h00400133;
      32'd52: instruction = 32'hfe0004e3;
      32'd56: instruction = 32'h00010663;
      32'd60: instruction = 32'h402080b3;
      32'd64: instruction = 32'hfc000ee3;
      32'd68: instruction = 32'h00102023;
      32'd72: instruction = 32'h00000063;
      32'd76: instruction = 32'h4d200093;
      32'd80: instruction = 32'h00102023;
      32'd84: instruction = 32'h30200073;
      default: instruction = 32'h00000013;
    endcase
end
endmodule
