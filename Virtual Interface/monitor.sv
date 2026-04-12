class monitor;
  virtual dff_if vif;
  transaction tr;
  
  function new(virtual dff_if vif);
    this.vif = vif;
  endfunction
  
  task observe();
    repeat(7) begin
      tr = new();
	
      @(vif.cb_monitor);        // wait one edge for driver to drive
      @(vif.cb_monitor) begin
        tr.d = vif.cb_monitor.d;	// sample on the NEXT edge when q has updated
        tr.q = vif.cb_monitor.q;
      end

      tr.display();
    end
  endtask
  
endclass
