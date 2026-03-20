module tb_top;
  // IEEE 1800-2023 Triple-Quoted String
  string info_msg = """
    Welcome to the "2023 Enhanced" testbench.
    You can now write multiline strings 
    without using the \n character manually 
    or escaping "double quotes" like this.
  """;

  initial begin
    $display("%s", info_msg);
  end
endmodule
