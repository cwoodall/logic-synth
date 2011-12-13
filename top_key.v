`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:56:31 04/10/2011 
// Design Name: 
// Module Name:    top_key 
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
module top_key(clk_50Mhz,kin,kclk,keyout,idle);
	
	input clk_50Mhz, kclk, kin;

	output wire [7:0] keyout;
	output wire idle;
		
	ps2key keyboard0 (
		.clk50(clk_50Mhz),                 
		.kin(kin),                          
		.kclk(kclk),                       
		.code(keyout),
		.idle(idle)
		);
		
endmodule
