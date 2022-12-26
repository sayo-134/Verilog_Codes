module stimulus;

reg clk;
reg reset;  
wire[3:0] q;  

  
//instantiate the design block
ripple_carry_counter r1(q, clk, reset);
  
// control the clk signal that drives the design block. Cylce time = 10 units
initial
  clk = 1'b0
always
  #5 clk = ~clk; // toggle clk every 5 time units

// control the reset signal that drives the design block
// reset signal is asserted from 0 to 20 and from 200 to 220
  
initial
begin
  reset = 1'b1;
  #15 reset = 1'b0;
  #180 reset = 1'b1;
  #10 reset = 1'b0;
  #20 $finish; // terminate the stimulation
end

// Monitor the outputs
initial
  $monitor($time, "output q = %d", q);
  
endmodule
