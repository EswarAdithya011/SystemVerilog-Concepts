class demo;
  bit [3:0] a, b;
  
  function new(int a, int b);
  	this.a = a;
    this.b = b;
  endfunction

endclass

module tb;
  demo d[2];
  
  initial begin
    d[0] = new(10, 20);
    $display("d[0] = %0p", d[0]);
    d[1] = new(30, 30);
    $display("d[0] = %0p", d[1]);
  end

endmodule
