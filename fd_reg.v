`timescale 1ns / 1ps
module fd_reg(input [31:0] InstrF,input [31:0] PCF,
output reg [31:0] InstrD,output reg [31:0] PCD, input clk, input stall, input flush);

initial begin
    InstrD = 32'h00000013;
end

always @(posedge clk)
begin
    if (flush)
    begin
        InstrD <= 32'h00000013;
        PCD <= 0;
    end
    else if (!stall)
    begin
        InstrD <= InstrF;
        PCD <= PCF;
    end
    else begin
        InstrD <= InstrD;
        PCD <= PCD;
    end
end
endmodule
