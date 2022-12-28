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
