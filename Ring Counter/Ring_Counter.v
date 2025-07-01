`timescale 1ns / 1ps

module D_FF_RingCounter_Block0(input D,
                  input CLK,
                  input OverRide_IN,// Sets Q[0]=1
                  output reg Q);
   always@(negedge CLK) 
   begin if (OverRide_IN==0) Q <= 1'b1;
         else Q <= D;   // non-blocking assignment
   end              
endmodule 

module D_FF_RingCounter_Block123(input D,
                  input CLK,
                  input OverRide_IN,// Sets Q[1]=0,Q[2]=0,Q[3]=0
                  output reg Q);
   always@(negedge CLK) 
   begin if (OverRide_IN==0) Q <= 1'b0;
            else Q <= D;   // non-blocking assignment
      end              
endmodule 

//4 bit Ring Counter
// In Normal Counter >> no of Unique states = 2^n (n = no. of bits) like for 4 bits from 0000 to 1111 
// In Ring Counter >>   no of Unique states = n (n = no. of bits) like for 4 bits 0001,0010,0100 and 1000
module Ring_Counter(
    input CLK,
    input OverRide_IN,// It Sets Q
    output  [3:0] Q
    );
    wire [3:0]Din;
    
    assign Din[0]=Q[3];
    assign Din[1]=Q[0];
    assign Din[2]=Q[1];
    assign Din[3]=Q[2];
    
    
 
     D_FF_RingCounter_Block0   d0(Din[0],CLK,OverRide_IN,Q[0]);
     D_FF_RingCounter_Block123 d1(Din[1],CLK,OverRide_IN,Q[1]);
     D_FF_RingCounter_Block123 d2(Din[2],CLK,OverRide_IN,Q[2]);
     D_FF_RingCounter_Block123 d3(Din[3],CLK,OverRide_IN,Q[3]);
                       
 
endmodule
