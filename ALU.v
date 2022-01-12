`timescale 1ns / 1ps
module ALU(output reg [31:0] Result,output reg alu_z,input [31:0] A,input [31:0] B,input [3:0] Function);
	always @ (Function,A,B) begin
        case (Function)
            4'd00: Result = A+B; //Add
            4'd01: Result = A-B; //Subtract
            4'd02: Result = A+B; //Add Immediate
            4'd03: Result = A*B; //Multiply
            4'd04: Result = A/B; //Divide
            4'd05: Result = A%B;//Remainder
            4'd06: Result = A<<B; //shift left
            4'd07: Result = A>>B; //shift right
            4'd08: Result = A&B; //and
            4'd09: Result = A|B; //or
            4'd10: Result = A^B; //xor
            4'd11: Result = A+B; //load word adding offset
            4'd12: Result = A+B; //store word adding offset
            4'd13: Result = A==B; //branch equal
            4'd14: Result = A!=B; //branch enequal
            default: Result = A+B;
        endcase
    alu_z = Result==0;
    end
	
endmodule
