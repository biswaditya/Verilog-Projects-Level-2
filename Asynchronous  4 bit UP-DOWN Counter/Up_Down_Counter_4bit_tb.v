`timescale 1ns / 1ps

module Up_Down_Counter_4bit_tb;
reg CLK;
reg RESET;
reg UPDN;
wire [3:0] COUNT;

Up_Down_Counter_4bit uut(CLK,RESET,UPDN,COUNT);
    // Clock generation: 10ns period
     always #5 CLK = ~CLK;
     initial
     begin
     CLK=0;
     RESET =1;
     UPDN =1;// Start with UP count
     
     $display("Time CLK RESET UPDN | COUNT");
     $monitor("%0t %b %b %b | %d", $time, CLK, RESET, UPDN, COUNT);
     
     #10;RESET = 0;
     // Let it Count up from 0 to 7
     #70;
     // Now Count DOWN from 8 to 1 then reset it
     UPDN = 0;
     #80;
  
     RESET = 1; 
     #10;
     
                 
      $finish;
     end
endmodule
