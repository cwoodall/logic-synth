`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:55:53 12/10/2011
// Design Name:   volume_control
// Module Name:   X:/Xilinx/piano/volume_TEST.v
// Project Name:  piano
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: volume_control
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module volume_TEST;

	// Inputs
	reg [13:0] inwave;
	reg [2:0] control;

	// Outputs
	wire [13:0] outwave;

	// Instantiate the Unit Under Test (UUT)
	volume_control uut (
		.inwave(inwave), 
		.control(control), 
		.outwave(outwave)
	);

	initial begin
		// Initialize Inputs
		inwave = 14'b10000000000000;
		control = 3'b111;

		// Wait 100 ns for global reset to finish
		#100;
      repeat (100) begin
			#10 inwave = inwave + 14'b0000000001000;
		end
		// Add stimulus here

	end
      
endmodule

