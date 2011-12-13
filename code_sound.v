`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:08:11 12/10/2011 
// Design Name: 
// Module Name:    code_sound 
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
module code_sound(idle,clk_50Mhz,code,sound);

input wire [7:0] code;
input wire clk_50Mhz;
input wire idle;

output reg [12:0] sound;



reg [7:0] key_control;
reg count;

initial begin
	count <= 0;
	key_control <= 0;
	sound <= 0;
end

reg [7:0] prev_code;
reg [7:0] prev_note;


always @ (posedge clk_50Mhz) begin
	if (idle == 0) begin
		if ((prev_code != 8'hF0)) begin //&& (code != prev_note)) begin
			case(code)
				8'h1c: sound <= sound | 13'b1;             //key A, note C4
				8'h1d: sound <= sound | 13'b10;            //key W, note Cs4
				8'h1b: sound <= sound | 13'b100;           //key S, note D4
				8'h24: sound <= sound | 13'b1000;          //key E, note Ds4
				8'h23: sound <= sound | 13'b10000;         //key D, note E4
				8'h2b: sound <= sound | 13'b100000;        //key F, note F4
				8'h2c: sound <= sound | 13'b1000000;       //key T, note Fs4
				8'h34: sound <= sound | 13'b10000000;      //key G, note G4
				8'h35: sound <= sound | 13'b100000000;     //key Y, note Gs4
				8'h33: sound <= sound | 13'b1000000000;    //key H, note A4
				8'h3c: sound <= sound | 13'b10000000000;   //key U, note As4
				8'h3b: sound <= sound | 13'b100000000000;  //key J, note B4
				8'h42: sound <= sound | 13'b1000000000000; //key K, note C5
			default: sound <= sound;
			endcase
		end else begin
			case (code)
				8'h1c: sound <= sound & 13'b1111111111110;             //key A, note C4
				8'h1d: sound <= sound & 13'b1111111111101;            //key W, note Cs4
				8'h1b: sound <= sound & 13'b1111111111011;           //key S, note D4
				8'h24: sound <= sound & 13'b1111111110111;          //key E, note Ds4
				8'h23: sound <= sound & 13'b1111111101111;         //key D, note E4
				8'h2b: sound <= sound & 13'b1111111011111;        //key F, note F4
				8'h2c: sound <= sound & 13'b1111110111111;       //key T, note Fs4
				8'h34: sound <= sound & 13'b1111101111111;      //key G, note G4
				8'h35: sound <= sound & 13'b1111011111111;     //key Y, note Gs4
				8'h33: sound <= sound & 13'b1110111111111;    //key H, note A4
				8'h3c: sound <= sound & 13'b1101111111111;   //key U, note As4
				8'h3b: sound <= sound & 13'b1011111111111;  //key J, note B4
				8'h42: sound <= sound & 13'b0111111111111; //key K, note C5
				default: sound <= sound;
			endcase
	//	prev_note = code;
		end
		prev_code = code;
	end
	else begin
	sound <= 0;
	end
end

endmodule
