`timescale 1ns / 1ps

module sin_generator(speed,enable,clk_50MHz,wave);

    input clk_50MHz;	  // user clock
	 input enable;      // signal to turn on generator
	 input [9:0] speed; // parameter used to determine frequecy
	 
    output reg [9:0] wave;	// holds value of sin only when enable is equal to 1
	 
	 reg [9:0] clkcounter; // counts up to variable speed to divide the clock in an ajustable way
	 reg [11:0] count;     // coutts up to 1024 which results in a clock cycle being 1024 times slower than the desired frequency
	 reg timer;            // becomes 1 every time clkcounter finishes a cycle
	 wire [9:0] sin;       // contains the final 

initial
begin
	count<=0;
	clkcounter<=0;
	timer<=0;
end

always @ (sin,enable) begin
	wave <= sin * enable;
end

always @(posedge clk_50MHz)
begin

	if (clkcounter >= speed) begin
		clkcounter <= 0;
		timer <= 1;
	end
	else begin
	clkcounter <= clkcounter + 1;
	timer <= 0;
	end
end

always @ (posedge timer)
begin
	   // This is just a counter:
	if (count >= 1023) 
		count <= 0;
	else 
	count <= count + 1;
end

// querys sine look up table 1024 times per period to form sine wave
Sine_LUT slut(count,sin);

endmodule
