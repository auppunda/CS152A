`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:07:31 05/09/2018 
// Design Name: 
// Module Name:    clockDividers 
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
module clockDividers(clk, rst, clk_1, seg_clk, blink_clk
    );
	
	input wire clk;
	input wire rst;
	
	output wire clk_1;
	output wire seg_clk;
	output wire blink_clk;
	
	localparam ONE_DIV = 50000000;
	localparam SEG_DIV = 50000;
	localparam BLINK_DIV = 12500000;
	
	
	reg[31:0] one, seg, blink;
	
	reg clk_1_prime, clk_seg_prime, clk_blink_prime;
	
	
	
	
	always @(posedge(clk) or posedge(rst)) begin
		if(rst)
		begin 
			one <= 0;
			clk_1_prime <= 1'b0;
		end
		else if(one == ONE_DIV - 1) begin
			one <= 0;
			clk_1_prime <= ~clk_1_prime;
		end
		else if(seg == SEG_DIV - 1) begin
			seg <= 0;
			clk_seg_prime <= ~clk_seg_prime;
		end
		else if(blink== BLINK_DIV - 1) begin
			blink <= 0;
			clk_blink_prime <= ~clk_blink_prime;
		end
		else begin
			one <= one + 1;
			clk_1_prime <= clk_1_prime;
			seg <= seg + 1;
			clk_seg_prime <= clk_seg_prime;
			blink <= blink + 1;
			clk_blink_prime <= clk_blink_prime;
		end
	end
	
	
	assign seg_clk = clk_seg_prime;
	assign blink_clk = clk_blink_prime;
	assign clk_1 = clk_1_prime;
endmodule
