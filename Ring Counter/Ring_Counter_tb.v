`timescale 1ns / 1ps
module Ring_Counter_tb;
    reg CLK;
    reg OverRide_IN;
    wire [3:0] Q;

    Ring_Counter uut(.CLK(CLK), .OverRide_IN(OverRide_IN), .Q(Q));

    always #5 CLK = ~CLK;
    initial
    begin
        CLK =0;
        OverRide_IN = 0; // Load initial state
        #10;
        OverRide_IN = 1; // Start rotating
        #100;
        $finish;
     end
endmodule

