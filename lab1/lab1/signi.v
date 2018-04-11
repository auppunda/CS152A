`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:24:40 04/11/2018 
// Design Name: 
// Module Name:    signi 
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
module signi( in, significand, exponent, sign);

input wire [11:0] in;
output reg [3:0] significand;
output reg [2:0] exponent;
output reg sign;
reg [11:0] negation;
wire [3:0] out;
wire [3:0] outprime;
reg [3:0] pipe;


always @(*) begin
	sign = in[11];
	if (sign) 
		negation = ~in + 1;
	else 
		negation = in;

end
	
priority_encoder encoder( .a(negation), .b(out));
always @(*) begin
	pipe = 12 - out;
	if (pipe == 1) begin
		significand = negation[10:7];
		exponent = 7;
	end
	else if (pipe == 2) begin
		significand = negation[9:6];
		exponent = 6;
	end
	else if(pipe == 3) begin
		significand = negation[8:5];
		exponent = 5;
	end
	else if(pipe == 4) begin
		significand = negation[7:4];
		exponent = 4;
	end
	else if(pipe == 5) begin
		significand = negation[6:3];
		exponent = 3;
	end
	else if(pipe == 6) begin
		significand = negation[5:2];
		exponent = 2;
	end
	else if(pipe == 7) begin
		significand = negation[4:1];
		exponent = 1;
	end
	else 
		exponent = 0;
	
	if(pipe >= 8) 
		significand = in[4:0];
end

endmodule


module priority_encoder ( input wire [11:0] a , output reg [3:0] b);
	always @* begin
		if(a[11]) 
			b = 4'b1100;
		else if (a[10])
			b = 4'b1011;
		else if (a[9])
			b = 4'b1010;
		else if (a[8])
			b = 4'b1001;
		else if (a[7])
			b = 4'b1000;
		else if (a[6])
			b = 4'b0111;
		else if (a[5])
			b = 4'b0110;
		else if (a[4])
			b = 4'b0101;
		else if (a[3])
			b = 4'b0100;
		else if (a[2])
			b = 4'b0011;
		else if (a[1])
			b = 4'b0010;
		else if (a[0])
			b = 4'b0001;
		else
			b = 4'b0000;
	end
endmodule
