module tb;

  typedef union packed {
    bit [15:0] raw;
	
    // COnsidered as a single data type
    struct packed {
      bit [3:0] opcode;
      bit [3:0] id;
      bit [7:0] data;
    } fields;

  } instr_t;

  instr_t instr;

  initial begin
    instr.raw = 16'hA5F3;

    $display("opcode = %h", instr.fields.opcode);
    $display("id     = %h", instr.fields.id);
    $display("data   = %h", instr.fields.data);
    // Size of Packed Union
    // $bits -> Returns the total no. of bits required to fill the variable (i.e., total = width x depth)
    $display("%0d", $bits(instr));
  end

endmodule
