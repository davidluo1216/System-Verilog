module doubleflip1 (Clock, button, reset, key0);	
	input logic button;
	input logic Clock, reset;
	output logic key0;
	logic temp;
	


always_ff @(posedge Clock) begin
	
	
	temp <= ~button;
	key0 <= temp;
	end
	
endmodule
