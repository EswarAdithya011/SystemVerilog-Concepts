interface and_intf(input logic clk);
  logic a, b;
  logic y;
  
  clocking cb_tb @(posedge clk);
  	default input #1step output #0; // Default Input and Output Skews
    
    output a, b;
    input y;
  endclocking
  
  modport dut_mp (input a, b, clk,	 output y);
    
  modport tb_mp (clocking cb_tb);
  
endinterface
