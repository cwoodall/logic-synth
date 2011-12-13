`timescale 1ns / 1ps

module clkdiv_8kHz(clk_50Mhz, clk_8khz); 
    input clk_50Mhz;	// user clock
    output clk_8khz;	// divided clock
    reg [25:0] count;	// counter, is bigger then we need in case you wanna play with it
    reg clk_8khz;	// don't forget the register
 
initial 		// This describes what to do as soon as machine turns on
 begin
        clk_8khz<=0;	// resetting everything
        count<=0;
 end  

 always @(posedge clk_50Mhz)	// whenever a rising edge of 27 MHz happens, do:
       begin
	   // This is just a counter:
           if (count >= 6250) 
              count <= 0;
           else 
	      count <= count + 1;
	   // counter ends here
	   

	   // this guy decides if it should be 0 or 1
           clk_8khz <= count >= (3125) ? 1 : 0;	      

	end   

endmodule


