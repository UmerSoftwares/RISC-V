`timescale 1ns / 1ps

module sign_extend(input [11:0] immediate, output [31:0] immExt, input ImmSrc);
    //ImmSrc = 1 -> Normal immediate extension
    //ImmSrc = 0 -> Label sign extension
    assign immExt = ImmSrc ? {{20{immediate[11]}}, immediate} : {{19{immediate[11]}}, immediate, 1'b0};
endmodule
