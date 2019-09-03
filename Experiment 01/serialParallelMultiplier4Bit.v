module multiplier(output reg [7:0] out, output finish, input reset, input clk, input [3:0] A, input [3:0] B);
	reg [3:0] State; // state machine
	reg [8:0] ACC; // Accumulator
	assign finish = (State == 9) ? 1'b1:1'b0; // Finish Flag

	always@(posedge clk, A, B) begin
		if(reset) begin
			State <= 0;
			ACC <= 0;
			out <= out;
		end
		else if (State == 0) begin
			ACC[8:4] <= 5'b0; // begin cycle
			ACC[3:0] <= A; // Load A (one of our inputs)
			State <= 1;
		end
		else if (State == 1 || State == 3 || State == 5 || State == 7) begin
		// add/shift State
			if(ACC[0] == 1'b1) begin // add multiplicand
				ACC[8:4] <= {1'b0, ACC[7:4]} + B;
				State <= State + 1;
			end
			else begin
				ACC <= {1'b0, ACC[8:1]}; // shift right
				State <= State + 2;
			end
		end
		else if(State == 2 || State == 4 || State == 6 || State == 8) begin
		// shift State
			ACC <= {1'b0, ACC[8:1]}; // shift right
			State <= State + 1;
		end
	end
	
	always @(State) begin
		if(State == 9) out <= ACC[7:0];
	end
endmodule
