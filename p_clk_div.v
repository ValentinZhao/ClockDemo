`timescale 1ns/1ns
module p_clk_div
	#(
		parameter CONEFFCIENT = 12,
		parameter CNT_WIDTH = 4
	)
	(
		input i_reset_n,
		input i_clk,
		
		output o_div_clk
	);
	
	reg [CNT_WIDTH - 1:0] r_cnt;
	reg r_div_clk;
	assign o_div_clk = r_div_clk;
	
	always @(posedge i_clk, negedge i_reset_n)
	begin
		if(1'b0 == i_reset_n)
			r_cnt <= 2'd0;
		else
			if((CONEFFCIENT/2 - 1) == r_cnt)
				r_cnt <= 0;
			else
				r_cnt <= r_cnt + 1;
	end
	
	always @(posedge i_clk, negedge i_reset_n)
	begin
		if(1'b0 == i_reset_n)
			r_div_clk <= 1'b0;
		else
			if((CONEFFCIENT/2 - 1) == r_cnt)
				r_div_clk <= ~r_div_clk;
	end
endmodule