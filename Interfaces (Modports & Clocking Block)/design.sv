`include "and_intf.sv"

module and_behavioral(and_intf.dut_mp intf);
  always_ff @(posedge intf.clk) begin
    intf.y <= intf.a & intf.b;
  end
  
endmodule
