module ripple_carry_counter(q, clk, reset);

output [3:0] q;
input clk, reset;

// 4 instances of the module T_Ff are created
T_FF tff0(q[0], clk, reset);
T_FF tff1(q[1], q[0], reset);
T_FF tff1(q[2], q[1], reset);
T_FF tff1(q[3], q[2], reset);

endmodule

module T_FF(q, clk, reset);

output q;
input clk, reset;
wire d;

// creating T_FF using D_FF
D_FF dff0(q, d, clk, reset);
not(d,q); // not is a Verilog-provided primitive, case sensitive

endmodule

module D_FF(q, d, clk, reset);

output q;
input d, clk, reset;
reg q;

always @(posedge reset or negedge clk)
if (reset)
  q <= 1'b0;
else
  q <= d;

endmodule
