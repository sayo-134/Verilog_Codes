module multiplier(product, a0, a1);
  // parameter declaration
  parameter a0_width =8;
  parameter a1_width = 8;
  // local parameter declaration
  localaparam product_width = a0_width + a1_width;
  
  // port declaration
  output [product_width-1:0] product;
  input [a0_width-1:0] a0;
  input [a1_width-1:0] a1;
  
  /* Instantiate the type of multiplier conditionally. According tho the value of a0_width and a1_width parameters at the time of instantiation, the appropriate 
  multiplier will be instantiated */
  generate
    if (a0_width < 8) || (a1_width < 8)
      cla_multiplier #(a0_width, a1_width) m0 (product, a0, a1);
    else
      tree_multiplier #(a0_width, a1_width) m0 (product, a0, a1);
  endgenerate
endmodule
