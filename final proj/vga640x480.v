`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:    vga640x480 
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
module vga640x480(
	input wire dclk,			//pixel clock: 25MHz
	input wire clr,			//asynchronous reset
	output wire hsync,		//horizontal sync out
	output wire vsync,		//vertical sync out
	output reg [2:0] red,	//red vga output
	output reg [2:0] green, //green vga output
	output reg [1:0] blue	//blue vga output
	);

// video structure constants
parameter hpixels = 800;// horizontal pixels per line
parameter vlines = 521; // vertical lines per frame
parameter hpulse = 96; 	// hsync pulse length
parameter vpulse = 2; 	// vsync pulse length
parameter block_size = 50;
parameter hbp = 144; 	// end of horizontal back porch
parameter hfp = 784; 	// beginning of horizontal front porch
parameter vbp = 31; 		// end of vertical back porch
parameter vfp = 511; 	// beginning of vertical front porch
// active horizontal video is therefore: 784 - 144 = 640
// active vertical video is therefore: 511 - 31 = 480

reg [3:0] spawn_state = 0;
reg [3:0] blocks [55:0];
reg [3:0] colors [55:0];

// registers for storing the horizontal & vertical counters
reg [9:0] hc;
reg [9:0] vc;

reg [4:0] num_cubes = 20;
reg [2:0] color = 0;


wire segclk, gameclk;
wire [31:0] counter;

counter gg(.clk(dclk), .clr(clr), .counter(counter));

// Horizontal & vertical counters --
// this is how we keep track of where we are on the screen.
// ------------------------
// Sequential "always block", which is a block that is
// only triggered on signal transitions or "edges".
// posedge = rising edge  &  negedge = falling edge
// Assignment statements can only be used on type "reg" and need to be of the "non-blocking" type: <=
always @(posedge dclk or posedge clr)
begin
	// reset condition
	if (clr == 1)
	begin
		hc <= 0;
		vc <= 0;
	end
	else
	begin
		// keep counting until the end of the line
		if (hc < hpixels - 1)
			hc <= hc + 1;
		else
		// When we hit the end of the line, reset the horizontal
		// counter and increment the vertical counter.
		// If vertical counter is at the end of the frame, then
		// reset that one too.
		begin
			hc <= 0;
			if (vc < vlines - 1)
				vc <= vc + 1;
			else
				vc <= 0;
		end
		
	end
end

// generate sync pulses (active low)
// ----------------
// "assign" statements are a quick way to
// give values to variables of type: wire
assign hsync = (hc < hpulse) ? 0:1;
assign vsync = (vc < vpulse) ? 0:1;

reg [3:0] iter;
reg [3:0] iter2;
// display 100% saturation colorbars
// ------------------------
// Combinational "always block", which is a block that is
// triggered when anything in the "sensitivity list" changes.
// The asterisk implies that everything that is capable of triggering the block
// is automatically included in the sensitivty list.  In this case, it would be
// equivalent to the following: always @(hc, vc)
// Assignment statements can only be used on type "reg" and should be of the "blocking" type: =
always@ (*) begin
    for(iter2 = 0; iter2 < 12; iter2 = iter2 + 1) begin
        if(spawn_state == iter2) begin
            blocks[iter2*4] = iter2*1*32 % (hbp - hfp);
            blocks[iter2*4 + 1] = iter2*2*32 % (hbp - hfp);
            blocks[iter2*4 + 2] = iter2*3*32 % (hbp - hfp);
            blocks[iter2*4 + 3] = iter2*4*32 % (hbp - hfp);
            colors[iter2*4] = 2 % (6);
            colors[iter2*4 + 1] = 3 % (6);
            colors[iter2*4 + 2] = 5 % (6);
            colors[iter2*4 + 3] = 4 % (6);
        end
    end
end

always @(*)
begin

    for (iter = 0; iter < 12; iter = iter + 1) begin
        if( vc >= (vbp + iter*32 + (2*counter%(vbp-vfp))) && vc < (vbp + (iter+1)*32 + 2*counter%(vbp-vfp))) begin
            if(hc >= (hbp + blocks[iter*4]) && hc < (hbp + blocks[iter*4] + 32)) begin
                color = colors[iter*4];
            end
            else if(hc >= (hbp + blocks[iter*4 + 1]) && hc < (hbp + blocks[iter*4 + 1] + 32)) begin
                color = colors[iter*4 + 1];
            end
            else if(hc >= (hbp + blocks[iter*4 + 2]) && hc < (hbp + blocks[iter*4 + 2] + 32)) begin
                color = colors[iter*4 + 2];
            end
            else if(hc >= (hbp + blocks[iter*4 + 3]) && hc < (hbp + blocks[iter*4 + 3] + 32)) begin
                color = colors[iter*4 + 3];
            end
            else begin
                color = 3'b111;
            end
        end

        if (vfp >= (vbp + iter*32 + (2*counter)) begin
            spawn_state = iter;
        end
    end

    
	// first check if we're within vertical active video range
//    if (vc >= vbp && vc < vfp && hc >= hbp && hc < hfp)
//    begin
//        // now display different colors every 80 pixels
//        // while we're within the active horizontal range
//        // -----------------
//        // display white bar
//        if(vc >= (vbp + (2 * counter)) && vc < (vbp + (32 + 2*(counter))))
//        begin
//            if(hc >= (352 + hbp) && hc < (384 + hbp))
//                color = 3'b110;
//            else if(hc >= (128 + hbp) && hc < (160 + hbp))
//                color = 3'b100;
//            else
//                color = 3;
//        end
//        else if (vc >= (vbp + 32 + 2* counter) && vc < (vbp + 64 + 2*counter))
//        begin
//            if(hc >= (32 + hbp) && hc < (64 + hbp))
//                color = 3'b101;
//            else if(hc >= (224 + hbp) && hc < (256 + hbp))
//                color = 4;
//            else
//                color = 3;
//        end
//        else if (vc >= (vbp + 64 + 2*counter) && vc < (vbp + 96 + 2*counter))
//        begin
//            if(hc >= (160 + hbp) && hc < (192 + hbp))
//                color = 8;
//            else
//                color = 3;
//        end
//        else if(vc >= (vbp + 96 + 2*counter) && vc < (vbp + 128 + 2*counter))
//        begin
//            if(hc >= (448 + hbp) && hc < (480 + hbp))
//                color = 0;
//            else
//                color = 3;
//        end
//        else if (vc >= (vbp + 128 + 2*counter) && vc < (vbp + 160 + 2*counter))
//        begin
//            if(hc >= (128 + hbp) && hc < (160 + hbp))
//                color = 1;
//            else
//                color = 3;
//        //    red = 3'b111;
//        //    green = 3'b111;
//        //    blue = 2'b11;
//        end
//        else if ( vc >= (vbp + 192 + 2*counter) && vc < (vbp + 224 + 2*counter) )
//        begin
//            if(hc >= (hbp + 160) && hc < (192 + hbp))
//                color = 3'b011;
//            else
//                color = 3'b100;
//        end
//        else if ( vc >= (vbp + 256 + 2*counter) && vc < (vbp + 288 + 2*counter))
//        begin
//            if( hc >= (192 + hbp) && hc < (224 + hbp) )
//                color = 2;
//            else if( hc >= (576 + hbp) && hc < (608 + hbp) )
//                color = 7;
//            else if( hc >= (hbp + 64) && hc < (96 + hbp) )
//                color = 4;
//            else
//                color = 3;
//        end
//        else if ( vc >= (vbp + 288 + 2*counter) && vc < (vbp + 320 + 2*counter))
//        begin
//            if(hc >= (hbp + 544) && hc < (hbp + 576))
//                color = 5;
//            else if(hc >= (hbp + 416) && hc < (hbp + 448))
//                color = 0;
//            else
//                color = 3;
//        end
//        else if ( vc >= (vbp + 320 + 2*counter) && vc < (vbp + 352 + 2*counter))
//        begin
//            if(hc >= (160 + hbp) && hc < (192 + hbp))
//                color = 6;
//            else
//                color = 3;
//        end
//        else if ( vc >= (vbp + 352 + 2*counter) && vc < (vbp + 384 + 2*counter) )
//        begin
//            if(hc >= (512 + hbp) && hc < (544 + hbp))
//                color = 4;
//            else if( hc >= (128 + hbp) && hc < (160 + hbp) )
//                color = 6;
//            else
//                color = 3;
//        end
//        else if ( vc >= (vbp + 384 + 2*counter) && vc < (vbp + 416 + 2*counter) )
//        begin
//            if( hc >= (448 + hbp) && hc < (480 + hbp) )
//                color = 2;
//            else if( hc >= (192 + hbp) && hc < (224 + hbp) )
//                color = 1;
//            else
//                color = 3'b111;
//        end
//        else if ( vc >= (vbp + 416 +  2*counter) && vc < (vbp + 448 + 2*counter) )
//        begin
//            if(hc >= (416 + hbp) && hc < (hbp + 448))
//                color = 6;
//            else
//                color = 3'b111;
//        end
//        else if ( vc >= (vbp + 448 + 2*counter) && vc < (vbp + 480+2*counter) )
//        begin
//            if(hc >= (320 + hbp) && hc < (hbp + 352))
//                color = 5;
//            else
//                color = 3'b111;
//        end
//        else
//        begin
//            color = 3'b111;
//        end
//        // display yellow bar
//        //else if (hc >= (hbp+80) && hc < (hbp+160))
//        //begin
//        //    red = 3'b111;
//        //    green = 3'b111;
//        //    blue = 2'b00;
//        //end
//        // display cyan bar
//        //else if (hc >= (hbp+160) && hc < (hbp+240))
//        //begin
//        //    red = 3'b000;
//        //    green = 3'b111;
//        //    blue = 2'b11;
//        //end
//        // display green bar
//        //else if (hc >= (hbp+240) && hc < (hbp+320))
//        //begin
//        //    red = 3'b000;
//        //    green = 3'b111;
//        //    blue = 2'b00;
//        //end
//        // display magenta bar
//        //else if (hc >= (hbp+320) && hc < (hbp+400))
//        //begin
//        //    red = 3'b111;
//        //    green = 3'b000;
//        //    blue = 2'b11;
//        //end
//        // display red bar
//        //else if (hc >= (hbp+400) && hc < (hbp+480))
//        //begin
//        //    red = 3'b111;
//        //    green = 3'b000;
//        //    blue = 2'b00;
//        //end
//        // display blue bar
//        //else if (hc >= (hbp+480) && hc < (hbp+560))
//        //begin
//        //    red = 3'b000;
//        //    green = 3'b000;
//        //    blue = 2'b11;
//        //end
//        // display black bar
//        //else if (hc >= (hbp+560) && hc < (hbp+640))
//        //begin
//        //    red = 3'b000;
//        //    green = 3'b000;
//        //    blue = 2'b00;
//        //end
//        // we're outside active horizontal range so display black
//    end
//    // we're outside active vertical range so display black
//    else
//    begin
//        color = 3'b011;
//    end
end

always @(*)
begin
	case(color)
		3'b000:	
				begin
				red = 3'b111;
				green = 3'b111;
				blue = 2'b11;
				end
		3'b001: 
				begin
				red = 3'b111;
				green = 3'b111;
				blue = 2'b00;
				end
		3'b010:
			begin
				red = 3'b000;
				green = 3'b111;
				blue = 2'b11;
			end
		3'b100:
			begin
				red = 3'b000;
				green = 3'b111;
				blue = 2'b00;
			end
		3'b101:
			begin
				red = 3'b111;
				green = 3'b000;
				blue = 2'b11;
			end
		3'b110:
			begin
				red = 3'b111;
				green = 3'b000;
				blue = 2'b00;
			end
		3'b011:
			begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b11;
			end
		3'b111:
			begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
	endcase

end

endmodule

module lfsr    (
out             ,  // Output of the counter
enable          ,  // Enable  for counter
clk             ,  // clock input
reset              // reset input
);

//----------Output Ports--------------
output [7:0] out;
//------------Input Ports--------------
input [7:0] data;
input enable, clk, reset;
//------------Internal Variables--------
reg [7:0] out;
wire        linear_feedback;

//-------------Code Starts Here-------
assign linear_feedback = !(out[7] ^ out[3]);

always @(posedge clk)
if (reset) begin // active high reset
out <= 8'b0 ;
end else if (enable) begin
out <= {out[6],out[5],
    out[4],out[3],
    out[2],out[1],
    out[0], linear_feedback};
end

endmodule // End Of Module counter
