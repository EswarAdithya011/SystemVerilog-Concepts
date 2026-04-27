module task2;
  logic clk = 0, data;
  
  always #5 clk = ~clk;
  
  always @(posedge clk)
    data <= 1;
  
  // Concurrent assertions sample signals in the Preponed region which occurs
  // at the very start of the timestep before Active and NBA regions execute.
  // The non-blocking assignment data <= 1 writes its result in the NBA region.
  // So when the assertion samples data at posedge clk, it sees the value data
  // held at the end of the previous timestep, not the value being written now.
  // This is why concurrent assertions are race-free with the DUT — they never
  // sample in the same region where the design is writing.
  assert property (@(posedge clk)	 data)
    else
      $error("Data is not high");
   
   initial begin
     repeat(7)
       @(posedge clk);
     
     $finish;
   end
    
endmodule

// module task1;
//   logic clk = 0, req, gnt;
  
//   always #5 clk = ~clk;
  
//   property req_to_gnt;
//     @(posedge clk) req |-> ##2 gnt;
//   endproperty
  
//   assert property (req_to_gnt)
//     else
//       $error("req_gnt violated");
  
//   initial begin
//     req = 0; gnt = 0;
    
//     @(posedge clk); #1; req = 1;
//     @(posedge clk); #1; req = 0;
//     @(posedge clk); #1; gnt = 1;
//     @(posedge clk); #1; gnt = 0;
//     @(posedge clk); #1;
    
//     @(posedge clk); #1; req = 1;
//     @(posedge clk); #1; req = 0;
//     @(posedge clk); #1;
//     @(posedge clk); #1; gnt = 1;
//     @(posedge clk); #1; gnt = 0;
    
//     #50 $finish;
//   end
  
// endmodule
