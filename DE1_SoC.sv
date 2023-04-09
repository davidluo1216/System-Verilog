// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
    output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output logic [9:0]  LEDR;
    input  logic [3:0]  KEY;
    input  logic [9:0]  SW;
    output logic [35:0] GPIO_1;
    input logic CLOCK_50;

	 // Turn off HEX displays
    /*assign HEX0 = '1;
    assign HEX1 = '1;
    assign HEX2 = '1;
    assign HEX3 = '1;
    assign HEX4 = '1;
    assign HEX5 = '1;*/
	 
	 
	 /* Set up system base clock to 1526 Hz (50 MHz / 2**(14+1))
	    ===========================================================*/
	 logic [31:0] clk;
	 logic SYSTEM_CLOCK;
	 
	 clock_divider divider (.clock(CLOCK_50), .divided_clocks(clk));
	 
	 assign SYSTEM_CLOCK = clk[14]; // 1526 Hz clock signal	 
	 
	 /* If you notice flickering, set SYSTEM_CLOCK faster.
	    However, this may reduce the brightness of the LED board. */
	
	 
	 /* Set up LED board driver
	    ================================================================== */
	 logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs
    logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
	 logic RST;                   // reset - toggle this on startup
	 
	 assign RST = SW[0];
	 
	 /* Standard LED Driver instantiation - set once and 'forget it'. 
	    See LEDDriver.sv for more info. Do not modify unless you know what you are doing! */
	 LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST, .EnableCount(1'b1), .RedPixels, .GrnPixels, .GPIO_1);
	 
	 
	 /* LED board test submodule - paints the board with a static pattern.
	    Replace with your own code driving RedPixels and GrnPixels.
		 
	 	 KEY0      : Reset
		 =================================================================== */
	logic key0, key1, key2, key3;
	 doubleflip1 df1(.Clock(SYSTEM_CLOCK), .reset(RST), .button(KEY[0]), .key0(key0));
	 doubleflip2 df2(.Clock(SYSTEM_CLOCK), .reset(RST), .button(KEY[1]), .key1(key1));
	 doubleflip3 df3(.Clock(SYSTEM_CLOCK), .reset(RST), .button(KEY[2]), .key2(key2));
	 doubleflip4 df4(.Clock(SYSTEM_CLOCK), .reset(RST), .button(KEY[3]), .key3(key3));
	 
	logic L, R, U, D;
	userInput left 	(.Clock(SYSTEM_CLOCK), .reset(RST), .button(key0), .on(R));
	userInput right 	(.Clock(SYSTEM_CLOCK), .reset(RST), .button(key1), .on(U));
	userInput up 		(.Clock(SYSTEM_CLOCK), .reset(RST), .button(key2), .on(D));
	userInput down 	(.Clock(SYSTEM_CLOCK), .reset(RST), .button(key3), .on(L));
	
	logic NL, NR, NU, ND;
	frog f1(.lost, .Clock(SYSTEM_CLOCK), .KEY(KEY), .SW(SW), .GrnPixels(GrnPixels), .L(L), .R(R), .U(U), .D(D), .NL, .NR, .NU, .ND, .reset(RST) );
	
	car c1(.reset(RST), .RedPixels(RedPixels), .clk(SYSTEM_CLOCK), .lost(lost) );
	
	logic lost;
	lose lose1(.Clock(SYSTEM_CLOCK), .reset(RST), .RedPixels(RedPixels), .GrnPixels(GrnPixels), .lost(lost) );
	
	logic won;
	frogWin frogWin1(.Clock(SYSTEM_CLOCK),. reset(RST), .GrnPixels(GrnPixels), .won(won) );
	
	sevenSeg seg(.in(lost), .in1(won), .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5);
endmodule