module comparator(Clock, reset, A, B, press);
	output logic press;
	input logic [9:0] B;
	input logic [9:0] A; //A - switch, B - LFSR
	input logic Clock, reset;
	
	logic compare;
	
	always_comb begin
		compare = (A > B);
	end
	
	always_ff @(posedge Clock) begin
		if (reset) press <= 0;
		else press <= compare;
	end
	
endmodule

	
module comparator_testbench();
	logic [9:0] A, B;
	logic clk, reset;
	logic press;
	
	comparator dut(.Clock(clk), .reset, .A, .B, .press);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD / 2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; 						@(posedge clk);
												@(posedge clk);
		reset <= 0;							@(posedge clk);
		A <= 10'b0000000001;										@(posedge clk);
		B <= 10'b0000000010;										@(posedge clk);
		A <= 10'b1111100000;										@(posedge clk);
		B <= 10'b0010000010;										@(posedge clk);
		A <= 10'b1000000001;										@(posedge clk);
		B <= 10'b1000000010;										@(posedge clk);
		reset <= 1;										@(posedge clk);
		reset <= 0;										@(posedge clk);
		A <= 10'b0000000011;										@(posedge clk);
		B <= 10'b0010000010;										@(posedge clk);
		A <= 10'b1000000001;										@(posedge clk);
		B <= 10'b1000000010;										@(posedge clk);									
		$stop;
	end
endmodule
