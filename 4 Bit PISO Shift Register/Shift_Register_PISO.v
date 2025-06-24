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

// Parallel Input Serial Output Shift Register 
module Shift_Register_PISO(
    input [3:0] IN, // 4 bit Input
    input CLK,
    input Load,  // Load = 0 (HOLD), Load = 1 (New State)
    output Serial_OUT  // Serial Output
    );
    
    wire [3:0]q;
    wire [3:0]t;
    
      // Use of 2x1 MUX is to select Hold(Load =0) or Load New Data(Load = 1)
      Mux2x1 k1(q[3],IN[3],Load,t[3]);
      Mux2x1 k2(q[2],IN[2],Load,t[2]);
      Mux2x1 k3(q[1],IN[1],Load,t[1]);
      Mux2x1 k4(q[0],IN[0],Load,t[0]);
      
      D_filpflop df1(t[3],CLK,q[3]);
      D_filpflop df2(t[2],CLK,q[2]);
      D_filpflop df3(t[1],CLK,q[1]);
      D_filpflop df4(t[0],CLK,q[0]);
      
      assign Serial_OUT = q[0]; // LSB shifted out
    
    
endmodule
