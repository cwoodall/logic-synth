`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:02:17 12/10/2011 
// Design Name: 
// Module Name:    volume_control 
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
module volume_control( inwave, control, outwave);

input [9:0] inwave;
input [3:0] control;
output [9:0] outwave;

// Shift inwave three to the left
wire [12:0] temp_wave = inwave * control;

assign outwave = (temp_wave) >> 3;

endmodule

module volume_buttons( inc_dec, clk, control);

input [1:0] inc_dec;
input clk;
output reg [3:0] control;

initial begin
	control <= 0;
end

always @ (posedge clk) begin
		case (inc_dec)
			2'b01:
				begin
					if (control > 0)
						control <= control - 4'd1;
				end
			2'b10:
				begin
					if (control < 4'b1000)
						control <= control + 4'd1;
				end
			default: control <= control;
		endcase
end

endmodule

module volume_control_display(control, clk, display);

input [3:0] control;
input clk;
output reg [7:0] display;

always @ (posedge clk) begin
	case (control)
		4'b0000: display <= 8'b00000000;
		4'b0001: display <= 8'b00000001;
		4'b0010: display <= 8'b00000011;
		4'b0011: display <= 8'b00000111;
		4'b0100: display <= 8'b00001111;
		4'b0101: display <= 8'b00011111;
		4'b0110: display <= 8'b00111111;
		4'b0111: display <= 8'b01111111;
		4'b1000: display <= 8'b11111111;
		default: display <= 0;
	endcase
end

endmodule
