module tb;
  // IMPORT: "Hey C, I'm going to call your alu_model function."
  // CONTEXT: "Since you might call me back, I'm giving you a 'GPS map' of my module."
  import "DPI-C" context function int alu_model(int a, int b, int opcode);
  
  // EXPORT: "I am making this function public so C can see it."
  export "DPI-C" function sv_log_call;

  function void sv_log_call(int a, int b, int op);
    $display("[SV Export] C model is now processing: a=%0d, b=%0d, op=%0d", a, b, op);
  endfunction
  
  int a, b, opcode;
  int dut_result, c_result;
  
  alu_design dut (.result(dut_result), .a(a), .b(b), .opcode(opcode));
  
  initial begin
     $display("---- DPI ALU Verification ----");
    repeat(20) begin
      a = $urandom_range(0, 100);
      b = $urandom_range(1, 100);
      opcode = $urandom_range(0, 4);
      
      #1;
      // C Function calling
      c_result = alu_model(a, b, opcode);
      
      if (dut_result == c_result)
        $info("[PASS] a = %0d, b = %0d, opcode = %0d, dut_result = %0d, c_result = %0d", a, b, opcode, dut_result, c_result);
      else
        $error("[FAIL] a = %0d, b = %0d, opcode = %0d, dut_result = %0d, c_result = %0d", a, b, opcode, dut_result, c_result);
      
    end
  end
endmodule
