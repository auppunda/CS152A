`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:20:03 04/16/2018
// Design Name:   signi
// Module Name:   C:/Users/TEMP.CS152A-01.000/Desktop/CS152A-master/lab1_2.0/signitest.v
// Project Name:  lab1_2.0
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: signi
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module signitest;

	// Inputs
	reg [11:0] in;

	// Outputs
	wire [3:0] significand;
	wire [2:0] exponent;
	wire sign;

	// Instantiate the Unit Under Test (UUT)
	FPCVT uut (
		.D(in), 
		.S(sign), 
		.E(exponent), 
		.F(significand)
	);

	initial begin
		// Initialize Inputs
		in = 12'b100000000000;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

