`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:33:56 04/10/2011 
// Design Name: 
// Module Name:    hex_to_7seg 
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
module hex_to_7seg (hex, seven_seg);
	input [3:0] hex;
	output [6:0] seven_seg;
	
	reg [6:0] seven_seg;
	
	always @ (hex) begin
		case (hex)
			4'h0: seven_seg = 7'b0000001;
			4'h1: seven_seg = 7'b1001111;
			4'h2: seven_seg = 7'b0010010;
			4'h3: seven_seg = 7'b0000110;
			4'h4: seven_seg = 7'b1001100;
			4'h5: seven_seg = 7'b0100100;
			4'h6: seven_seg = 7'b0100000;
			4'h7: seven_seg = 7'b0001111;
			4'h8: seven_seg = 7'b0000000;
			4'h9: seven_seg = 7'b0000100;
			4'ha: seven_seg = 7'b0001000;
			4'hb: seven_seg = 7'b1100000;
			4'hc: seven_seg = 7'b0110001;
			4'hd: seven_seg = 7'b1000010;
			4'he: seven_seg = 7'b0110000;
			4'hf: seven_seg = 7'b0111000;
			default: seven_seg = 7'b1111110;
		endcase
	end


endmodule
