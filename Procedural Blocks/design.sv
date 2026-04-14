module traffic_light (
    input  logic clk,
    input  logic rst,
   	input  logic en,
    output logic green,
    output logic yellow,
    output logic red
);
  
  typedef enum logic [1:0] {
    GREEN = 2'b00, YELLOW, RED
  } state_t;
  
  state_t ps, ns;
  
    // State Register
  always_ff @(posedge clk) begin
    if (rst) 
      ps <= GREEN;
    else
      ps <= ns;
  end
  
  // Next State Combinational Logic
  always_comb begin
    case(ps) 
      GREEN:   ns = YELLOW;
      YELLOW:  ns = RED;
      RED:	   ns = GREEN;
      default: ns = GREEN;
    endcase
  end
      
  // State registering Logic
      always_latch if (en) begin
      green  = (ps == GREEN);
      yellow = (ps == YELLOW);
      red    = (ps == RED);
    end
  
      
endmodule
