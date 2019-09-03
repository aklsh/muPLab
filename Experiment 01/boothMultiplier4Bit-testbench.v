`timescale 1ns/1ps

module testbench;
    //variables
    reg clk, start;
    reg [3:0] a, b;
    wire [7:0] ab;
    wire busy;
    integer i, j;
    //module instantiation
    multiplier uut(ab, busy, a, b, clk, start);
    //dump file generation - for non-ISE compilers
    initial begin
        $dumpfile("boothMultiplier.vcd");
        $dumpvars(0, testbench);
    end
    //stimulus
    initial begin
        clk = 0; start = 0;
        #5;
        for(i = -7; i < 8; i = i+1) begin
            for(j = -8; j < 8; j = j+1) begin
                #79 start = 1; #1 a = i; b = j; #10 start = 0;
            end
        end
        #100 $finish;
    end
    //clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
endmodule
