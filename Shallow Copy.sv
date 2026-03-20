class Inner;
	int val;
endclass

class Outer;
	int id;
  Inner in;
  
  function new(int id, int val);
    in = new();
  	this.id = id;
    in.val = val;
  endfunction

endclass

module tb;
	Outer o_src, o_dst;
  
  initial begin
    o_src = new(1, 100);
    
    o_dst = new o_src;
    o_src.in.val = 69; 
    $display("o_src.in.val = %0d", o_dst.in.val);
    
  end
endmodule
