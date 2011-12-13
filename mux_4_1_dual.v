`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:41:40 04/10/2011 
// Design Name: 
// Module Name:    mux_2_1_dual 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mux_4_1_dual(
	sel, 
	in0, 
	in1, 
	in2, 
	in3, 
	out0123, 
	inA, 
	inB, 
	inC,
	inD,
	outABCD);

	input [1:0] sel;
	input [3:0] in0, in1, inA, inB, in2, in3, inC, inD;
	output [3:0] out0123, outABCD;
	
	reg [3:0] out0123, outABCD;
	
	always @* begin
		if (sel == 0) begin
			out0123 = in0;
			outABCD = inA;
		end
		else if (sel == 1) begin
			out0123 = in1;
			outABCD = inB;
		end
		else if (sel == 2) begin
			out0123 = in2;
			outABCD = inC;
		end
		else if (sel == 3) begin
			out0123 = in3;
			outABCD = inD;
		end
	end
endmodule
