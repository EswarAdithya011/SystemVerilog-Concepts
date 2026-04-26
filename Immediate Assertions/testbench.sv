module fsm;
  typedef enum {IDLE, REQ} state_t;
  state_t state;
  
  bit clk, req1, req2;
  logic [3:0] data_a, data_b;
  
  event data_ok;
  int   error_count = 0;
  
  function automatic logic check_data(logic [3:0] a, b);
    return (a && b);
  endfunction
  
  test t1(.clk(clk), .req1(req1), .req2(req2), .data_a(data_a), .data_b(data_b));
  
  // Task 2.1
  always @(posedge clk) begin
    case (state)
      IDLE: state <= (req1 || req2) ? REQ : state;
      REQ:  state <= (!req1 && !req2) ? IDLE : state;
      default: state <= IDLE;
    endcase
    
    assert ((state == REQ) -> (req1 || req2))
      $info("Correct State");
    else 
      $error("Incorrect State");
  end
  
  // Task 2.2
  initial begin
    assert(req2)
    else
      $info("req2 is low at 0ns");
  end
  
  initial begin
    assert(req1 && req2)
    else
      $warning("req1 & req2 both low at 0ns");
  end
  
  initial begin
    #6;
    assert(!clk)
    else
      $error("clk is not low at 6ns");
  end
  
  initial begin
    #60;
    assert(req1 && !req2)
    else $fatal(1, "Terminated: req1 not high or req2 not low at 60ns");
  end
  
  // Task 2.3
  always @(posedge clk) begin
    assert (check_data(data_a, data_b))
      -> data_ok;
    else
      error_count++;
  end
  
  always @(data_ok) begin
    $display("Event Received at: %0tns", $time);
  end
  
  initial begin
    @(data_ok);
    $display("Total assertion failures: %0d", error_count);
  end
  
endmodule


program test(
  output logic clk,
  output logic req1, req2,
  output logic [3:0] data_a, data_b
);
  
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  initial begin
    {req2, req1} = 0;
    #12 {req2, req1} = 2'b11;
    #11 {req2, req1} = 2'b00;
    #5  {req2, req1} = 2'b00;
  end
  
  initial begin
    data_a = 4'h0; data_b = 4'h0;
    @(posedge clk);
    
    data_a = 4'h0; data_b = 4'hA;
    @(posedge clk);
    
    data_a = 4'h5; data_b = 4'h0;
    @(posedge clk);
    
    data_a = 4'h3; data_b = 4'h7;
    @(posedge clk);
    
    $display("Total assertion failures: %0d", $root.fsm.error_count);
    #10 $finish;
  end
  
endprogram

// module tb_grant;
//   logic req, gnt, clk;
//   logic rst;
//   // Clock
//   initial clk = 0;
//   always #5 clk = ~clk;
//   // DUT
//   grant dut (
//     .clk(clk),
//     .rst(rst),
//     .req(req),
//     .gnt(gnt)
//   );
// endmodule
// program test (
//   output logic req,
//   input  logic gnt,
//   input  logic clk,
//   output logic rst
// );
//   initial begin
//     rst = 1;
//     req = 0;
//     #22 rst = 0;
//     #4  req = 1;
//     #10 req = 0;
//     #100 $finish;
//   end

//   initial begin
//     $dumpfile("req_grant.vcd");
//     $dumpvars(0, tb_grant);
//   end
// endprogram
