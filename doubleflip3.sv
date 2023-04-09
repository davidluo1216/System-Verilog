module doubleflip3 (Clock, button, reset, key2);	
	input logic button;
	input logic Clock, reset;
	output logic key2;
	logic temp;
	


always_ff @(posedge Clock) begin
	
	
	temp <= ~button;
	key2 <= temp;
	end
	
endmodule
