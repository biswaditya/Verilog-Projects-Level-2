`timescale 1ns / 1ps

// JK Flip-Flop with asynchronous reset
module JKff (
    input j, k, clk, reset,
    output reg q
);
    always @(negedge clk or posedge reset) begin
        if (reset)
            q <= 0; // Asynchronous reset to 0
        else begin
            case ({j, k})
                2'b00: q <= q;       // No change
                2'b01: q <= 0;       // Reset
                2'b10: q <= 1;       // Set
                2'b11: q <= ~q;      // Toggle
            endcase
        end
    end
endmodule


 //4-bit Asynchronous Up/Down Counter using JK Flip-Flops
module Up_Down_Counter_4bit(
    input CLK, // master clock
    input RESET, // Asynchronous reset
    input UPDN, // UP/DOWN control: 1 for UP, 0 for DOWN
    output [3:0] COUNT  // 4-bit counter output
    );
    wire [3:0] q ;
    wire clk1,clk2,clk3 ;
    // For down COUNT CLK = ~Q ,For UP COUNT CLK = Q 
    assign clk1= (UPDN==1)? q[0]:~q[0];
    assign clk2= (UPDN==1)? q[1]:~q[1];
    assign clk3= (UPDN==1)? q[2]:~q[2];
    
    JKff j1(1'b1,1'b1,CLK,RESET,q[0]);
    JKff j2(1'b1,1'b1,clk1,RESET,q[1]);
    JKff j3(1'b1,1'b1,clk2,RESET,q[2]);
    JKff j4(1'b1,1'b1,clk3,RESET,q[3]);
    
    assign COUNT = {q[3],q[2],q[1],q[0]};
endmodule
