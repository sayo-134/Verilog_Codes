module 4_to_1_mux(out, i0, i1, i2, i3, s1, s0);
  input i0, i1, i2, i3;
  input s1, s0;
  output out;
  
  //using logical equation
  assign out = (~s1 & ~s0 & i0) | ( ~s1 & s0 & i1) | (s1 & ~s0 & i2) | (s1 & s0 & i3);
  
  /*
  using conditional operator
  assign out = s1 ? (s0 ? i3 : i2) : (s0 ? s1 : s0);
  */
endmodule

module 4to1_mux(out, i0, i1, i2, i3, s1, s0);
  inout i0, i1, i2, i3;
  input s1, s0;
  output out;
  always @(*)
    case ({s1, s0}) // Switch based on concatenation of control signal
      2'd0 : out = i0;
      2'd1 : out = i1;
      2'd2 : out = i2;
      2'd3 : out = i3;
      default: $display("Invalid control signal");
    endcase
endmodule
