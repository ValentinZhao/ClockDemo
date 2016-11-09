module seg_display(
	input [3:0] i_data,
	input i_dp,
	
	output [6:0] o_seg,
	output o_dp
);

reg [6:0] r_seg;
assign o_dp = i_dp;
assign o_seg = r_seg;

always @(*)
	begin
		case(i_data)
			4'b0000:r_seg = 8'hc0;
			4'b0001:r_seg = 8'hf9;
			4'b0010:r_seg = 8'ha4;
			4'b0011:r_seg = 8'hb0;
			4'b0100:r_seg = 8'h99;
			4'b0101:r_seg = 8'h92;
			4'b0110:r_seg = 8'h82;
			4'b0111:r_seg = 8'hf8;
			4'b1000:r_seg = 8'h80;
			4'b1001:r_seg = 8'h90;
			4'b1010:r_seg = 8'hbf;
			
			default:r_seg = 8'hff;
		endcase
	end
endmodule