class base;
  int a; // Public by default
  protected int b; // Only for base and extended classes but not outside of class
  local int c; // avalable only for this class
  
  function void set_values(int a, int y, int z);
    base::a = a; // This works as for 'a' on LHS side I am giving class reference it checks the scope of a within the class. So no worries!!
//     b = y;
//     c = z;
//     {a, b, c} = {x, y, z}; // Just doing Experiments.........
  endfunction
  
  function void display_base();
    $display("BASE a=%0d b=%0d c=%0d", a, b, c);
  endfunction
  
endclass


class extended extends base;
  
  function void access_inside_child();
    a = 100;   // allowed
    b = 200;   // allowed
    // c = 300; // Illegal
  endfunction
  
  function void display_child();
    $display("CHILD a=%0d b=%0d", a, b);
  endfunction
  
endclass


module tb;
  extended e;
  
  initial begin
    e = new;
    
    e.a = 10;
//     e.b = 20; // Ilegal
//     e.c = 44; // Illegal
    
    e.set_values(1,2,3);
    
    e.access_inside_child();
    
    e.display_base();
    e.display_child();
  end
endmodule
