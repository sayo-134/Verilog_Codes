module edge_dff(q, qbar, d, clk, clear);
  
  // inputs and outputs
  output q, qbar;
  input d, clk, clear;
  // wire
  wire s, sbar, r, rbar, cbar;
  
  // dataflow statements
  // create a complement of signal clear
  assign cbar = ~clear;
  
  // Input latches; A latch is level sensitive. An edge-sensitive flip-flop is implemented by using 3 SR latches.
  assign sbar = ~(rbar & s),
  s = ~(sbar & cbar & ~clk),
  r = ~(rbar & ~clk & s),
  rbar = ~(r & cbar &d);
  
  // Output latch
  assign q = ~(s & qbar),
  qbar = ~(r & q & cbar); 
endmodule
