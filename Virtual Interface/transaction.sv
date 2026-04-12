class transaction;
  rand bit d;
  bit q;
  
  constraint c_d {
    d dist {0 := 50, 1 := 50};
  }
  
  function void display();
    $display("d = %0b, q = %0b", d, q);
  endfunction

endclass
