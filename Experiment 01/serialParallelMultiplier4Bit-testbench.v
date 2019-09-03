`timescale 1ns / 1ps

module testbench;
    // Inputs
    reg reset;
    reg clk;
    reg [3:0] A;
    reg [3:0] B;

    // Outputs
    wire [7:0] out;
    wire finish;

    // Integers
    integer i, j;

    // Instantiate the Unit Under Test (UUT)
    multiplier uut(out, finish, reset, clk, A, B);
    always #5 clk = ~clk;

    initial begin
    	clk = 0;
    	// Initialize Inputs
    	reset = 1;
		#5;
        for(i = 0; i < 16;i = i+1) begin
            for(j = 0; j < 16;j = j+1) begin
    	       #9 reset = 0; #1 A = i; B = j; #100 reset = 1;
            end
        end
    	#100 $finish;
    end

    //Dump File
    initial begin
        $dumpfile("serialParallelMultiplier.vcd");
        $dumpvars(0, testbench);
    end
endmodule
