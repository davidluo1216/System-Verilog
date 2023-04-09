module LFSR(clk, reset, Q);
	output logic [9:0] Q;
	input logic clk, reset; 
	
	logic xnor_out;
	
	assign xnor_out = ~(Q[3] ^ Q[0]); 
	
	always_ff @(posedge clk) begin
		if(reset) Q <= 10'b0000000000;
		
		else Q <= {xnor_out, Q[9: 1]};
	end
endmodule

module LFSR_testbench();
	logic [10:1] Q;
	logic clk, reset;
	logic xnor_out;
	
	LFSR dut(.clk, .reset, .Q);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD / 2)
		clk <= ~clk;
	end
	
	initial begin
		reset <= 1; 						@(posedge clk);
												@(posedge clk);
		reset <= 0;							@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		$stop;
	end
endmodule
