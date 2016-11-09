`timescale 1ns/1ns
module seg_display_ctrl(
	input r_rst_n,
	input i_clk,
	input [3:0] i_hour_h, //h represents high
	input [3:0] i_hour_l, //l represents low
	input [3:0] i_minute_h,
	input [3:0] i_minute_l,
	input [3:0] i_second_h,
	input [3:0] i_second_l,
	
	output [7:0] o_seg_control, //pulse output
	output [7:0] o_seg_display  //output what the counter currently displays
);

	reg [3:0] r_display_data;
	reg [2:0] r_cnt;
	reg [7:0] r_seg_control;
	wire w_dp;
	wire [6:0] w_seg_display;

	seg_display I_seg_display(
		.i_data(r_display_data),
		.i_dp(1'b1),
		.o_seg(w_seg_display[6:0]),
		.o_dp(w_dp)
	);
	assign o_seg_display = {w_dp, w_seg_display};
	assign o_seg_control = r_seg_control;
	
	always @(posedge i_clk, negedge r_rst_n)
	begin
		if(1'b0 == r_rst_n)
			r_cnt <= 3'd0;
		else
			r_cnt <= r_cnt + 3'd1;
		end
	//the function below is used to dispatch segment code to eight digital transistors
	always @(*)
	begin
		case(r_cnt)
			3'd0: r_display_data = i_second_l;
			3'd1: r_display_data = i_second_h;
			3'd2: r_display_data = 4'hA; //display "-"
			3'd3: r_display_data = i_minute_l;
			3'd4: r_display_data = i_minute_h;
			3'd5: r_display_data = 4'hA;
			3'd6: r_display_data = i_hour_l;
			3'd7: r_display_data = i_hour_h;
			default: r_display_data = 4'hA;
		endcase
	end
	//the function below is used to display eight digital transistors by turn
	always @(*)
	begin
		case(r_cnt)
			3'd0: r_seg_control = 8'b01111111;
			3'd1: r_seg_control = 8'b10111111;
			3'd2: r_seg_control = 8'b11011111;
			3'd3: r_seg_control = 8'b11101111;
			3'd4: r_seg_control = 8'b11110111;
			3'd5: r_seg_control = 8'b11111011;
			3'd6: r_seg_control = 8'b11111101;
			3'd7: r_seg_control = 8'b11111110;
			default: r_display_data = 8'b11111111;
		endcase
	end
endmodule