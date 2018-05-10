`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:36:21 05/09/2018 
// Design Name: 
// Module Name:    stopwatch 
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
module stopwatch(clk, rst, sw, Led, seg
    );
	
	input wire clk;
	input wire rst;
	input [6:0] sw;
	output [3:0] Led;
	output [7:0] seg;
	reg [7:0] s;
	reg [3:0] l;
	
	reg [1:0] sel;
	reg [3:0] num;
	reg [1:0] adj;
	always @* begin
		sel <= sw[1:0];
		num <= sw[5:2];
		adj <= sw[6];
	end

	always @* begin
	
		
	end
	
	seven_seg seg (.num(1'b1), .seg(s));
	
	//end

endmodule
