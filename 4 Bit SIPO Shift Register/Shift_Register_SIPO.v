`timescale 1ns / 1ps

module DFF(input D,
                  input CLK,
                  output reg Q);
   always@(posedge CLK) 
   begin
        Q <= D;   // non-blocking assignment
   end              
endmodule  

module Mux2to1(
    input i0,i1,s,
    output y
    );
    wire s_not,p,q;
    
    not(s_not,s);
    and(p,s_not,i0);
    and(q,s,i1);
    
    or(y,p,q);
    
endmodule

//Serial In Parallel OUT REGISTER
module Shift_Register_SIPO(
    input Serial_IN,// Serial Input
    input CLK,
    input Load,  // Load = 0 (HOLD), Load = 1 (New State)
    output [3:0] OUT// 4 bit OUTput
    );
    
     wire [3:0]q;
     wire [3:0]t;
     
    
    // Use of 2x1 MUX is to select Hold(Load =0) or Load New Data(Load = 1)
    Mux2to1 k1(q[3],Serial_IN,Load,t[3]);
    Mux2to1 k2(q[2],q[3],Load,t[2]);
    Mux2to1 k3(q[1],q[2],Load,t[1]);
    Mux2to1 k4(q[0],q[1],Load,t[0]);
    
    DFF df1(t[3],CLK,q[3]);
    DFF df2(t[2],CLK,q[2]);
    DFF df3(t[1],CLK,q[1]);
    DFF df4(t[0],CLK,q[0]);
    
    assign OUT = q; 
    
    
endmodule
