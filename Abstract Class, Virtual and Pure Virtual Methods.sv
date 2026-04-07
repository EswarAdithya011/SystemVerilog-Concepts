virtual class parent;
  int a;

  function new(int a);
    this.a = a;
  endfunction

  virtual function void size();
    $display("PARENT size a=%0d", $bits(a));
  endfunction

  pure virtual function void display(string s);
endclass


class child extends parent;
  bit [1:0] b;

  function new(int a, bit [1:0] b);
    super.new(a);
    this.b = b;
  endfunction

  function void size();
    $display("CHILD size a=%0d b=%0d", $bits(a), $bits(b)); // $bits is recommended beacuse it is used for variables. It returns total no.of memory location required to fill the variable.
  endfunction

  function void display(string s);
    $display("CHILD %s a=%0d b=%0b", s, a, b);
  endfunction
endclass

// Simple Inheritance
    // Here I don't want to give implementation of display despite it is pure virtual, So I made the class itself as virtual to avoid giving implementation. However, the parent is expecting an argument for new constructor that I passed using super.new() method.
virtual class incomplete_child extends parent;
  function new(int a);
    super.new(a);
  endfunction
endclass

// Multi-Level Hierarchy
class grand_child extends child;
  shortreal c;

  function new(int a, bit [1:0] b, shortreal c);
    super.new(a, b);
    this.c = c;
  endfunction

  function void display(string s);
    $display("GRANDCHILD %s a=%0d b=%0b c=%0f", s, a, b, c);
  endfunction
endclass


module tb;
  parent p;
  child c;
  grand_child gc;

  initial begin
//     p = new(5); // Ilegal as abstract class cannot have class instance
    c = new(10, 2'b01);
    gc = new(20, 2'b11, 3.14);

    c.display("direct");
    gc.display("direct");

    p = c; // Upcaseting
    p.display("via parent");
    p.size();

    p = gc; // Upcasting. Parent can point child memory and can only access parent properties in grand_child class but not properties declared in grand_child class directly but I can display all the properties(both parent and child) using display within it...
    p.display("via parent");
    p.size();
  end
endmodule
