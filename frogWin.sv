module frogWin (Clock, reset, GrnPixels, won);
	input logic Clock, reset;
	input logic [15:0][15:0] GrnPixels;
	output logic won;
	
	
	always_comb begin
		won = 1'b0;
		for (integer i  = 0; i < 16; i = i + 1) begin
				if (GrnPixels [0][i] == 1'b1) begin
					won = 1'b1;
				end	
				//else if (reset) lost = 1'b0;
				//else lost = 1'b0;
			end
		end

	
endmodule