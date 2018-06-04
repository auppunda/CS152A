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
module counter1(rst, clk, p, sec_0, sec_1, min_0, min_1
    );
	
	input wire clk;
	input wire rst;
	output reg [3:0] sec_0;
	output reg [3:0] sec_1;
	output reg [3:0] min_0;
	output reg [3:0] min_1;
	input wire p;
	
	reg [26:0] counter;
	
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
			counter <= 27'b0;
		end
		else if(counter ==  (100000000 - 1) && ~paused) begin
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
		else if(~paused) begin
			counter <= counter + 27'b1;
		end	
		
	end
	
endmodule
