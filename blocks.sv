module blocks (clock, reset, delay, out, lost);
 // localparam constantNumber = 1000;
 input integer delay;
 input logic clock, reset, lost;
 output logic [15:0] out;
 logic [15:0] q;
 
 logic [9:0] count;
 logic x_nor;
 assign x_nor = ~(q[15] ^ q[14] ^ q[12] ^ q[3]);
 
 always_ff @(posedge clock) begin  
	if (reset == 1'b1)
		count <= 10'b0;
	else if (count == delay - 1)
		count <= 10'b0;
	else 
		count <= count + 1'b1;
 end
 
 always_ff @(posedge clock) begin  
  if (reset)
	 q <= 16'b0000000000000000;
	else if (lost)
		q <= q;
  else if (count == delay - 1)
	begin
		q[15] <= q[14];
		q[14] <= q[13];
		q[13] <= q[12];
		q[12] <= q[11];
		q[11] <= q[10];
		q[10] <= q[9];
		q[9] <= q[8];
		q[8] <= q[7];
		q[7] <= q[6];
		q[6] <= q[5];
		q[5] <= q[4];
		q[4] <= q[3];
		q[3] <= q[2];
		q[2] <= q[1];
		q[1] <= q[0];
		q[0] <= x_nor;
	end
  else
	q <= q;
 end
 assign out = q;
endmodule

module blocks_testbench();  
  logic         CLOCK_50;   
  logic  [9:0]  SW;  
  logic [15:0]	out;
  
 blocks dut (CLOCK_50, SW[0], 10, out);  
   
 // Set up a simulated clock.   
 parameter CLOCK_PERIOD=100;  
 initial begin   
  CLOCK_50 <= 0;  
  forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock 
 end  
   
 // Test the design. 
 initial begin   
      SW[0] <=1; repeat(1) @(posedge CLOCK_50);  
		SW[0] <=0; repeat(100) @(posedge CLOCK_50);
  $stop; // End the simulation.  
 end  
endmodule