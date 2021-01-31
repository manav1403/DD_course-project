`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:44:48 01/27/2021
// Design Name:   TLC
// Module Name:   D:/Lab1/TLC_test.v
// Project Name:  Lab1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TLC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TLC_test;

	// Inputs
	reg clock;
	reg reset;
	reg [6:0] serialIn;
	reg [5:0] Ml;

	// Outputs
	wire [6:0] serialOut;
	wire [13:0] Display;
	wire red;
	wire yellow;
	wire green;

	// Instantiate the Unit Under Test (UUT)
	TLC uut (
		.clock(clock), 
		.reset(reset), 
		.serialIn(serialIn), 
		.serialOut(serialOut), 
		.Display(Display), 
		.red(red), 
		.yellow(yellow), 
		.green(green), 
		.Ml(Ml)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		
		Ml = 6'b001000;
		forever begin
		#10 clock = ~clock;
		end
		#20 serialIn = 7'b0010000;
		
        
		// Add stimulus here

	end
	initial begin
		reset = 1;
		#10 reset = 0;
		#20 serialIn = 7'b0010000;
		
        
		// Add stimulus here

	end
      
endmodule

