`include "interface.sv"
`include "transaction.sv"
`include "driver.sv"
`include "monitor.sv"

module tb;
  logic clk = 0;
  
  always #5 clk = ~clk;
  
  dff_if intf(.clk(clk));
  
  dff dut(.intf(intf));
	
  driver dr;
  monitor mnt;

  initial begin
    intf.rst = 1;
    #20 intf.rst = 0;
    $display("[TB] rst deasserted at time %0t", $time);
    
    dr = new(intf);
    mnt = new(intf);
    
    fork: drive_sample 
      dr.drive();
      mnt.observe();
    join: drive_sample
      
    #120 $finish;
  end

endmodule
