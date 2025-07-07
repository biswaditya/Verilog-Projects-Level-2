`timescale 1ns / 1ps

module Johnsons_COUNTER_tb;
    reg CLK = 0;
    reg CLR = 1;  // Start with reset
    wire [3:0] Q;

    // Instantiate the design under test
    Johnsons_COUNTER uut (
        .CLK(CLK),
        .CLR(CLR),
        .Q(Q)
    );

    // Clock generation
    always #5 CLK = ~CLK;

    initial begin
        $display("Time\t CLK CLR Q");
        $monitor("%g\t %b   %b   %b", $time, CLK, CLR, Q);

        // Apply reset
        #2 CLR = 1;
        #8 CLR = 0; // Release reset

        // Let it run for 16 cycles to show repeating pattern
        #100;
        $finish;
    end
endmodule
