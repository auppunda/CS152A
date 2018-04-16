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
reg [3:0] significand1;
reg [2:0] exponent1;
output reg sign;
reg fifthbit;
reg [11:0] negation;
wire [3:0] out;
reg [3:0] pipe;
wire [3:0] F;
wire [2:0] E;
reg [3:0] sig;
reg [2:0] ex;


always @(*) begin
	sign = in[11];
	if (sign) 
		negation = ~in + 1;
	else 
		negation = in;

end
	
priority_encoder encoder( .a(negation), .b(out) );
always @(*) begin
	pipe = 12 - out;
	if (pipe == 1) begin
		significand1 = negation[10:7];
		fifthbit = negation[6];
		exponent1 = 7;
	end
	else if (pipe == 2) begin
		significand1 = negation[9:6];
		fifthbit = negation[5];
		exponent1 = 6;
	end
	else if(pipe == 3) begin
		significand1 = negation[8:5];
		fifthbit = negation[4];
		exponent1 = 5;
	end
	else if(pipe == 4) begin
		significand1 = negation[7:4];
		fifthbit = negation[3];
		exponent1 = 4;
	end
	else if(pipe == 5) begin
		significand1 = negation[6:3];
		fifthbit = negation[2];
		exponent1 = 3;
	end
	else if(pipe == 6) begin
		significand1 = negation[5:2];
		fifthbit = negation[1];
		exponent1 = 2;
	end
	else if(pipe == 7) begin
		significand1 = negation[4:1];
		fifthbit = negation[0];
		exponent1 = 1;
	end
	else 
		exponent1 = 0;
	
	if(pipe >= 8) begin
		significand1 = in[3:0];
		fifthbit = 0;
	end
	sig = significand1;
	ex = exponent1;
end

rounding round( .f(sig), .e(ex), .fifthbit(fifthbit), .F(F), .E(E));

reg [3:0] v;

always @(*) begin
	exponent = E;
	significand = F;
end

endmodule

module rounding ( input wire [3:0] f, input wire [2:0] e, input wire fifthbit, output reg [3:0] F, output reg [2:0] E);
	reg [3:0] v;
	always @* begin
		//E = e;
		//F = f;
		if(fifthbit) 
			v = f + 4'b0001;
		else 
			v = f;
		if(fifthbit && f == 4'b0000) begin
			E = e + 3'b001;
			F = v >> 1;
		end
		else begin
			E = e;
			F = v;
		end
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

