`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:42:21 04/04/2018 
// Design Name: 
// Module Name:    fourbitthesecond 
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
module fourbitthesecond(input clk,
		input rst,
		output reg[3:0] out
    );


	always @ (posedge clk) begin
		if( ! rstn)
			out <= 0;
		else 
			out <= out + 1;
	end

endmodule
