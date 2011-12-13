`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:46:33 04/10/2011 
// Design Name: 
// Module Name:    ASCII_to_7Seg 
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
module ASCII_to_7Seg(		// Just a test
	clk,
	rst,
	ASCII,
	Display);
	
	input clk, rst;
	input [7:0] ASCII;
	output [6:0] Display;
	
	reg [6:0] Display;
	
	always @ (posedge clk or posedge rst) begin
		if (rst) begin
			Display <= 7'b1111110;
		end
		else begin
			if (ASCII == 8'h1C)
				Display <= 7'b0001000;
			else
				Display <= 7'b0110000;
		end
	
	end

endmodule
