`timescale 1ns / 1ps

module D_FF_Johnsons_COUNTER (input D,
                  input CLK,
                  input CLR,// Sets Q=0
                  output reg Q);
   always@(negedge CLK) 
   begin if (CLR) Q <= 1'b0;
         else Q <= D;  
   end              
endmodule 

//4 bit Johnsons_COUNTER
// In Normal Counter >> no of Unique states = 2^n (n = no. of bits) like for 4 bits from 0000 to 1111 
// In Johnsons_COUNTER >>   no of Unique states = 2n (n = no. of bits) like for 4 bits 0000,1000,1100,1110,1111,0111,0011,0001
module Johnsons_COUNTER(
    input CLK,
    input CLR,
    output [3:0] Q
    );
    wire [3:0]Din;
    
    assign Din[0]=~Q[3];
    assign Din[1]=Q[0];
    assign Din[2]=Q[1];
    assign Din[3]=Q[2]; 
    
    D_FF_Johnsons_COUNTER d0(Din[0],CLK,CLR,Q[0]);
    D_FF_Johnsons_COUNTER d1(Din[1],CLK,CLR,Q[1]);
    D_FF_Johnsons_COUNTER d2(Din[2],CLK,CLR,Q[2]);
    D_FF_Johnsons_COUNTER d3(Din[3],CLK,CLR,Q[3]);
    
endmodule
