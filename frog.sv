module frog (Clock, KEY, SW, GrnPixels, L, R, U, D, NL, NR, NU, ND, reset, lost);
	input logic Clock, reset; // 50MHz clock.
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;
	input logic L, R, U, D, NL, NR, NU, ND, lost;
	output logic [15:0][15:0] GrnPixels;
																			  //roll|column
	/*frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[0][0]), 		.NR(GrnPixels[0][2], 	.NU(1‘b0), .ND([1][1]), .lightOn([0][1]);
	
	frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[1][0]), 		.NR(GrnPixels[1][2], 	.NU([0][1]), .ND([2][1]), .lightOn([1][1]);
	frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[2][0]), 		.NR(GrnPixels[2][2], 	.NU([1][1]), .ND([3][1]), .lightOn([2][1]);
	frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[3][0]), 		.NR(GrnPixels[3][2], 	.NU([2][1]), .ND([4][1]), .lightOn([3][1]);
	frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[4][0]), 		.NR(GrnPixels[4][2], 	.NU([3][1]), .ND([5][1]), .lightOn([4][1]);
	frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[5][0]), 		.NR(GrnPixels[5][2], 	.NU([4][1]), .ND([6][1]), .lightOn([5][1]);
	frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[6][0]), 		.NR(GrnPixels[6][2], 	.NU([5][1]), .ND([7][1]), .lightOn([6][1]);
	frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[7][0]), 		.NR(GrnPixels[7][2], 	.NU([6][1]), .ND([8][1]), .lightOn([7][1]);
	frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[8][0]), 		.NR(GrnPixels[8][2], 	.NU([7][1]), .ND([9][1]), .lightOn([8][1]);
	frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[9][0]), 		.NR(GrnPixels[9][2], 	.NU([8][1]), .ND([10][1]), .lightOn([9][1]);
	frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[10][0]), 	.NR(GrnPixels[10][2], 	.NU([9][1]), .ND([11][1]), .lightOn([10][1]);
	frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[11][0]), 	.NR(GrnPixels[11][2], 	.NU([10][1]), .ND([12][1]), .lightOn([11][1]);
	frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[12][0]), 	.NR(GrnPixels[12][2], 	.NU([11][1]), .ND([13][1]), .lightOn([12][1]);
	frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[13][0]), 	.NR(GrnPixels[13][2], 	.NU([12][1]), .ND([14][1]), .lightOn([13][1]);
	frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[14][0]), 	.NR(GrnPixels[14][2], 	.NU([13][1]), .ND([15][1]), .lightOn([14][1]);
	
	frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[15][0]), 	.NR(GrnPixels[15][2], 	.NU([14][1]), .ND(1'b0), .lightOn([15][1]);
	
	frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[1][1]), 		.NR(GrnPixels[1][3], 	.NU([0][2]), .ND([2][2]), .lightOn([1][2]);
	frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[2][1]), 		.NR(GrnPixels[2][3], 	.NU([1][2]), .ND([3][2]), .lightOn([2][2]);
	frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[3][1]), 		.NR(GrnPixels[3][3], 	.NU([2][2]), .ND([4][2]), .lightOn([3][2]);
	frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[4][1]), 		.NR(GrnPixels[4][3], 	.NU([3][2]), .ND([5][2]), .lightOn([4][2]);
	frogLight f1 (.Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[5][1]), 		.NR(GrnPixels[5][3], 	.NU([4][2]), .ND([6][2]), .lightOn([5][2]);*/
	
	// nested for loop to control inner 14x14 lights
	//integer i, j, k, l, m, n;
	
	genvar i, j, k, l, m, n;
	generate	
		for (j = 0; j<14; j = j + 1) begin: a1
			for (i = 0; i<13; i = i + 1) begin: a2
				frogLight f1 (.lost, .Clock(Clock), .reset(reset), .L(L), .R(R), .U(U), .D(D), .NR(GrnPixels[1+i][0+j]), 		.NL(GrnPixels[1+i][2+j]), 	.NU(GrnPixels[0+i][1+j]), .ND(GrnPixels[2+i][1+j]), .lightOn(GrnPixels[1+i][1+j]) );
			end
		end
		endgenerate
	
	
		// row 0 lights
	generate
		for (k = 0; k<14; k = k + 1) begin: a3
			frogLight f2 (.lost, .Clock(Clock), .reset(reset), .L(L), .R(R), .U(U), .D(D), .NR(GrnPixels[0][0+k]), 		.NL(GrnPixels[0][2+k]), 		.NU(GrnPixels[14][1+k]), 					.ND(GrnPixels[1][1+k]), .lightOn(GrnPixels[0][1+k]) );
		end
	endgenerate

		// row 14 lights
	generate
		for (l = 0; l<14; l = l + 1) begin: a4
			frogLight f3 (.lost, .Clock(Clock), .reset(reset), .L(L), .R(R), .U(U), .D(D), .NR(GrnPixels[14][0+l]), 		.NL(GrnPixels[14][2+l]), 	.NU(GrnPixels[13][1+l]), .ND(GrnPixels[15][1+l]), 	.lightOn(GrnPixels[14][1+l]) );
		end
	endgenerate

		// column 0 lights
	generate
		for (m = 0; m<14; m = m + 1) begin: a5
			frogLight f4 (.lost, .Clock(Clock), .reset(reset), .L(L), .R(R), .U(U), .D(D), .NR(GrnPixels[1+m][15]), .NL(GrnPixels[1+m][1]), .NU(GrnPixels[0+m][0]), 	.ND(GrnPixels[2+m][0]), 	.lightOn(GrnPixels[1+m][0]) );
		end
	endgenerate

		// column 15 lights
	generate
		for (n = 0; n<14; n = n + 1) begin: a6
			frogLight f5 (.lost, .Clock(Clock), .reset(reset), .L(L), .R(R), .U(U), .D(D), .NR(GrnPixels[1+n][14]), .NL(GrnPixels[1+n][0]), .NU(GrnPixels[0+n][15]), .ND(GrnPixels[2+n][15]), 		.lightOn(GrnPixels[1+n][15]) );
		end
	endgenerate
		
		
		/* moves frog to the left side when KEY[0] pressed when GrnPixels[0~15][0] is on
		for (n = 0; x<15; x = x + 1) begin
			frogLight f5 (.Clock(Clock), .reset(reset), .L(L), .R(R), .U(U), .D(D), .NL(Grnpixels[0+x][0]), .NR(1'b0), .NU(GrnPixels[-1+x][0]), .ND(GrnPixels[1+x][0]), 		.lightOn(GrnPixels[0+x][15]) );
		end
		
		// moves frog to the right side when KEY[0] pressed when GrnPixels[0~15][15] is on
		for (n = 0; x<13; x = x + 1) begin
			frogLight f5 (.Clock(Clock), .reset(reset), .L(L), .R(R), .U(U), .D(D), .NL(1'b0), .NR(GrnPixels[0+x][15]), .NU(GrnPixels[-1+x][15]), .ND(GrnPixels[1+x][15]), 		.lightOn(GrnPixels[0+x][0]) );
		end*/

	
		frogLight f6 (.lost, .Clock, .reset, .L, .R, .U, .D, .NL(1'b0), 		.NR(GrnPixels[0][1]), 	.NU(1'b0), .ND(GrnPixels[0][1]), .lightOn(GrnPixels[0][0]) );
		frogLight f7 (.lost, .Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[0][14]), 		.NR(1'b0), 	.NU(1'b0), .ND(GrnPixels[1][15]), .lightOn(GrnPixels[0][15]) );
		frogLight f8 (.lost, .Clock, .reset, .L, .R, .U, .D, .NL(1'b0), 		.NR(GrnPixels[15][1]), 	.NU(GrnPixels[14][0]), .ND(1'b0), .lightOn(GrnPixels[15][0]) );
		frogLight f9 (.lost, .Clock, .reset, .L, .R, .U, .D, .NL(GrnPixels[15][14]), 		.NR(1'b0), 	.NU(GrnPixels[14][15]), .ND(1'b0), .lightOn(GrnPixels[15][15]) );
		startFrog f10(.Clock, .reset, .U,  .lightOn(GrnPixels[15][7]) );

	
endmodule 

module frog_testbench ();
	logic [15:0][15:0] GrnPixels;
	logic [3:0]  KEY;
   logic [9:0]  SW;
   logic clk;
	logic L, R, U, D, NL, NR, ND, NU;
	logic reset;
	
	frog dut (.Clock(clk), .reset(SW[0]), .L(KEY[3]), .R(KEY[0]), .U(KEY[1]), .D(KEY[2]), .NL(GrnPixels), .ND, .NR, .NU, .GrnPixels(GrnPixels) );
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
	SW[0] <= 1; 			@(posedge clk); // Always reset FSMs at start
	SW[0] <= 0; 			@(posedge clk);
	KEY[0] <= 0; KEY[1] <= 0; KEY[2] <= 0; KEY[3] <= 0;  @(posedge clk);
	
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	
	SW[0] <= 1; @(posedge clk);
	SW[0] <= 0; @(posedge clk);
	
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; @(posedge clk);
	for (integer a = 0; a < 20; a = a + 1) begin
		KEY[2] <= 0; @(posedge clk);
		KEY[2] <= 1; @(posedge clk);
	end
	
	KEY[2] <= 0; @(posedge clk);
	for (integer b = 0; b < 20; b = b + 1) begin
		KEY[0] <= 0; @(posedge clk);
		KEY[0] <= 1; @(posedge clk);
	end
	
	KEY [0] <= 0; @(posedge clk);
	for (integer b = 0; b < 20; b = b + 1) begin
		KEY[3] <= 0; @(posedge clk);
		KEY[3] <= 1; @(posedge clk);
	end
	

	$stop; // End the simulation.
	end
endmodule 
	
	