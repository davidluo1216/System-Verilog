module startFrog (Clock, reset, U, lightOn);
	input logic Clock, reset;
	//input logic L, R, U, D, NL, NR, NU, ND;
	input U;
	output logic lightOn;
	//logic VALID;
	//assign VALID = !((R & (L | U | D)) | (L & (U | D)) | (U & D));
	enum {ON, OFF} ps, ns;
	
	
	// Next State logic
	always_comb begin
		case (ps)
			OFF: 	if ( reset ) ns = ON;
					else ns = OFF;
					
			ON:	if ( U ) ns = OFF;
					else ns = ON;
					
			//default:ns = 1'bx;
			
		endcase
	end
	

		assign lightOn =  (ps == ON);
	
	//DFFs, output logic
	always_ff @(posedge Clock) begin
		if (reset)
				ps <= ON;
		else ps <= ns;
		end
		
endmodule