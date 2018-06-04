`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:28:30 05/10/2018 
// Design Name: 
// Module Name:    display 
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
module seven_seg_display( clk, rst, seg, an, reset, pause
    );


input wire clk;
input wire rst;
input wire reset;
input wire pause;
output reg [7:0] seg;
output reg [3:0] an;
	
//wire pause_state;
//wire reset_state;
//wire adjust_state;

//debouncing stuff
wire is_btnP_posedge;
wire is_reset_posedge;
reg [2:0] step_d;
reg [2:0] step_r;

reg [16:0]  clk_dv;
reg         clk_en;
reg         clk_en_d;
wire [17:0] clk_dv_inc;


wire clk_1;
wire seg_clk;
wire blink_clk;

wire [7:0] s_first;
wire [7:0] s_second;
wire [7:0] s_third;
wire [7:0] s_fourth;
wire [7:0] s_blank;

wire [3:0] sec0;
wire [3:0] sec1;
wire [3:0] min0;
wire [3:0] min1;





 
reg [1:0] c = 1;


assign clk_dv_inc = clk_dv + 1;
   
   always @ (posedge clk)
     if (rst)
       begin
          clk_dv   <= 0;
          clk_en   <= 1'b0;
          clk_en_d <= 1'b0;
       end
     else
       begin
          clk_dv   <= clk_dv_inc[16:0];
          clk_en   <= clk_dv_inc[17];
          clk_en_d <= clk_en;
       end
		 
   assign is_btnP_posedge = ~ step_d[0] & step_d[1];
	assign is_reset_posedge = ~step_r[0] & step_r[1];
	
   always @ (posedge clk)
     if (rst) begin
			step_d[2:0]  <= 0;
			step_r[2:0]  <= 0;
	  end
     else if (clk_en) begin// Down sampling 
          step_d[2:0]  <= {pause, step_d[2:1]};
			 step_r[2:0]  <= {reset, step_r[2:1]};
	  end
			 
			

//debouncer re (.butt_in(reset), .clk(clk), .butt_out(res_state));

//debouncer pe (.butt_in(pause), .clk(clk), .butt_out(pause_state));

clockDividers gg1(.clk(clk), .rst(is_reset_posedge), .clk_1(clk_1), .seg_clk(seg_clk), .blink_clk(blink_clk));

counter1 gg2(.clk(clk), .rst(is_reset_posedge), .sec_0(sec0), .sec_1(sec1), .min_0(min0), .min_1(min1), .Led(Led), .p(is_btnP_posedge));
seven_seg s1 (.num(sec0), .seven_s(s_first));
seven_seg s2 (.num(sec1), .seven_s(s_second));

seven_seg s3 (.num(min0), .seven_s(s_third));

seven_seg s4 (.num(min1), .seven_s(s_fourth));

seven_seg blank (.num(4'b1100), .seven_s(s_blank));
			 




always @(posedge seg_clk) begin
	if(1) begin
		if(c == 0) 
		begin
			an  <= 4'b1110;			
			seg <= s_first;
			c <= c + 1;
		end
		if(c == 1) 
		begin
			an <= 4'b1101;
			seg <= s_second;
			c <= c+1;
		end	
		if(c == 2) begin
			an <= 4'b1011;
			seg <= s_third;
			c <= c+1;
		end
		if(c == 3) begin
			an <= 4'b0111;
			seg <= s_fourth;
			c <= c +1;
		end
	end
end

endmodule



module seven_seg( num, seven_s
    );

input wire [3:0] num;
output wire [7:0] seven_s;

reg [7:0] s;

always @(*) begin

case(num)
	4'b0000: s = 8'b11000000;
	4'b0001: s = 8'b11111001;
	4'b0010: s = 8'b10100100;
	4'b0011: s = 8'b10110000;
	4'b0100: s = 8'b10011001;
	4'b0101: s = 8'b10010010;
	4'b0110: s = 8'b10000010;
	4'b0111: s = 8'b11111000;
	4'b1000: s = 8'b10000000;
	4'b1001: s = 8'b10010000;
	default: s = 8'b11111111;
endcase

end 

assign seven_s = s;

endmodule
