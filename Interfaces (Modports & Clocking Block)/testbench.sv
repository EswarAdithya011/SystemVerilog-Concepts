// `include "and_intf.sv"
module tb;
  logic clk = 0;
  
  initial begin 
    forever #5 clk = ~clk;
  end
  
  and_intf intf(.clk(clk));
  
  and_behavioral DUT(.intf(intf.dut_mp));
  
  initial begin
    $display("Driving Values through Interface");
    	intf.cb_tb.a <= 0; intf.cb_tb.b <= 0;
    #10 intf.cb_tb.a <= 0; intf.cb_tb.b <= 1;
    #10 intf.cb_tb.a <= 1; intf.cb_tb.b <= 0;
    #10 intf.cb_tb.a <= 1; intf.cb_tb.b <= 1;
    #10;
    $display("Driving Done!!");
  
    #20 $finish;
  end
  
//   always @(intf.cb_tb) begin
//     $display("[%0t] intf.cb_tb.a = %0b, intf.cb_tb.b = %0b || intf.cb_tb.y = %0b", $realtime, intf.cb_tb.a, intf.cb_tb.b, intf.cb_tb.y);
//   end
  
  initial begin
    forever begin
      // In Output there will be a delay of 1 clk since I'm driving 
      @(intf.cb_tb);
      $display("[%0t] intf.a = %0b, intf.b = %0b || intf.y = %0b", $realtime, intf.a, intf.b, intf.cb_tb.y);
    end
  end
  
endmodule
