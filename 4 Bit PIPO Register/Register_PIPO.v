`timescale 1ns / 1ps

module D_filpflop(input D,
                  input CLK,
                  output reg Q);
   always@(posedge CLK) 
   begin
        Q <= D;   // non-blocking assignment
   end              
endmodule  

module Mux2x1(
    input i0,i1,s,
    output y
    );
    wire s_not,p,q;
    
    not(s_not,s);
    and(p,s_not,i0);
    and(q,s,i1);
    
    or(y,p,q);
    
endmodule

// Parallel Input Parallel Output Register                
module Register_PIPO(
    input [3:0] IN, // 4 bit Input
    input CLK,
    input Load, // // Load = 0 (HOLD), Load = 1 (New State) (shifting)
    output [3:0] OUT // 4 bit Output
    );
    wire [3:0]t;
    
    // Use of 2x1 MUX is to select Hold(Load =0) or Load New Data(Load = 1)
      Mux2x1 m1(OUT[0],IN[0],Load,t[0]);
      Mux2x1 m2(OUT[1],IN[1],Load,t[1]);
      Mux2x1 m3(OUT[2],IN[2],Load,t[2]);
      Mux2x1 m4(OUT[3],IN[3],Load,t[3]);
      
      D_filpflop d1(t[0],CLK,OUT[0]);
      D_filpflop d2(t[1],CLK,OUT[1]);
      D_filpflop d3(t[2],CLK,OUT[2]);
      D_filpflop d4(t[3],CLK,OUT[3]);
    
endmodule
