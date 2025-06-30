`timescale 1ns / 1ps
module Shift_Register_SIPO_tb;
    reg Serial_IN, CLK, Load;
    wire [3:0] OUT;

    Shift_Register_SIPO uut(Serial_IN, CLK, Load, OUT);

    
       
    always #5 CLK = ~CLK; // 10ns clock period
    

    initial begin
         CLK = 0;
        Load = 0; 
        Serial_IN = 0;
        #10 Load = 1; Serial_IN = 1; // Shift 1
        #10 Serial_IN = 0;          // Shift 0
        #10 Serial_IN = 1;          // Shift 1
        #10 Serial_IN = 1;          // Shift 1
        #10 Serial_IN = 0;          // Shift 0
        #10 Serial_IN = 0;          // Shift 0
        #10 Serial_IN = 1;          // Shift 1
        #10 Serial_IN = 1;          // Shift 1
        #10 Load = 0;               // Hold
        #30 $finish;
    end
endmodule
