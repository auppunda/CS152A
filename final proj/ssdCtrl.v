`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc.
// Engineer: Josh Sackos
// 
// Create Date:    07/11/2012
// Module Name:    ssdCtrl 
// Project Name: 	 PmodJSTK_Demo
// Target Devices: Nexys3
// Tool versions:  ISE 14.1
// Description: This module interfaces the onboard seven segment display (SSD) on
//					 the Nexys3, and formats the data to be displayed.
//
//					 The DIN input is a binary number that gets converted to binary
//					 coded decimals, and is displayed as a 4 digit number on the SSD. The
//					 AN output bus drives the SSD's anodes controling the illumination
//					 of the 4 digits on the SSD.  The SEG output bus drives the cathodes
//					 on the SSD to display different characters.
//
// Revision History: 
// 						Revision 0.01 - File Created (Josh Sackos)
///////////////////////////////////////////////////////////////////////////////////


// ============================================================================== 
// 										  Define Module
// ==============================================================================
module ssdCtrl(
		CLK,
		RST,
		DIN,
		LED,
		x
   );


	// ===========================================================================
	// 										Port Declarations
	// ===========================================================================
			input CLK;						// 100Mhz clock
			input RST;						// Reset
			input [9:0] DIN;				// Input data to display
			
	// ===========================================================================
	// 							  Parameters, Regsiters, and Wires
	// ===========================================================================

			// Outputs to Seven Segment Display
			output [7:0] LED;
			// 1 kHz Clock Divider
			parameter cntEndVal = 16'hC350;
			reg [15:0] clkCount = 16'h0000;
			reg DCLK;

			// 2 Bit Counter
			reg [1:0] CNT = 2'b00;

			// Binary to BCD
			wire [15:0] bcdData;

			// Output Data Mux
			reg [3:0] muxData;
			output reg [15:0] x;

	// ===========================================================================
	// 										Implementation
	// ===========================================================================

			//------------------------------
			//	   Convert Binary to BCD
			//------------------------------
			Binary_To_BCD BtoBCD(
					.CLK(CLK),
					.RST(RST),
					.START(DCLK),
					.BIN(DIN),
					.BCDOUT(bcdData)
			);


			//------------------------------
			//			Output Data Mux
			// Select data to display on SSD
			//------------------------------
			always @(CNT[1], CNT[0], bcdData, RST) begin
					if(RST == 1'b1) begin
							muxData <= 4'b0000;
					end
					else begin
							case (CNT)
									2'b00 : muxData <= bcdData[3:0];
									2'b01 : muxData <= bcdData[7:4];
									2'b10 : muxData <= bcdData[11:8];
									2'b11 : muxData <= bcdData[15:12];
							endcase
					end
			end
			
			
			
			//------------------------------
			//		   Segment Decoder
			// Determines cathode pattern
			//   to display digit on SSD
			//------------------------------
			always @(posedge DCLK) begin
					if(RST == 1'b1) begin
							x <= 0;
					end
					else begin
							x <= bcdData[15:0];
					end
			end

			assign LED = x;


			//---------------------------------
			//	  		  Anode Decoder
			//    Determines digit digit to
			//   illuminate for clock period
			//---------------------------------
			

			//------------------------------
			//			2 Bit Counter
			//	 Used to select which diigt
			//	  is being illuminated, and
			//	selects data to be displayed
			//------------------------------
			always @(posedge DCLK) begin
					CNT <= CNT + 1'b1;
			end
			
			//------------------------------
			//			1khz Clock Divider
			//  Timing for refreshing the
			//  			 SSD, etc.
			//------------------------------
			always @(posedge CLK) begin

							if(clkCount == cntEndVal) begin
									DCLK <= 1'b1;
									clkCount <= 16'h0000;
							end
							else begin
									DCLK <= 1'b0;
									clkCount <= clkCount + 1'b1;
							end
			end
	

endmodule