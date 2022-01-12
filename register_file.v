`timescale 1ns / 1ps
module register_file(Port_A, Port_B, Din, Addr_A, Addr_B, Addr_Wr, wr,clk);
			output reg [31:0] Port_A, Port_B;			// Data to be provided from register to execute the instruction
			input [31:0] Din;						// Data to be loaded in the register
			input [4:0] Addr_A, Addr_B, Addr_Wr;	// Address (or number) of register to be written or to be read
			input wr;								// input wr flag input
			reg [31:0] Reg_File [31:0];				// Register file
			input clk;

	always @(negedge clk) //Write is synchronous
	begin
		if (wr)
		begin
			if (Addr_Wr != 0) //x0 is hard wired to 0
			begin
			     Reg_File[Addr_Wr] <= Din;
			end
		end
	end
	
	always @(*) //Read is asynchronous
	begin
		if (Addr_A == 0) //x0 is hard wired to 0
              Port_A <= 0;
        else
              Port_A <= Reg_File[Addr_A];
        if (Addr_B == 0) //x0 is hard wired to 0
             Port_B <= 0;
        else
             Port_B <= Reg_File[Addr_B];
	end
	
endmodule
