`timescale 1ns / 1ps

module Register_PIPO_tb;
 reg [3:0] IN;
 reg CLK;
 reg Load;
 wire[3:0] OUT;
 
 Register_PIPO uut(IN,CLK,Load,OUT);
     always #50 CLK = ~CLK;  // Generate clock: 100ns period
  always #80 Load = ~Load; // Generate Load: 160ns period
 initial
begin    
CLK = 0; // Initialize signals
Load = 0;


  $display( "IN CLK Load | OUT " ); 
  $monitor( "%h %b   %b  | %h ",IN,CLK,Load,OUT); 
   // Apply test cases
        IN = 4'hA; 
  #120  IN = 4'h8; 
  #120  IN = 4'hB; 
  #120  IN = 4'h5; 
  #120  IN = 4'hE; 
  #120  IN = 4'h4; 

  $finish;
end


endmodule
