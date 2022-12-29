`define TRUE 1'b1
`define FALSE 1'b0

// Delays
`define Y2RDELAY 3 // Yellow to Red Delay
`define R2GDELAY 2 // Red to Green Delay

module sig_control (hwy, cntry, X, clock, clear);
  
  // I/O Ports
  output [1:0] hwy, cntry; // 2-bit output for 3 states of signal - GREEN, YELLOW, RED
  reg [1:0] hwy, cntry; // declared output signals are registers
  
  input X; // if TRUE, indicates that there is car on the country, otherwise FALSE
  input clcok, clear;
  
  parameter RED = 2'd0,
            YELLOW = 2'd1,
            GREEN = 2'd2;
  
  // State-declaration      HWY       CNTRY
  parameter S0 = 3'd0, //  GREEN       RED
            S1 = 3'd1, //  YELLOW      RED
            S2 = 3'd2, //    RED       RED
            S3 = 3'd3, //    RED      GREEN
            S4 = 3'd4; //    RED      YELLOW
  
  // internal state variables
  reg [2:0] state;
  reg [2:0] next_state;
  
  // state changes only at the positive edge of the clock
  always @(posedge clock)
    if(clear)
      state <= S0; // controller starts in S0 state
    else
      state <= next_state; // state change
  
  // compute values of main signal and country signal
  always @(state)
    begin
      hwy = GREEN; // default light assignment for highway light
      cntry = RED; // default light assignment for country light
      case(state)
        S0: ; // no change, use default
        S1: hwy = YELLOW;
        S2: hwy = RED;
        S3: begin
              hwy = RED;
              cntry = GREEN;
            end
        S4: begin
              hwy = RED;
              cntry = `YELLOW;
            end
      endcase
    end
  
  // state machine using case statement
  always @(state or X)
    begin
      case(state)
        S0: if(X)
              next_state = S1;
            else
              nex_state = S0;
        S1: begin // delay some positive edges of clock
              repeat(`Y2RDELAY) @(posedge clock);
              next_state = S2;
            end
        S2: begin // delay some positive edges of clock
              repeat(`R2GDELAY) @(posedge clock);
              next_state = S3;
            end
        S3: if(X)
              next_state = S4;
            else
              next_state = S3;
        S4: begin // delay some posititve edges of clock
              repeat(`Y2RDELAY) @(posedge clock)
              next_state = S0;
            end
        default: next_state = S0;
      endcase
    end
endmodule

// Stimulus module
module stimulus;
  
  wire [1:0] MAIN_SIG, CNTRY_SIG;
  reg CAR_ON_CNTRY_RD; // if TRUE, indicated that there is car on the country road
  reg CLOCK, CLEAR;
  
  // instantiate signal controller
  sig_control SC(MAIN_SIG, CNTRY_SIG, CAR_ON_CNTRY_RD, CLOCK, CLEAR);
  
  // set up monitor
  initial
    $monitor($time, " Main Sig = %b Country_Sig = %b Car_on_cntry = %b", MAIN_SIG, CNTRY_SIG, CAR_ON_CNTRY_RD);
  
  // set up clock
  initial
    begin
      CLOCK = `FALSE;
      forever #5 CLOCK = ~CLOCK; 
    end
  
  // control signal
  initial
    begin
      CLEAR = `TRUE;
      repeat(5) @(negedge CLOCK);
      CLEAR = `FALSE;
    end
  
  // apply stimulus
  initial
    begin
      CAR_ON_CNTRY_RD = `FALSE;
      
      repeat(20) @(negedge CLOCK); CAR_ON_CNTRY_RD = `TRUE;
      repeat(10) @(negedge CLOCK); CAR_ON_CNTRY_RD = `FALSE;
      
      repeat(20) @(negedge CLOCK); CAR_ON_CNTRY_RD = `TRUE;
      repeat(10) @(negedge CLOCK); CAR_ON_CNTRY_RD = `FALSE;
      
      repeat(20) @(negedge CLOCK); CAR_ON_CNTRY_RD = `TRUE;
      repeat(10) @(negedge CLOCK); CAR_ON_CNTRY_RD = `FALSE;
      
      repeat(10) @(negedge CLOCK); $stop;
    end
endmodule
      
            
