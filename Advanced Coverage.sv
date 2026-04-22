module tb_mem_ctrl;
  bit [3:0] addr;
  bit [1:0] op;
  bit [2:0] size;
    
  covergroup mem_cg;
    option.comment = "Adds a Comment in every covergroup instance";
    option.per_instance = 1;
    
    cp_addr: coverpoint addr {
      option.auto_bin_max = 4;
    }
    
    cp_size: coverpoint size {
      option.at_least = 3; 
      wildcard bins even = {3'b??0}; // 0, 2, 4, 6
      wildcard bins odd  = {3'b??1}; // 1, 3, 5, 7
    }
    
    // Only 2 Valid Bins
    cp_op: coverpoint op {
      bins read = {0};
      bins write = {1};
      ignore_bins burst = {2};
      illegal_bins idle = {3};
    }
    
    // Cross Coverage
    cp_cross: cross cp_op, cp_addr{
      bins write_high = binsof(cp_op.write) && binsof(cp_addr) intersect {[8:15]};
      
      bins read_mid_or_high = binsof(cp_op.read) && (binsof(cp_addr) intersect {[4:7]} || binsof(cp_addr) intersect {[8:15]});

      ignore_bins read_low = binsof(cp_op.read) && binsof(cp_addr) intersect {[0:3]};
      
      illegal_bins write_addr0 = binsof(cp_op.write) && binsof(cp_addr) intersect {0}; // must never happen
    }
    
  endgroup
  
  mem_cg cg_chA, cg_chB;

  initial begin
    cg_chA = new();
    cg_chB = new();

    // Channel A — READ operations, full address range
    repeat(50) begin
      addr = $urandom_range(0, 15);
      op   = 0;                      // READ only
      size = $urandom_range(0, 7);
      #2;
      cg_chA.sample();
    end

    // Channel B — WRITE operations, high address focus
    repeat(50) begin
      addr = $urandom_range(8, 15);  // high addresses
      op   = 1;                      // WRITE only
      size = $urandom_range(0, 7);
      #2;
      cg_chB.sample();
    end

    $display("Channel A = %0.2f%%", cg_chA.get_coverage());
    $display("Channel B = %0.2f%%", cg_chB.get_coverage());
    $display("Total     = %0.2f%%", $get_coverage()); // all instances combined
    $finish;
  end

endmodule
