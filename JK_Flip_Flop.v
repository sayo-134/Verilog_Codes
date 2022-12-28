module JK_FF(q, qbar, j, k, clock, clear);
  
  input j, k, clock, clear;
  output q, qbar;
  
  wire a, b, y, ybar, cbar, c, d;
  
  assign cbar = ~clock;
  
  assign a = ~(j & qbar & clock & clear),
  b = ~(k & clock & q),
  y = ~(a & ybar),
  ybar = ~(b & y & clear),
  c = ~(y & cbar),
  d = ~(ybar & cbar);
  
  assign q = ~(c & qbar),
  qbar = ~(d & clear & q);
  
endmodule

module synchronous_counter_JK (q, clk, reset);
  
  input clk, reset;
  output [3:0] q;
  
  wire q2, q3;
  
  JK_FF jkff0(q[0], ~q[0], 1, 1, clock, reset);
  JK_FF jkff1(q[1], ~q[1], q[0], q[0], clock, reset);
  assign q2 = q[0] & q[1];
  JK_FF jkff2(q[2], ~q[2], q2, q2, clock, reset);
  assign q3 = q[0] & q[1] & q[2];
  JK_FF jkff3(q[3], ~q[3], q3, q3, clock, reset);
  
endmodule

module stimulus;
  
  // declare variables for stimulating input
  reg CLOCK, CLEAR;
  // output must be a wire
  wire [3:0] Q;
  
  initial
    $monitor($time "Count Q = %b Clear = %b", Q[3:0], CLEAR);
  
  // Instantiate the design block counter
  counter c1(Q, CLOCK, CLEAR);
  
  // Stimulate the Clear signal
  initial
    begin
      CLEAR = 1'b1;
      #34 CLEAR = 1'b0;
      #200 CLEAR = 1'b1;
      #50 CLEAR = 1'b0;
    end
  
  // set up the clock to toggle every 10 time units, i.e. its clock period is 20 time units
  initial
    begin
      CLOCK = 1'b0;
      forever #10 CLOCK = ~CLOCK;
    end
  
  // finish the simulation at time 400
  initial
    begin
      #400 finish
    end
  
endmodule

