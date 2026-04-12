module dff(dff_if.mp_dut intf);
  always_ff @(posedge intf.clk) begin
    if(intf.rst)
      intf.q <= 0;
    else
      intf.q <= intf.d;
  end
  
endmodule
