module userInput (Clock, reset , button, on);
	input logic Clock, reset;
	input logic button;
	output logic on;
	
	enum {ON, OFF} ps, ns;
	
	// Next State logic
	always_comb begin
		case (ps)
			OFF: 	if (button) ns = ON;
					else ns = OFF;
					
			ON:	if (button) ns = ON;
					else ns = OFF;
					
			//default:ns = 1'bx;
			
		endcase
	end
	
	assign on =  (ps == ON & ns == OFF);
	
	//DFFs, output logic
	always_ff @(posedge Clock) begin
		if (reset)
				ps <= OFF;
		else ps <= ns;
		end
		
endmodule

module userInput_testbench();
	logic clk, reset;
	logic button, on;
	logic [9:0] SW;
	logic [9:0] LEDR;
	
	userInput dut (.Clock(clk), .reset(reset) , .button(button),  .on(on) );

	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin

								@(posedge clk);

	reset <= 1; 			@(posedge clk); // Always reset FSMs at start
	reset <= 0; 	button <= 0;		@(posedge clk);
	button <= 1;							@(posedge clk);
												@(posedge clk);
	button <= 0;							@(posedge clk);
	@(posedge clk);
	@(posedge clk);

	$stop; // End the simulation.
	end
endmodule 