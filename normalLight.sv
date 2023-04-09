module normalLight (Clock, reset ,L, R, NL, NR, lightOn);
	input logic Clock, reset;
	input logic L, R, NL, NR;
	output logic lightOn;
	
	enum {ON, OFF} ps, ns;
	
	// Next State logic
	always_comb begin
		case (ps)
			OFF: 	if (R & NL | L & NR) ns = ON;
					else ns = OFF;
					
			ON:	if (R & L) ns = ON;
					else if (R ^ L) ns = OFF;
					else ns = ON;
					
			//default:ns = 1'bx;
			
		endcase
	end
	

		assign lightOn =  (ps == ON);
	
	//DFFs, output logic
	always_ff @(posedge Clock) begin
		if (reset)
				ps <= OFF;
		else ps <= ns;
		end
		
endmodule

module normalLight_testbench();
	logic clk, reset;
	logic L, R, NL, NR, lightOn;
	logic [9:0] SW;
	logic [9:0] LEDR;
	
	normalLight dut (.Clock(clk), .reset(reset) ,.L(L), .R(R), .NL(NL), .NR(NR), .lightOn(lightOn));
	//normalLight dut (.Clock(clk), reset ,L, R, NL, NR, lightOn );
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin

								@(posedge clk);

	reset <= 1; 			@(posedge clk); // Always reset FSMs at start
	reset <= 0; 			@(posedge clk);
	R <= 0; NL <= 0; NR <= 0; L <= 0; @(posedge clk);
								
					R <= 1; 	@(posedge clk);
					NL <= 1; @(posedge clk);
					NL <= 0;	@(posedge clk);
					R <= 0;	@(posedge clk);
					
					L <= 1;	@(posedge clk);
					NR <= 1;	@(posedge clk);
					NR <= 0; @(posedge clk);
					L <=0; 	@(posedge clk);
					
					L <= 1;	@(posedge clk);
					R <= 1; 	@(posedge clk);
					

	$stop; // End the simulation.
	end
endmodule 