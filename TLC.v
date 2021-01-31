`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:40:47 01/27/2021 
// Design Name: 
// Module Name:    TLC 
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
module TLC(clock,reset,serialIn,serialOut,Display,red,yellow,forward_green,right_green,
	 left_green,Ml
    );
	 input clock;
    input reset;
    input [6:0] serialIn;
    output reg [6:0] serialOut;
    output reg [13:0] Display;
	 output reg red = 1;
	 output reg yellow = 0;
	 output reg forward_green = 0;
	 output reg right_green = 0;
	 output reg left_green = 1;
    input [5:0] Ml;
	 
	 integer Display_null = 1;
	 reg [5:0] timer_state = 6'b000000;
	 reg timer_init;
	 
	 reg [5:0] yellow_default = 6'b001010;
	 reg [5:0] red_default = 6'b001010;
	 
	 reg [2:0] light_state = 3'b000;
	 
	 task seven_seg;
		input [4:0] bcd;
		output reg [6:0] seg;
		begin
		case(bcd)
		5'b00000:begin seg = 7'b1111110; end
		5'b00001:begin seg = 7'b0110000; end
		5'b00010:begin seg = 7'b1101101; end
		5'b00011:begin seg = 7'b1111001; end
		5'b00100:begin seg = 7'b0110011; end
		5'b00101:begin seg = 7'b1011011; end
		5'b00110:begin seg = 7'b1011111; end
		5'b00111:begin seg = 7'b1110000; end
		5'b01000:begin seg = 7'b1111111; end
		5'b01001:begin seg = 7'b1111011; end
		5'b11111:begin seg = 7'b0000001; end
		default:begin seg = 7'b0000000; end
		endcase
		end
	 endtask
	 
	 always @(posedge clock)
	 begin
		if(timer_init)
		begin
			if(timer_state == 0)
			begin
				timer_init = 0;
			end
			else
			begin
				timer_state = timer_state - 1;
				seven_seg(timer_state/10, Display[6:0]);
				seven_seg(timer_state%10, Display[13:7]);
			end
		end
		else
		begin
			seven_seg(5'b11111, Display[6:0]);
			seven_seg(5'b11111, Display[13:7]);
		end
	 end
	 
	 always @(posedge reset)
	 begin
		light_state = 3'b000;
		timer_state = red_default;
		timer_init = 1;
	 end
	 
	 always @(serialIn) 
	 begin
		timer_state = serialIn;
		timer_init = 1;
	 end
	 
	 always @(negedge timer_init)
	 begin
		light_state = light_state + 1;
		if(light_state == 3'b011)
		begin
			light_state = 3'b000;
		end
		if(light_state == 3'b001)
		begin
			timer_state = yellow_default;
			timer_init = 1;
		end
		if(light_state == 3'b010)
		begin
			serialOut <= Ml;
			timer_state <= Ml;
			timer_init = 1;
		end
	 end
	 
	 always @(light_state)
	 begin
		case(light_state)
		3'b000:begin red = 1; yellow = 0; forward_green = 0;right_green = 0; end
		3'b001:begin red = 0; yellow = 1; forward_green = 0;right_green = 0; end
		3'b010:begin red = 0; yellow = 0; forward_green = 1;right_green = 1; end
		endcase
	 end

endmodule
