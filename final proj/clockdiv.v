`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:49:36 03/19/2013 
// Design Name: 
// Module Name:    clockdiv 
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
module clockdiv(
	input wire clk,		//master clock: 50MHz
	input wire clr,		//asynchronous reset
	output wire dclk,		//pixel clock: 25MHz
	output wire segclk	//7-segment clock: 381.47Hz
	);

// 18-bit counter variable
reg [17:0] q;


// Clock divider --
// Each bit in q is a clock signal that is
// only a fraction of the master clock.
always @(posedge clk or posedge clr)
begin
	// reset condition
	if (clr == 1)
		q <= 0;
	// increment counter by one
	else
		q <= q + 1;
end

// 100Mhz � 2^18 = 381.47Hz
assign segclk = q[17];

// 50Mhz � 2^1 = 25MHz
assign dclk = q[1];

endmodule

module counter(
	clk,
	clr,
	counter
	);
	
input wire clk, clr;
output wire [31:0] counter;
	
localparam GAME_DIV = 1000000;
localparam counter_max = 240
reg [31:0] gameCount;
reg tempgameclk;

reg [255:0] tempcounter=0;

always @(posedge clk or posedge clr) 
begin
	if(clr)
	begin 
		gameCount <= 0;
		tempgameclk <= 1'b0;
	end
	else if(gameCount == GAME_DIV - 1) 
	begin
		gameCount <= 0;
		tempgameclk <= ~gameclk;
	end
	else begin
		gameCount <= gameCount + 1;
	end
end

always @(posedge gameclk or posedge clr)
begin
	if(clr)
	begin
		//tempcounter <= 0;
	end
	else if(counter == 240)
		tempcounter <= 0;
	else
		tempcounter <= counter + 1;
end

assign counter = tempcounter;
assign gameclk = tempgameclk;


endmodule


