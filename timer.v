`timescale 1ns/1ns
module timer(
	input i_reset_n,
	input i_clk,
	
	output [3:0] o_hour_h,
	output [3:0] o_hour_l,
	output [3:0] o_minute_h,
	output [3:0] o_minute_l,
	output [3:0] o_second_h,
	output [3:0] o_second_l
);

	reg [3:0] r_hour_h;
	reg [3:0] r_hour_l;
	reg [3:0] r_minute_h;
	reg [3:0] r_minute_l;
	reg [3:0] r_second_h;
	reg [3:0] r_second_l;
	
	assign o_hour_h = r_hour_h;
	assign o_hour_l = r_hour_l;
	assign o_minute_h = r_minute_h;
	assign o_minute_l = r_minute_l;
	assign o_second_h = r_second_h;
	assign o_second_l = r_second_l;
	
	always @(posedge i_clk, negedge i_reset_n)
	begin
		if(1'b0 == i_reset_n)
			r_second_l <= 4'd0;
		else
			if(4'd9 == r_second_l)
				r_second_l <= 4'd0;
			else
				r_second_l <= r_second_l + 4'd1;
	end
	
	always @(posedge i_clk, negedge i_reset_n)
	begin
		if(1'b0 == i_reset_n)
			r_second_h <= 4'd0;
		else
			if(4'd9 == r_second_l)
				if(4'd5 == r_second_h)
					r_second_h <= 4'd0;
				else
					r_second_h <= r_second_h + 4'd1;
	end
	
	always @(posedge i_clk, negedge i_reset_n)
	begin
		if(1'b0 == i_reset_n)
			r_minute_l <= 4'd0;
		else
			if(4'd9 == r_second_l && 4'd5 == r_second_h)
				if(4'd9 == r_minute_l || (4'd2 == r_hour_h && 4'd3 == r_hour_l))
					r_minute_l <= 4'd0;
				else
					r_minute_l <= r_minute_l + 4'd1;
	end
	
	always @(posedge i_clk, negedge i_reset_n)
	begin
		if(1'b0 == i_reset_n)
			r_minute_h <= 4'd0;
		else
			if(4'd9 == r_second_l && 4'd5 == r_second_h && 4'd9 == r_minute_l)
				if(4'd5 == r_minute_h)
					r_minute_h <= 4'd0;
				else
					r_minute_h <= r_minute_h + 4'd1;
	end
	
	always @(posedge i_clk, negedge i_reset_n)
	begin
		if(1'b0 == i_reset_n)
			r_hour_l <= 4'd0;
		else
			if(4'd9 == r_second_l && 4'd5 == r_second_h && 4'd9 == r_minute_l && 4'd5 == r_minute_h)
				if((4'd9 == r_hour_l) || (4'd2 == r_hour_h) && (4'd3 == r_hour_l))
					r_hour_l <= 4'd0;
				else
					r_hour_l <= r_hour_l + 4'd1;
	end
	
	always @(posedge i_clk, negedge i_reset_n)
	begin
		if(1'b0 == i_reset_n)
			r_hour_h <= 4'd0;
		else
			if(4'd9 == r_second_l && 4'd5 == r_second_h && 4'd9 == r_minute_l && 4'd5 == r_minute_h && 4'd3 == r_hour_l)
				begin
					if(4'd2 == r_hour_h)
						r_hour_h <= 4'd0;
				end
			else
				begin
					if(4'd9 == r_second_l && 4'd5 == r_second_h && 4'd9 == r_minute_l && 4'd5 == r_minute_h && 4'd9 == r_hour_l)
						r_hour_h <= r_hour_h + 4'd1;
				end
	end
endmodule