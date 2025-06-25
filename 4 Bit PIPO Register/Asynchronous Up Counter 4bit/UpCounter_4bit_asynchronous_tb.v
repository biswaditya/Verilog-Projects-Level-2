`timescale 1ns / 1ps


module UpCounter_4bit_asynchronous_tb;
reg CLK;
reg RESET;
wire [3:0] COUNT;

UpCounter_4bit_asynchronous uut(CLK,RESET,COUNT);

always # 5 CLK = ~CLK; // Generate clock: 10ns period (100 MHz)
initial
begin
CLK = 0;
RESET = 1;
#5; RESET = 0;
#165;
$finish;
end
endmodule
