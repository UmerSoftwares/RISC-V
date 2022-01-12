`timescale 1ns / 1ps
module Instruction_fetch (input [31:0] instruction, output [6:0] opcode, 
    output [2:0] func3, output [6:0] func7, output [4:0] rd, output [4:0] rs1, output [4:0] rs2,
    output reg [11:0] immediate );
    
    assign opcode = instruction[6:0];
    assign rd = instruction[11:7];
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign func7 = instruction[31:25];
    assign func3 = instruction[14:12];
        
    
    always @(instruction)
    begin
        if (opcode == 7'b0010011 || opcode == 7'b0000011) begin //I type
            immediate = instruction[31:20];
        end
        else if (opcode == 7'b1100011) begin //B type
            immediate[11] = instruction[31];
            immediate[9:4] = instruction[30:25];
            immediate[3:0] = instruction[11:8];
            immediate[10] = instruction[7];
        end
        else if (opcode == 7'b0100011)  begin //S type
            immediate[11:5] = instruction[31:25];
            immediate[4:0] = instruction[11:7];
        end
    end
endmodule
