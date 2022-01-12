`timescale 1ns / 1ps
module main(rst, clk, alu_z, Anode_Activate, LED_out, BTN_in, interrupt
);
input rst, clk;						// 1 button to reset, clock signal as input
output alu_z;						// An LED turned ON if result is zero
output reg[7:0] Anode_Activate;		// Anodes to control 7-segments
output reg [6:0] LED_out;			// output result to be sent on 7-segments
input [15:0] BTN_in;
input interrupt;




wire [31:0] PCF, PCD,PCE;
wire [31:0] Result;
wire [31:0] InstrF, InstrD;
wire [31:0] ALUResultE, ALUResultM, ALUResultW;
wire [3:0] FunctionD, FunctionE;
wire [31:0] RD1D, RD1E;
wire [31:0]  RD2D, RD2E, WriteDataE, WriteDataM;
wire [31:0] isrAddress;
wire addressSrc;


wire [31:0] SrcAE;
wire [31:0] SrcBE;

wire [31:0] ResultW;
wire [11:0] immediate;
wire [31:0] ImmExtD, ImmExtE;
wire ImmSrcD;
wire beqD, beqE;
wire jump_flag;
wire [31:0] ReadDataM, ReadDataW;
wire MemWriteD, MemWriteE, MemWriteM;
wire [31:0] seg_en;


reg [31:0] counter;		// A 32 bit flashing counter
reg [2:0] seg_on;

reg [3:0] display;

wire div_clk;
assign div_clk = clk;

//clkdiv dvclk(clk,div_clk);


//Connections
wire [4:0] rs1;
wire [4:0] rs2;
wire [4:0] Rs1E, Rs2E;
wire [4:0] RdD, RdE, RdM, RdW;

assign jump_flag = !alu_z;


//Control Unit Inputs
wire [6:0] opcode;
wire [2:0] func3;
wire [6:0] func7;

//Control Unit Flags
wire ResultSrcD, ResultSrcE, ResultSrcM, ResultSrcW;
wire ALUSrcD, ALUSrcE;
wire RegWriteD, RegWriteE, RegWriteM, RegWriteW;

//Hazard Unit ki chezein
wire [0:1] ForwardAE, ForwardBE;
//assign SrcAE = RD1E;
assign SrcAE = (ForwardAE == 0)? RD1E: ( (ForwardAE == 1)? ResultW : ALUResultM );
wire [31:0] RD2E_mul;
wire StallD, FlushD, FlushE, StallF, FlushM, retE, retD, FlushDCSR, FlushECSR; 
assign SrcBE = ALUSrcE ? ImmExtE : RD2E_mul;
assign RD2E_mul = (ForwardBE == 0)? RD2E: ( (ForwardBE == 1)? ResultW : ALUResultM );
hazard_controller hc(ForwardAE, ForwardBE, StallF, StallD, FlushD, rs1, rs2, FlushE , RdE, beqE, jump_flag, ResultSrcE, Rs1E, Rs2E, RdM, RegWriteM, RdW, RegWriteW);


assign WriteDataE = RD2E_mul;

//Connections and multiplexers
assign ResultW = ResultSrcW ? ReadDataW : ALUResultW;

control_unit cu(beqD, ResultSrcD, MemWriteD, FunctionD, ALUSrcD, ImmSrcD, RegWriteD, retD, opcode, func3, func7);
Instruction_Memory imem(PCF,InstrF);
register_file rf(RD1D, RD2D, ResultW, rs1, rs2, RdW, RegWriteW,div_clk);
Instruction_fetch ift(InstrD, opcode,func3, func7,RdD,rs1,rs2,immediate);
sign_extend sgext(immediate,ImmExtD,ImmSrcD);
address_generator adgen(PCF, beqE, jump_flag,ImmExtE + PCE, div_clk, rst, StallF, addressSrc, isrAddress);
ALU alu(ALUResultE,alu_z,SrcAE,SrcBE,FunctionE);
Data_Memory dmem(ReadDataM,WriteDataM, ALUResultM,MemWriteM,div_clk
    ,Result,seg_en, BTN_in);

fd_reg fd(InstrF,PCF,
InstrD,PCD, div_clk, StallD, FlushD | FlushDCSR);

de_reg de(
RegWriteD, ResultSrcD, MemWriteD,beqD, FunctionD, ALUSrcD, RD1D, RD2D, PCD, RdD,ImmExtD,rs1, rs2, retD,
RegWriteE, ResultSrcE, MemWriteE, beqE, FunctionE, ALUSrcE, RD1E, RD2E, PCE, RdE, ImmExtE, Rs1E, Rs2E, retE,
div_clk, FlushE | FlushECSR
);

em_reg em(
 RegWriteE ,ResultSrcE,MemWriteE ,ALUResultE,WriteDataE,RdE,
 RegWriteM, ResultSrcM, MemWriteM ,ALUResultM, WriteDataM,RdM ,div_clk, FlushM      
);

mw_reg mw(
RegWriteM,ResultSrcM, ALUResultM, ReadDataM, RdM,
RegWriteW, ResultSrcW, ALUResultW, ReadDataW, RdW,
div_clk
    );
    
csr csreg(interrupt, PCE, retE, FlushDCSR, FlushECSR, FlushM, isrAddress , addressSrc);

//assign Result[15:0] = BTN_in;
//assign Result[31:16] = 16'h1234;

always @(posedge clk)
    begin
            if(counter>=100000) begin
                counter <= 0;
                if (seg_on == 3'b111)
                begin
                    seg_on <= 0;
                end
                else
                begin
                    seg_on <= seg_on + 1;
                end
                end
                else 
                begin
                counter <= counter + 1;
				end
    end 
    // anode activating signals for 8 segments, digit period of 1ms
    // decoder to generate anode signals 
    always @(*)
    begin
        case(seg_on)
        3'd0: begin
            Anode_Activate = 8'b01111111 + ~seg_en[7:0]; 
            display = Result[31:28];
              end
        3'd1: begin
            Anode_Activate = 8'b10111111 + ~seg_en[7:0]; 
            display = Result[27:24];
            end
        3'd2: begin
            Anode_Activate = 8'b11011111 + ~seg_en[7:0];
            display = Result[23:20];
            end
                    
        3'd3: begin
             Anode_Activate = 8'b11101111 + ~seg_en[7:0];
             display = Result[19:16];
             end
                    
        3'd4: begin
            Anode_Activate = 8'b11110111 + ~seg_en[7:0];
            display = Result[15:12];
        end                                
                    
        3'd5: begin
            Anode_Activate = 8'b11111011 + ~seg_en[7:0];
            display = Result[11:8];
        end  
        3'd6: begin
            Anode_Activate = 8'b11111101 + ~seg_en[7:0];
            display = Result[7:4];
        end
        3'd7: begin
            Anode_Activate = 8'b11111110 + ~seg_en[7:0];
            display = Result[3:0];
        end 
                                                                          
        endcase
    end
    
    // Cathode patterns of the 7-segment 1 LED display 
    always @(*)
    begin
    case(display)				// First 4 bits of Result from ALU will be displayed on 1st segment
            4'b0000: LED_out = 7'b0000001; // "0"     
            4'b0001: LED_out = 7'b1001111; // "1" 
            4'b0010: LED_out = 7'b0010010; // "2" 
            4'b0011: LED_out = 7'b0000110; // "3" 
            4'b0100: LED_out = 7'b1001100; // "4" 
            4'b0101: LED_out = 7'b0100100; // "5" 
            4'b0110: LED_out = 7'b0100000; // "6" 
            4'b0111: LED_out = 7'b0001111; // "7" 
            4'b1000: LED_out = 7'b0000000; // "8"     
            4'b1001: LED_out = 7'b0000100; // "9"
            4'b1010: LED_out = 7'b0001000; // "A"     
            4'b1011: LED_out = 7'b1100000; // "b"     
            4'b1100: LED_out = 7'b0110001; // "C"     
            4'b1101: LED_out = 7'b1000010; // "d"     
            4'b1110: LED_out = 7'b0110000; // "E"     
            4'b1111: LED_out = 7'b0111000; // "F"     
            
            default: LED_out = 7'b0111000; // "0"
            endcase
    end

endmodule

