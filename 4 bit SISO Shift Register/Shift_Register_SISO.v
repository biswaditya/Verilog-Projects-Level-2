`timescale 1ns / 1ps

module DataFF(input D,
                  input CLK,
                  output reg Q);
   always@(posedge CLK) 
   begin
        Q <= D;   // non-blocking assignment
   end              
endmodule  

module Mux_2to1(
    input i0,i1,s,
    output y
    );
    wire s_not,p,q;
    
    not(s_not,s);
    and(p,s_not,i0);
    and(q,s,i1);
    
    or(y,p,q);
    
endmodule

// Serial IN Serial OUT Shift Register
module Shift_Register_SISO(
    input Serial_IN,//serial IN
    input CLK, 
    input Load,// Load = 0 (HOLD), Load = 1 (New State)
    output Serial_OUT,//serial OUT
    output wire [3:0]q// Parallel OUT's
    );
  
    wire [3:0]t;
    
   
   // Use of 2x1 MUX is to select Hold(Load =0) or Load New Data(Load = 1)
   Mux_2to1 k1(q[3],Serial_IN,Load,t[3]);
   Mux_2to1 k2(q[2],q[3],Load,t[2]);
   Mux_2to1 k3(q[1],q[2],Load,t[1]);
   Mux_2to1 k4(q[0],q[1],Load,t[0]);
   
   DataFF df1(t[3],CLK,q[3]);
   DataFF df2(t[2],CLK,q[2]);
   DataFF df3(t[1],CLK,q[1]);
   DataFF df4(t[0],CLK,q[0]);
   
   assign Serial_OUT = q[0];
    
endmodule
