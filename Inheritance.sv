// 							INHERITANCE

class parent;
	int a, b;
  	
  function new();
    this.b = b;
    $display("Parent Constructor");
  endfunction
  function display();
    $display("Parent Class a = %0d", a);
  endfunction
  
endclass

class child extends parent;
	int c;
  
  function new();
//     super.new(100);
    $display("Child Constructor");
  endfunction
  
  function display();
    $display("Child Class a = %0d", a);
    super.display();
  endfunction

endclass

module tb;
	parent p;
  child c;
  
  initial begin
    c = new;
//     p = new;

    // Display method to be called decided by the object type that we are calling from.
    c.a = 3;
//     p.a = 4;
  
  	 c.display;
//     p.display;
  end
endmodule
