`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:01:49 04/04/2018
// Design Name:   fourbitcounter
// Module Name:   C:/Users/TEMP.CS152A-01.000/Desktop/123/lab0/fourbitcountertest.v
// Project Name:  lab0
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fourbitcounter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fourbitcountertest;

	// Inputs
	reg rst;
	reg clk;

	// Instantiate the Unit Under Test (UUT)
	fourbitcounter uut (
		.rst(rst), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		rst = 1;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst = 0;
		//always 50 clk = ~clk;
	end
      always #5 clk = ~clk;
endmodule

