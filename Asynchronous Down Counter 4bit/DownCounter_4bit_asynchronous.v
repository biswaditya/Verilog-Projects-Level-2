`timescale 1ns / 1ps

module jk_flipflop (
    input j, k, clk, reset,
    output reg q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 0;
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

//4 Bit asynchronous DOWN COUNTER
module DownCounter_4bit_asynchronous(
    input CLK,
    input RESET,
    output [3:0] COUNT
    );
        wire [3:0] q;
      // All JK FFs are in toggle mode (J=K=1)
    jk_flipflop w1(1'b1,1'b1,CLK,RESET,q[0]);
     // Each subsequent JK FF uses previous JK FF O/P as CLK
    jk_flipflop w2(1'b1,1'b1,q[0],RESET,q[1]);
    jk_flipflop w3(1'b1,1'b1,q[1],RESET,q[2]);
    jk_flipflop w4(1'b1,1'b1,q[2],RESET,q[3]);
    
    assign COUNT = {q[3],q[2],q[1],q[0]};
endmodule
