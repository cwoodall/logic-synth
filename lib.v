`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston Univeristy
// Engineer: Christopher Woodall
// 
// Create Date:    16:33:11 10/20/2011 
// Design Name: 
// Module Name:    bcd2led 
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

module debouncer( button, clk_50Mhz, d_button);
	// Chris Woodall
	input button;
	input clk_50Mhz;
	output d_button;
	
	reg d_button;
	reg [25:0] count;
	
	initial begin
		count = 0;
		d_button = 0;
	end
		
	always @ ( posedge clk_50Mhz ) begin
		if (d_button == button) begin
			count <= 0;
		end else begin
			count <= count + 1;
			if (count >= 26_000_00) begin
				d_button <= ~d_button;
			end
		end
	end
endmodule //debouncer


module led_driver(disp0, disp1, disp2, disp3, ctrl, display, enable);
// Chris Woodall
// input wire ctrl - a clocked control line to determine which disp is currently being output
// input wire disp0, disp1, disp2, disp3 - displays to be held on the 4 different 7 segment displays
// output reg display - what is currently beign displayed on the selected control
// output reg enable - selects appropriate 7-segment display
	input [7:0] disp0, disp1, disp2, disp3;
	input [1:0] ctrl;
	output [7:0] display;
	output [3:0] enable;
	
	reg [7:0] display;
	reg [3:0] enable;
	
	parameter D0 = 2'b00;
	parameter D1 = 2'b01;
	parameter D2 = 2'b10;
	parameter D3 = 2'b11;
	
	always @ (ctrl, disp0, disp1, disp2, disp3) begin
		case (ctrl)
			D0:
				begin
					enable <= 4'b1110;
					display <= disp0;
				end
			D1:
				begin
					enable <= 4'b1101;
					display <= disp1;				
				end
			D2:
				begin
					enable <= 4'b1011;
					display <= disp2;
				end
			D3:
				begin
					enable <= 4'b0111;
					display <= disp3;
				end
		endcase
	end
endmodule //led_driver

module pos_edge( inbutton, clk, outbutton );
	input inbutton;
	input clk;
	reg  prev_state;
	output reg outbutton;

	always @ (posedge clk) begin
		outbutton = (inbutton) & (~prev_state);
		prev_state = inbutton;
	end
endmodule

module inc_dec( b_inc, b_dec, clk, num1, num0);
// Chris Woodall
	input b_inc, b_dec;
	input clk;
	
	output [3:0] num0;	// this would show your ones
	output [3:0] num1;	// and this one would show your tens

	reg [3:0] num0;
	reg [3:0] num1;
	
	// initialize the values (optional)
	initial begin
		num0 = 0;
		num1 = 0;
	end	

	// Edge detection circuitry:
	// This is necissary because we need to know if we should act on b_inc or b_dec
	// in some manner which is synchronized with the clock. This is mostly because
	// the always statement in Verilog does not like receiving non clocking inputs
	// and thus we need to do our own edge detection.
	//
	// TODO:
	//   - Spawn off into module (or function of some sort)
	reg b_inc_d; // register for storing if b_inc is on or not
	reg b_dec_d; // register for storign if b_dec is on or not
	wire b_inc_edge = (b_inc) & ~(b_inc_d); // detect the edge
	wire b_dec_edge = (b_dec) & ~(b_dec_d); // detect the edge	
	
	// Implementation of Edge Detection
	always @ (posedge clk) begin
		if (b_inc) begin
			b_inc_d = 1;
		end else begin
			b_inc_d = 0;
		end
		
		if (b_dec) begin
			b_dec_d = 1;
		end else begin
			b_dec_d = 0;
		end
	end
	
	always @ (posedge clk) begin
		if (b_inc_edge) begin
			num0 = num0 + 1'b1;			// increment the ones bit
			if ( num0 >= 10 ) begin 	// if it is greater than 9
				num0 = 0;					// reset it to 0
				num1 = num1 + 1'b1;		// and increment the tens bit.
				if (num1 >= 10) begin	// If tens is greater than 9
					num1 = 0;				// reset it to 0
				end
			end
		end else begin
			num0 = num0;
			num1 = num1;
		end
		
		if (b_dec_edge) begin
			
			if ( num0 == 0 ) begin 	// if it is greater than 9
				num0 = 9;					// reset it to 0
				if (num1 == 0) begin	// If tens is greater than 9
					num1 = 9;				// reset it to 0
				end else begin
					num1 = num1 - 1'b1;
				end
			end else begin
				num0 = num0 - 1'b1;			// increment the ones bit
			end
		end else begin
			num0 = num0;
			num1 = num1;
		end
	end
endmodule

/**
 * bcd2led: Takes in binary coded decimal and converts it to a format 
 * 			for display on a 7 segment led
 *
 * input wire [3:0]   I         BCD input
 * input reg  [7:0]   Segments  Output for 7 segment LED 
 */
module bcd2led( I, Segments );
// Chris Woodall
	input I;
	output Segments;
	wire [3:0] I;
	reg [7:0] Segments;
	
	always @(I) begin
		case (I)
			1: Segments <= 8'b10011111;
			2: Segments <= 8'b00100101;
			3: Segments <= 8'b00001101;
			4: Segments <= 8'b10011001;
			5: Segments <= 8'b01001001;
			6: Segments <= 8'b01000001;
			7: Segments <= 8'b00011111;
			8: Segments <= 8'b00000001;
			9: Segments <= 8'b00001001;
			default: Segments <= 8'b00000011; // By default put out a zero.
		endcase
	end
endmodule // bcd2led

/**
 * hex2led: Takes in binary coded decimal and converts it to a format 
 * 			for display on a 7 segment led
 *
 * input wire [3:0]   I         BCD input
 * input reg  [7:0]   Segments  Output for 7 segment LED 
 */
module hex2led( I, Segments );
// Chris Woodall
	input [3:0] I;
	output reg [7:0] Segments;
	
	always @(I) begin
		case (I)
			4'h0: Segments <= 8'b00000011;
			4'h1: Segments <= 8'b10011111;
			4'h2: Segments <= 8'b00100101;
			4'h3: Segments <= 8'b00001101;
			4'h4: Segments <= 8'b10011001;
			4'h5: Segments <= 8'b01001001;
			4'h6: Segments <= 8'b01000001;
			4'h7: Segments <= 8'b00011111;
			4'h8: Segments <= 8'b00000001;
			4'h9: Segments <= 8'b00001001;
			4'ha: Segments <= 8'b00010001;
			4'hb: Segments <= 8'b11000001;
			4'hc: Segments <= 8'b01100011;
			4'hd: Segments <= 8'b10000101;
			4'he: Segments <= 8'b01100001;
			4'hf: Segments <= 8'b01110001;
			default:  Segments <= 8'b11111101; // By default put out a line.
		endcase
	end
endmodule // bcd2led

module pwm(data_in, clk, pwm_out);
	input clk;
	input [13:0] data_in;
	output  pwm_out; 

	reg [14:0] accumulator;

	always @(posedge clk) accumulator <= accumulator[13:0] + data_in;
	assign pwm_out = accumulator[14];
endmodule

//receives a 50MHz clk on clk_50Mhz and generates a 1 Hz clk on clk_1hz
module clk_divider_1hz(clk_50Mhz, clk_1hz); 
	input clk_50Mhz;	// user clock
	output clk_1hz;	// divided clock
	
	reg [25:0] count;	// counter, is bigger then we need in case you wanna play with it
	reg clk_1hz;	// don't forget the register
	
	// Define THRESHOLD
	// This clock divider is meant to give 50% duty cycle
	parameter THRESHOLD = 25_000_000; // To make clocks of different frequencies simply alter this!
																		// THRESHOLD = f_clk/(f_desired*2) <= still for 50% duty cycle
	
	initial begin
		clk_1hz <= 0;	// resetting everything
		count<=0;
	end  

	always @(posedge clk_50Mhz) begin
		// This is just a counter:
		if (count >= 50_000_000) 
			count <= 0;
		else 
			count <= count + 10;
			// counter ends here
			
		// this guy decides if it should be 0 or 1
		clk_1hz <= count >= (THRESHOLD) ? 1 : 0;	      
	end   
endmodule // clk_divider

module counter( clk_1Hz, num0, num1 );
	input clk_1Hz;			// 1 Hz clock goes in here
	output [3:0] num0;	// this would show your ones
	output [3:0] num1;	// and this one would show your tens
	
	reg [3:0] num0;
	reg [3:0] num1;
	
	// initialize the values (optional)
	initial begin
		num0 = 0;
		num1 = 0;
	end
	
	always @ (posedge clk_1Hz) begin
		num0 = num0 + 1'b1;			// increment the ones bit
		if ( num0 >= 10 ) begin 	// if it is greater than 9
			num0 = 0;					// reset it to 0
			num1 = num1 + 1'b1;		// and increment the tens bit.
			if (num1 >= 10) begin	// If tens is greater than 9
				num1 = 0;				// reset it to 0
			end
		end
	end
endmodule // counter

module led_switch_signal(clk_50Mhz, control);
	input clk_50Mhz;
	output [1:0] control;

	reg [1:0] control;

	reg [1:0] state;
	reg clk_200Hz;
	reg [25:0] count;

	initial begin
		control	<=0;
		state		<=0;
		clk_200Hz	<=0;
		count		<=0;
	end

	always @(posedge clk_200Hz) begin
		case(state)
			2'b00:state = 2'b01;
			2'b01:state = 2'b10;
			2'b10:state = 2'b11;
			2'b11:state = 2'b00;
		endcase
	end

	always @(state)
		control = state;
	
	always @(posedge clk_50Mhz)	// whenever a rising edge of 50 MHz happens, do:
      begin
			// This is just a counter:
			if (count >= 250_000) 
				count <= 0;
         else 
	      count <= count + 1;
			// counter ends here
	   

			// this guy decides if it should be 0 or 1
         clk_200Hz <= count >= (125_000) ? 1 : 0;	     
	end   	
endmodule // led_switch_signal
