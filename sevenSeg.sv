module sevenSeg (in, in1, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	
	// input and oputput
	input logic in, in1;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	// the corresponding 7 bit out of the number in represent
	always_comb begin
		if (in) begin
						  //6543210	
				HEX5 = 7'b0111111;//-
				HEX4 = 7'b1000111;//L
				HEX3 = 7'b1000000;//0
				HEX2 = 7'b0010010;//s
				HEX1 = 7'b0000110;//E 
				HEX0 = 7'b0111111;//-
			end
			
		else if (in1) begin
			//6543210	
				HEX5 = 7'b0111111;//-
				HEX4 = 7'b0001100;//P
				HEX3 = 7'b0001000;//A
				HEX2 = 7'b0010010;//S
				HEX1 = 7'b0010010;//S
				HEX0 = 7'b0111111;//-
		end

		else begin

				//6543210	
				HEX5 = 7'b1111111;//
				HEX4 = 7'b1111111;//
				HEX3 = 7'b1111111;//
				HEX2 = 7'b1111111;//
				HEX1 = 7'b1111111;//
				HEX0 = 7'b1111111;//			  
			end
	end
		
endmodule

module sevenSeg_testbench ();
  logic  in, in1;
  logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

  sevenSeg dut (.*);

  initial begin
	
	
    $stop();
  end
endmodule

