`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:21:36 05/09/2018
// Design Name:   counter
// Module Name:   C:/Users/TEMP.CS152A-01.000/Desktop/lab3/lab3_t/test.v
// Project Name:  lab3_t
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg rst;
	reg clk;

	// Outputs
	wire [3:0] sec_0;
	wire [3:0] sec_1;
	wire [3:0] min_0;
	wire [3:0] min_1;
	wire Led;

	// Instantiate the Unit Under Test (UUT)
	counter uut (
		.rst(rst), 
		.clk(clk), 
		.sec_0(sec_0), 
		.sec_1(sec_1), 
		.min_0(min_0), 
		.min_1(min_1), 
		.Led(Led)
	);

	initial begin
		// Initialize Inputs
		rst = 1;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		rst = 0;
        
		// Add stimulus here
	end
	
	always
	#1 clk = ~clk;
	
      
endmodule

