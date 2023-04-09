module car(reset, RedPixels, clk, lost);
	input logic reset, clk, lost;
	output logic [15:0][15:0] RedPixels;
	blocks row1 (.clock(clk), .reset, .delay(600), .out(RedPixels[01]), .lost);
	blocks row3 (.clock(clk), .reset, .delay(500), .out(RedPixels[03]), .lost );
	blocks row5 (.clock(clk), .reset, .delay(400), .out(RedPixels[05]), .lost );
	blocks row7 (.clock(clk), .reset, .delay(300), .out(RedPixels[07]), .lost );
	blocks row9 (.clock(clk), .reset, .delay(200), .out(RedPixels[09]), .lost );
	blocks row11 (.clock(clk), .reset, .delay(100), .out(RedPixels[11]), .lost );
	blocks row13 (.clock(clk), .reset, .delay(700), .out(RedPixels[13]), .lost );
	
endmodule


module car_testbench();
	logic reset, clk;
	logic [15:0][15:0] RedPixels;
	
	car dut (.reset, .RedPixels, .clk);
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	initial begin
		reset <= 1'b1; @(posedge clk);
		reset <= 1'b0; repeat(100) @(posedge clk);
		$stop;
	end
		
endmodule