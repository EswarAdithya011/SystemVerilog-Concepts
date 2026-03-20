class singleton #(type T = int);
	T a;
  	static singleton s_obj;
  
  function new(int a);
  	this.a = a;
  endfunction
  
  static function singleton create(int a);
    if (s_obj == null)
      s_obj = new(a);
    
    return s_obj;
  endfunction
endclass


module tb;
  singleton #(int) s;
  
  initial begin
    s = singleton::create(69);
    
    $display(s.a);
  end
endmodule
