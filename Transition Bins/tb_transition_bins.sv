module tb_transition_bins;
  logic clk;
  bit [4:1] channel;
  
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  covergroup cg(string name) @(posedge clk);
      option.per_instance = 1;   // must be at covergroup level, not coverpoint level
      option.comment = "Covergroup Level Comment";
      option.name = name;           // this sets the instance name in UCDB

    coverpoint channel {
//       option.comment = "Coverpoint Level Comment";  // Only One Comment is allowed per scope level😭
      option.comment = "Bins for Transition";
      
      // SIngle Transition
      bins t_single = (4 => 5);
      
      // Sequence of transitions
      bins t_seq = (4 => 5 => 6);
      
      // Set of Transitions
      // (7 =>11), (7 => 12), (8 =>11), (8 => 12), (9 =>11), (9 => 12), (10 =>11), (10 => 12).
      // As there are multiple transitions are present separate bins are req. for each set.
      bins t_set[] = ([7:9], 10 => 11, 12);
   		
      // Consecutive Repetition of Transitions. bins that covers channel holding value 4 for exactly 3 consecutive clock cycles. 
      bins t_consec = (4[*3]); 	// (4 => 4 => 4)
      bins t_consec_range = (3[*2:4]); 	// either it can be (3 => 3), (3 => 3 => 3), (3 => 3 => 3 => 3)
      
      // Non-Consecutive Repetitions
      bins t_nonconsec = (2[->3]); 		// If your channel goes 2, 7, 2, 9, 2 it covers. here it is Single bin — matches any sequence where 2 appears 3 times non-consecutively (e.g. 2,7,2,9,2)
      
      bins t_others = default sequence;
    }
  endgroup
        
  cg cg_inst1, cg_inst2;
        
  initial begin
    cg_inst1 = new("instance - 1"); // Giving explicit instance name otherwise warining will be thrown
    cg_inst2 = new("instance - 2");
    
    
    // Random Values covers t_single, t_seq, t_set, t_others 
    repeat(200) begin
      @(posedge clk);
      channel = $urandom_range(1, 15);
    end
    
//     Directed (for consecutive and non-consecutive bins)
    @(posedge clk);
    channel = 4;
    @(posedge clk);
    channel = 4;
    @(posedge clk);
    channel = 4;
    
    @(posedge clk);
    channel = 3;
    @(posedge clk);
    channel = 3;
    @(posedge clk);
    channel = 3;
    @(posedge clk);
    channel = 3;
    
    @(posedge clk);
    channel = 2;
    @(posedge clk);
    channel = 5;
    @(posedge clk);
    channel = 2;
    @(posedge clk);
    channel = 8;
    @(posedge clk);
    channel = 2;
    @(posedge clk);
    channel = 9;
    @(posedge clk);
    channel = 2;
    @(posedge clk);
    channel = 11;
    
    // Per-instance: use get_inst_coverage() on the instance
    // Hitcount: must be on the coverpoint (.channel), not the covergroup
    $display("[Instance 1] Coverage = %0.2f%% | HitCount(t_single) = %0d",
      cg_inst1.get_inst_coverage(),
             cg_inst1.channel.get_inst_hitcount("t_single"));

    $display("[Instance 2] Coverage = %0.2f%% | HitCount (t_set[0]) = %0d",
      cg_inst2.get_inst_coverage(),
             cg_inst2.channel.get_inst_hitcount("t_set[0]")); // get_inst_hitcount("bin_name") -> takes bin NAME as string, not an integer index
// e.g. "t_single", "t_seq", "t_consec", "t_nonconsec", "t_set[0]", "t_others" 

    // Type-level: merged across all instances of cg
    $display("[Total / merged] Coverage = %0.4f%%",
      cg::get_coverage());

    // Overall design coverage across ALL covergroups in the testbench
    $display("[Overall design] Coverage = %0.6f%%",
      $get_coverage());

    $finish;
  end
        
endmodule
