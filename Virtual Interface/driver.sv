class driver;
  virtual dff_if vif;
  transaction tr;
  
  function new(virtual dff_if vif);
    this.vif = vif;
  endfunction
  
  task drive();
    repeat(5) begin
      tr = new();
      void'(tr.randomize());
	
      @(vif.cb_driver);
        vif.cb_driver.d <= tr.d;
     $display("[DRIVER] driving d = %0b at time %0t", tr.d, $time);
    end
  endtask
  
endclass
