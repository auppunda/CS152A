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
module FPCVT ( D, S, E, F );
  input [11:0] D;
  
  output reg [3:0] F;
  output reg [2:0] E;
  output reg S;
   
  reg [11:0] out;
  reg bit5;
  
  always@(*) begin
    S = D[11];
    if(S == 1)
   	  out = -D;
    else
      out = D;
    
    if(out[11] == 1)
      begin
        F = 4'b1110;
        E = 7;
        bit5 = 1;
      end
    else if(out[10] == 1)
      begin
        F = out[10:7];
        E = 7;
        bit5 = out[6];
      end
    else if(out[9] == 1)
      begin
        F = out[9:6];
        E = 6;
        bit5 = out[5];
      end
    else if(out[8] == 1)
      begin
        F = out[8:5];
        E = 5;
        bit5 = out[4];
      end
    else if(out[7] == 1)
      begin
        F = out[7:4];
        E = 4;
        bit5 = out[3];
      end
    else if(out[6] == 1)
      begin
        F = out[6:3];
        E = 3;
        bit5 = out[2];
      end
    else if(out[5] == 1)
      begin
        F = out[5:2];
        E = 2;
        bit5 = out[1];
      end
    else if(out[4] == 1)
      begin
        F = out[4:1];
        E = 1;
        bit5 = out[0];
      end
    else
      begin
        F = out[3:0];
        E = 0;
        bit5 = 0;
      end
    
    if(bit5 == 1)
      begin
        F = F + 1;
        if(F == 0)
        	begin
              E = E + 1;
              if(E == 0)
              	begin
                  F = 15;
                  E = 7;
                end
              else
                  F = 8;
            end
      end
  end
endmodule

