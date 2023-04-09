module lose (Clock, reset, RedPixels, GrnPixels, lost);
	input logic Clock, reset;
	input logic [15:0][15:0] RedPixels, GrnPixels;
	output logic lost;
	
	
	always_comb begin
		lost = 1'b0;
		for (integer i  = 0; i < 16; i = i + 1) begin
			for (integer j  = 0; j < 16; j = j + 1) begin
				if (RedPixels[i][j] == 1'b1 & GrnPixels [i][j] == 1'b1) begin
					lost = 1'b1;
				end	
				//else if (reset) lost = 1'b0;
				//else lost = 1'b0;
			end
		end
	end
	
endmodule

module lose_testbench();
	logic clk, reset;
	logic [15:0][15:0] GrnPixels, RedPixels;
	logic lost;
	
	lose dut (.Clock(clk), .reset(reset) , .RedPixels(RedPixels), .GrnPixels(GrnPixels), .lost(lost) );
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	initial begin
	
	reset <= 1; @(posedge clk);
	reset <= 0; @(posedge clk);
	
	GrnPixels <= '{default: '0}; RedPixels <= '{default: '0}; @(posedge clk);
	
	for (integer i  = 0; i < 16; i = i + 1) begin
			for (integer j  = 0; j < 16; j = j + 1) begin
				GrnPixels[i][j] <= 0;
				RedPixels[i][j] <= 0;
			end
		end @(posedge clk);
	
	GrnPixels[14][7] <= 1; RedPixels[14][7] <= 1; @(posedge clk);
	GrnPixels[14][7] <= 0; RedPixels[14][7] <= 0; @(posedge clk);
	
	GrnPixels[12][8] <= 1; RedPixels[12][8] <= 1; @(posedge clk);
	GrnPixels[12][8] <= 0; RedPixels[12][8] <= 0; @(posedge clk);
	
	GrnPixels[0][0] <= 1; RedPixels[0][0] <= 1; @(posedge clk);
	GrnPixels[0][0] <= 0; RedPixels[0][0] <= 0; @(posedge clk);
	
	GrnPixels[3][3] <= 1; RedPixels[3][3] <= 1; @(posedge clk);
	GrnPixels[3][3] <= 0; RedPixels[3][3] <= 0; @(posedge clk);
	
	GrnPixels[14][7] <= 1; RedPixels[14][6] <= 1; @(posedge clk);
	GrnPixels[14][7] <= 0; RedPixels[14][6] <= 0; @(posedge clk);
	$stop;
	end
endmodule

	