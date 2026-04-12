interface dff_if(input logic clk);
  logic d, q;
  logic rst;
  
  modport mp_dut(input clk, input d, rst, output q);
  
  clocking cb_driver @(posedge clk);
    default input #1step output #1step;
    
    output d;
  endclocking
  
  clocking cb_monitor @(posedge clk);
    default input #1step output #0;
    
    input q;
    input d;
  endclocking
  
  modport mp_tb(clocking cb_driver, clocking cb_monitor);

endinterface
