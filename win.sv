module win (Clock, reset, LED9, LED1, L, R, win1, win2);	
	input logic LED9, LED1;
	input logic L, R;
	input logic Clock, reset;
	output logic  win1;
	output logic win2;
	
	enum {off, p1Win, p2Win} ps, ns;
	always_comb begin
		case(ps)
			off: if (LED9 & L & ~R) ns = p2Win;
				  else if (LED1 & R & ~L) ns = p1Win;
				  else ns = off;
				  
			p1Win: ns = p1Win;
			p2Win: ns = p2Win;
		
		endcase
		
		if (ps == p1Win) begin
			win1 = 1;
			win2 = 0;
		end else if (ps == p2Win) begin
			win2 = 1;
			win1 = 0;
		end else begin 	
			win1 = 0;
			win2 = 0;
		end
	end
	
	
	always_ff @(posedge Clock) begin
		if (reset) ps <= off;
		else ps <= ns;
		
	end
	
endmodule

module win_testbench();
	logic clk, reset;
	logic LED9, LED1, L, R;
	logic win1, win2;
	
	win dut (.Clock(clk), .reset(reset) , .LED9(LED9), .LED1(LED1),  .L(L), .R(R) , .win1(win1), .win2(win2) );

	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin

								@(posedge clk);

	reset <= 1; 			@(posedge clk); // Always reset FSMs at start
	reset <= 0; 	LED9 <= 0; LED1 <= 0; L <=0; R<=0;		@(posedge clk);
						LED9 <= 1;					@(posedge clk);
						L <= 1;						@(posedge clk);
						R <= 0;						@(posedge clk);
						LED9 <= 0; L <= 0; 		@(posedge clk);
						
						reset <= 1;					@(posedge clk);

						reset <= 0; @(posedge clk);
						
						LED1 <= 1;					@(posedge clk);
						R <= 1;						@(posedge clk);
						L <= 0;						@(posedge clk);
						LED1 <= 0; R <= 0; 		@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);

	$stop; // End the simulation.
	end
endmodule 
