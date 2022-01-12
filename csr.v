`timescale 1ns / 1ps
module csr(interrupt, PCE, retE, FlushD, FlushE, FlushM, address, addressSrc);
input interrupt;
input [31:0] PCE;
input retE;

output FlushD;
output FlushE;
output FlushM;
output [31:0] address;
output addressSrc;

reg [31:0] return;

wire [31:0] isr = 32'd76;

assign addressSrc = interrupt | retE;
assign FlushD = addressSrc;
assign FlushE = addressSrc;
assign FlushM = addressSrc;
assign address = (retE)? return : isr;

always @(posedge interrupt)
begin
    return <= PCE;
end

endmodule
