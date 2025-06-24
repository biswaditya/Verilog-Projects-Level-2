`timescale 1ns / 1ps


module Shift_Register_PISO_tb;
reg [3:0] IN;
reg CLK;
reg Load;
wire Serial_OUT;

Shift_Register_PISO uut(IN,CLK,Load,Serial_OUT);

     always #50 CLK = ~CLK;  // Generate clock: 100ns period
     always #76 Load = ~Load; // Generate Load: 152ns period
initial
begin    
CLK = 0; // Initialize signals
Load = 0;


  $display( "IN CLK Load | Serial_OUT " ); 
  $monitor( "%h %b   %b  | %b ",IN,CLK,Load,Serial_OUT); 
   // Apply test cases
        IN = 4'hA; 
  #120  IN = 4'hB; 
  #120  IN = 4'h8; 
  #120  IN = 4'h5; 
  #120  IN = 4'hE; 
  #120   

  $finish;
end

endmodule
