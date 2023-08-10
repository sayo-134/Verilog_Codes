module full_adder(sum, c_out, a, b, c_in);
  
  input a,b,c_in;
  output sum, c_out;
  wire s1, c2, c1;
  
  xor x1(s1, a, b);
  and a1(c1, a, b);
  xor x2(sum, s1, c_in);
  and a2(c2, s1, c_in);
  xor x3(c_out, c1, c2);
  
  /*
  assign {c_out, sum} = a + b + c_in;
  */
  
endmodule

module ripple_carry_adder(sum, c_out, a, b, c_in);
  
  input [3:0] a,b;
  input c_in;
  output[3:0] sum;
  output c_out;
  wire c1, c2, c3;
  
  full_adder fa0(sum[0], c1, a[0], b[0], c_in);
  full_adder fa1(sum[1], c2, a[1], b[1], c1);
  full_adder fa2(sum[2], c3, a[2], b[2], c2);
  full_adder fa3(sum[3], c_out, a[3], b[3], c3);
  
endmodule

module stimulus;
  
  reg [3:0] A, B;
  reg C_IN;
  wire [3:0] SUM;
  wire C_OUT;
  
  ripple_carry_adder(SUM, C_OUT, A, B, C_IN);
  
  initial
    begin
      $monitor($time, "A = %b, B = %b, C_IN = %b, --- C_OUT = %b, SUM = %b\n", A, B, C_IN, C_OUT, SUM);
    end
  
  initial
    begin
      A = 4'd0; B = 4'd0; C_IN = 1'b0;
      #5 A = 4'd3; B = 4'd4;
      
      #5 A = 4'd2; B = 4'd5;
      
      #5 A = 4'd9; B = 4'd9;
      
      #5 A = 4'd10; B = 4'd15;
      
      #5 A = 4'd10; B = 4'd5; C_IN = 1'b1;
    end
endmodule


module ripple_adder(sum, co, a0, a1, ci);
  
  // parameter declaration. This can be redefined.
  parameter N = 4;
  
  // Port declaration
  output [N-1:0] sum;
  output co;
  input [N-1:0] a0, a1;
  input ci;
  
  // Local wire declaration
  wire [N-1:0] carry;
  
  // assign 0th bit of carry equal to carry input
  assign carry[0] = ci;
  
  /* 
  declare a temporary loop variable. This variable is used only in the evaluation of generate blocks. This variable does not exist during the simulation of a 
  Verilog design because the generate loops are unrolled before simulation
  */
  genvar i;
  
  // generate the bit-wise xor with a single loop
  generate for(i=0; i<N; i= i+1) begin: r_loop
    wire t1, t2, t3;
    xor g1(t1, a0[i], a1[i]);
    xor g2(sum[i], t1, carry[i]);
    and g3(t2, a0[i], a1[i]);
    and g4(t3, t1, carry[i]);
    or  g5(carry[i+1], t2, t3);
  end
  endgenerate
  
  assign co = carry[N];
endmodule
