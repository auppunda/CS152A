`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:27:58 04/09/2018
// Design Name:   onebitcounter
// Module Name:   C:/Users/TEMP.CS152A-01.000/Desktop/lab0/onebitcountertest.v
// Project Name:  lab0
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: onebitcounter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module onebitcountertest;

	// Inputs
	//reg clkin;
	// Instantiate the Unit Under Test (UUT)
	onebitcounter uut ( 
		.clk(clk),
		.clkin(clkin)
	);

	onebitcounter onebitcounter(clk, clkin);
	
	initial begin
		// Initialize Inputs
		//clkin = 0;

		// Wait 100 ns for global reset to finish
		//#100;
        
		// Add stimulus here

	end
      //always #5 clkin = ~clkin;
endmodule

