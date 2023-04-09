module doubleflip4 (Clock, button, reset, key3);	
	input logic button;
	input logic Clock, reset;
	output logic key3;
	logic temp;
	


always_ff @(posedge Clock) begin
	
	
	temp <= ~button;
	key3 <= temp;
	end
	
endmodule
