`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:45:04 04/04/2018 
// Design Name: 
// Module Name:    fourbitcounter 
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
module fourbitcounter( rst, clk
    );
reg a0;
reg a1;
reg a2;
reg a3;

input rst, clk;

always @ (posedge clk)
begin 
	if (rst) 
	begin
		a0 <= 1'b0;
		a1 <= 1'b0;
		a2 <= 1'b0;
		a3 <= 1'b0;
	end
	else
	begin
		a0 <= ~a0;
		a1 <= a0 ^ a1;
		a2 <= (a1 & a0) ^ a2;
		a3 <= (a1 & a0 & a2) ^ a3;
	end
end

endmodule
