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
module counter(rst, clk, p, select, num, adj, sec_0, sec_1, min_0, min_1, Led
    );
	
	input wire clk;
	input wire rst;
	output reg [3:0] sec_0;
	output reg [3:0] sec_1;
	output reg [3:0] min_0;
	output reg [3:0] min_1;
	output reg Led;
	input wire p;
	input wire adj;
	input wire [3:0] num;
	input wire [1:0] select;
	
	reg [26:0] counter;
	reg [3:0] sec_0_temp, sec_1_temp, min_0_temp, min_1_temp;
	
	reg paused=0;
	reg g = 0;
	always @(posedge p or posedge clk) 
	begin
		if(p) begin
			paused <= ~paused;
			g=1;
		end
		else begin
			paused <= paused;
			g = 0;
		end
	end
	
	always @(posedge(clk) or posedge(rst))
	begin
		if (rst) begin 
			sec_0 <= 4'b0;
			sec_1 <= 4'b0;
			min_0 <= 4'b0;
			min_1 <= 4'b0;
			sec_0_temp <= 4'b0;
			sec_1_temp <= 4'b0;
			min_0_temp <= 4'b0;
			min_1_temp <= 4'b0;
			counter <= 27'b0;
		end
		else if(counter ==  (100000000 - 1) && ~paused && ~adj) begin
			counter <= 27'b0;
			sec_0 <= sec_0 + 4'b1;
			if(sec_0 == 9) 
			begin
				sec_0 <= 4'b0;
				sec_1 <= sec_1 + 4'b1;
				if(sec_1 == 5) begin
					sec_1 <= 0;
					min_0 <= min_0 + 4'b1;
					if(min_0 == 9)
					begin
						min_0 <= 0;
						min_1 <= min_1 + 4'b1;
						if(min_1 == 9) begin
							min_0 <=0;
							min_1 <=0;
							sec_0 <= 0;
							sec_1 <= 0;
						end
					end
				end
			end
		end
		else if(~paused && ~adj) begin
			counter <= counter + 27'b1;
		end	
		else if(adj) begin
			if(select == 0) 
			begin
				if(num <= 9) begin
					sec_0_temp <= num;
				end
				else sec_0_temp <= 9;
				
				if(g)
					sec_0 <= sec_0_temp;
			end
			if(select == 1)
			begin
				if(num <= 5) sec_1_temp <= num;
				else sec_1_temp <= 5;
				
				if(g)
					sec_1 <= sec_1_temp;
			end
			if(select == 2)
			begin
				if(num <= 9) min_0_temp <= num;
				else min_0_temp <= 9;
				
				if(g)
					min_0 <= min_0_temp;
			end
			if(select == 3) begin
				if(num <= 9) min_1_temp <= num;
				else min_1_temp <= 9;
				
				if(g)
					min_1 <= min_1_temp;
			end
			//if(g) begin
			//	sec_0 <= sec_0_temp;
			//	sec_1 <= sec_1_temp;
			//	min_0 <= min_0_temp;
			//	min_1 <= min_1_temp;
			//end
		end
	end
	
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
