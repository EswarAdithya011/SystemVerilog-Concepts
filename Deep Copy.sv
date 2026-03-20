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
  
  extern function Outer deep_copy();

endclass

function Outer Outer::deep_copy();
  Outer o_copy = new(id, in.val);
	o_copy.id = this.id;
  	o_copy.in.val = in.val; // Inner new Object
  
  return(o_copy);
  
endfunction
    
module tb;
	Outer o_src, o_dst;
  
  initial begin
    o_src = new(1, 20);
    o_dst = o_src.deep_copy();
    
    o_dst.in.val = 69;
    $display("o_src.in.val = %0p", o_src.in.val);
    $display("o_src.in.val = %0p", o_dst.in.val);
    
    
  end
endmodule
