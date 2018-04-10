`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:36:33 04/04/2018 
// Design Name: 
// Module Name:    onebitcounter 
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
module onebitcounter( clk, clkin
    );
	 
reg [31:0] counter;
input clkin;
output reg clk;
initial begin
	counter = 0;
	clk = 0;
end

always @ (posedge clkin) 
begin
	if (counter == 0) 
	begin
		counter <= 99999999;
		clk <= ~clk;
	end else 
	begin
		counter <= counter - 1;
	end
end


endmodule
