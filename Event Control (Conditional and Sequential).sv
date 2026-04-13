module tb_shift;
  logic clk = 0, en, din;
  logic [2:0] sr = 3'b0;          // sr[0]=stage1, sr[1]=stage2, sr[2]=stage3
  int match_count = 0;
  
  always #5 clk = ~clk;
  
  always @(posedge clk iff en) begin
    sr[0] <= din;
    sr[1] <= sr[0];
    sr[2] <= sr[1];
  end
  
  sequence three_ones;
    @(posedge clk) sr[0] ##0 sr[1] == 1 ##0 sr[2];
  endsequence
  always @(three_ones) begin
    match_count++;
    $display("Pattern 111 detected at %0t ns | sr=%b", $time, sr);
  end
  
  initial begin
    @(negedge clk); en=1; din=1;   // cycle 1: din=1 enters sr[0]
    @(negedge clk);        din=1;  // cycle 2: moves to sr[1]
    @(negedge clk);        din=1;  // cycle 3: moves to sr[2] → MATCH
    @(negedge clk);

    din=0;
    @(negedge clk); en=0;          // en goes low — clock ignored
    @(negedge clk); en=0;
    @(negedge clk); en=1; din = 1;          // re-enable
    @(negedge clk); din = 1;

    #20 $finish;
  end
  
  final begin
    $display("--- Final Report ---");
    $display("Pattern matched %0d times", match_count);
    $display("Simulation ended at %0t ns", $time);
  end
endmodule
