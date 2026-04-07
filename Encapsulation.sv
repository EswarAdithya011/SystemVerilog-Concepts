						ENCAPSULATION
						LOCAL ACCESS MODIFIER

module tb;

  class parent;
    local int a;

    function new(int x);
      a = x;
    endfunction

    function void show();
      $display("Inside parent, a = %0d", a);
    endfunction
  endclass


  class child extends parent;

    function new(int x);
      super.new(x);
    endfunction

    function void access_parent();
      $display("Trying to access a = %0d", a);  // SHOULD FAIL
    endfunction

  endclass


  parent p;
  child  c;

  initial begin
    p = new(10);
    c = new(20);

    p.show();     // Works

    p.a = 5;      // SHOULD FAIL (module access)
    c.access_parent();  //  SHOULD FAIL (child access)
  end

endmodule
