`timescale 1ns / 1ps

module address_generator (output reg [31:0] pc, input beq, input zero_flag, input [31:0] branch_pc, input clk, input rst, input Stall, input addressSrc, input [31:0] isrAddress);	
    initial
    begin
        pc = 0;
    end
    always @(posedge clk)
    begin
        if (rst)
        begin
            pc <= 0;
        end
        else 
        begin
        if (Stall)
        begin
        end
        else
        begin
                if (addressSrc)
                begin
                    pc <= isrAddress;
                end
                else if (beq && zero_flag)
                begin
                    pc <= branch_pc;
                end
                else
                begin
                    pc <= pc+4;
                end
        end
        end
    end 
endmodule
