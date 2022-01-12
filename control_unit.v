`timescale 1ns / 1ps
module control_unit(beq, ResultSrc, MemWrite, Function, ALUSrc, ImmSrc, RegWrite, retD, opcode, func3, func7);
    output reg beq;
    output reg ResultSrc;
    output reg MemWrite;
    output reg [3:0] Function;
    output reg ALUSrc;
    output reg ImmSrc;
    output reg RegWrite;
    output retD;
    input [6:0] opcode;
    input [2:0] func3;
    input [6:0] func7;
    
    assign retD = opcode == 7'b1110011;
    
    always @(*)
    begin
        case (opcode)
        7'b0110011: begin //R type
                    beq = 0; ResultSrc = 0; MemWrite = 0; ALUSrc = 0;
                    ImmSrc = 1; RegWrite = 1;
                    end
        7'b0010011: begin //ADDI
                    beq = 0; ResultSrc = 0; MemWrite = 0; ALUSrc = 1;
                            ImmSrc = 1; RegWrite = 1;
                    end
        7'b1100011: begin //B type
                    beq = 1; ResultSrc = 0; MemWrite = 0; ALUSrc = 0;
                                    ImmSrc = 0; RegWrite = 0;
                    end
        7'b0000011: begin //I type LW
                    beq = 0; ResultSrc = 1; MemWrite = 0; ALUSrc = 1;
                                    ImmSrc = 1; RegWrite = 1;
                    end
        7'b0100011: begin //S Type
                    beq = 0; ResultSrc = 0; MemWrite = 1; ALUSrc = 1;
                                    ImmSrc = 1; RegWrite = 0;
                    end
        endcase
        
        if (opcode == 7'b0110011)
        begin
            if (func3 == 3'b000)
            begin
                if (func7 == 0)
                    Function = 0;
                else if (func7 == 7'b0100000)
                    Function = 1;
                else if (func7 == 1)
                    Function = 3;
            end
            else if (func3 == 3'b100)
            begin
                if (func7 == 1)
                    Function = 4;
                else if (func7 == 0)
                    Function = 10;
            end
            else if (func3 == 3'b110)
            begin
                if (func7 == 1)
                    Function = 5;
                else if (func7 == 0)
                    Function = 9;
            end
            else if (func3 == 3'b111)
                Function = 8;
            else if (func3 == 1)
                Function = 6;
            else if (func3 == 3'b101)
                Function = 7;
        end
        else if (opcode == 7'b0010011)
            Function = 2;
        else if (opcode == 7'b1100011)
        begin
            if (func3 == 0)
                Function = 13;
            else if (func3 == 1)
                Function = 14;
        end
        else if (opcode == 7'b0000011)
            Function = 11;
        else if (opcode == 7'b0100011)
            Function = 12;
        
    end
    
endmodule
