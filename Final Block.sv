module tb;
  logic clk = 0;
  int   clk_count = 0;      // counts every posedge
  int   count     = 0;      // increments every 2 posedges

  always #5 clk = ~clk;
  
  always @(posedge clk) begin
    clk_count++;
    
    if(clk_count %2 == 0)
      count++;
  end
  
  initial begin
    #100 $finish;
  end
  
  final begin
  $display("=== Report ===");
    $display("Count     : %0d", count);
    $display("Clk edges : %0d", clk_count);
    $display("Time      : %0t ns", $time);
  end

endmodule
