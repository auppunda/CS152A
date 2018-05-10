`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:49:26 05/09/2018 
// Design Name: 
// Module Name:    counter 
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
module counter(rst, clk, pause, adj, sec_0, sec_1, min_0, min_1, Led
    );
	
	input wire clk;
	input wire rst;
	input wire pause;
	input wire adj;
	
	output wire [3:0] sec_0;
	output wire [3:0] sec_1;
	output wire [3:0] min_0;
	output wire [3:0] min_1;
	output reg Led;
	
	reg [26:0] counter;
	
	reg sec0;
	reg sec1;
	reg min0;
	reg min1;
	reg p = 0;
	reg adjust = 0;
	
	always @(posedge(clk) or posedge(adj))
	begin
		if(adj)
			adjust <= ~adjust;
		else 
			adjust <= adjust;
			
		
	end	
	
	always @(posedge(clk) or posedge(rst) or posedge(pause))
	begin
		if(rst) 
			p = 0;
		else if(pause) begin
			p <= ~p;
		end
		else 
			p <= p;
	end
	
	// clock for 1 hz , times it
	always @(posedge(clk) or posedge(rst))
	begin
		if (rst) begin 
			sec0 <= 4'b0;
			sec1 <= 4'b0;
			min0 <= 4'b0;
			min1 <= 4'b0;
			
			counter <= 27'b0;
		end
		else if((counter ==  (100000000 - 1)) && ~pause && adjust) begin
			counter <= 27'b0;
			sec0 <= sec0 + 4'b1;
			
			if(sec_0 == 10) begin
				sec0 <= 4'b0;
				sec1 <= sec1 + 4'b1;
			end
			
			if(sec1 == 6) begin
				sec1 <= 0;
				min0 <= min0 + 4'b1;
			end
			
			if(min0 == 9) begin
				min1 <= min1 + 4'b1;
				min0 <= 0;
			end
			
			if(min1 == 6) begin
				min0 <= 0;
				min1 <= 0;
				sec1 <= 0;
				sec2 <= 0;
			end
		end
		else if(~pause && adjust) begin
			counter <= counter + 27'b1;
		end	
	end
	
	assign min_1 = min1;
	assign min_0 = min0;
	assign sec_1 = sec1;
	assign sec_0 = sec0;
	
	always@ (posedge(clk) or posedge(rst))
	begin
		if(rst == 1'b1)
			Led <= 1'b0;
		else if(counter == (100000000 - 1))
			Led <= ~Led;
		else
			Led <= Led;
	end
endmodule
