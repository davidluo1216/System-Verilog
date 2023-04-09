module doubleflip2 (Clock, button, reset, key1);	
	input logic button;
	input logic Clock, reset;
	output logic key1;
	logic temp;
	


always_ff @(posedge Clock) begin
	
	
	temp <= ~button;
	key1 <= temp;
	end
	
endmodule
