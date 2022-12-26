module SR_Latch(Q, Qbar, Sbar, Rbar);
  
  // Port declaration
  output Q, Qbar;
  input Sbar, Rbar;
  
  // Instantiate lower-level modules
  nand n1(Q, Sbar, Qbar);
  nand n2(Qbar, Q, Rbar);
  
endmodule

// Test bench
module Top;
  
  // Declaration of wire, reg and other variables
  wire q, qbar;
  reg set, reset;
  
  // Instantiate lower-level modules
  // Feed inverted set and reset signals to the SR latch
  SR_Latch(q, qbar, ~set, ~reset);
  
  // Behavioral block, initial
  initial
    begin
      $monitor($time "set = %b, reset = %b, Q = %b\n", set, reset, q);
      set = 0; reset = 0;
      #5 reset = 1;
      #5 reset = 0;
      #5 set = 1;
    end
  
endmodule
