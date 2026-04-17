module tb_alu_coverage;
  logic [2:0] opcode;
  logic [1:0] mode;
  logic reset;
  
  covergroup cg;
    option.comment = "ALU Coverage";
    cp_op_auto: coverpoint opcode;
    
    cp_op_manual: coverpoint opcode {
      bins arith_ops = {[0:2]};
      bins logic_ops = {3, 4, 5};
      bins special_ops = {[6:7]};
    }
    
     cp_mode: coverpoint mode {
      bins m[] = {[0:3]};
    }
    
    cp_op_no_rst: coverpoint opcode iff (!reset) {
      bins each_ops[] = {[0:$]};
    }
  endgroup
  
  cg cg_inst;
  
  initial begin
    cg_inst = new();
//     cg_inst.sample();
    
    reset = 1;
    {opcode, mode} = 5'b0;
    cg_inst.sample();

    #5 reset = 0; // deassert reset so cp_op_no_rst starts sampling
    cg_inst.sample();
    
    for(int i = 0; i < 100; i++) begin
      {opcode, mode} = $urandom % 32;
      #2;
      cg_inst.sample();
    end
    
    $display("Coverage = %0.2f%%", cg::get_coverage());
    $finish;
  end
    
endmodule
