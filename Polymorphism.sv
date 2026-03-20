class parent;
int a=3;
  function void d1();
  	$display("Parent d1");
  endfunction
  
  virtual function void d2();
  	$display("Parent d2");
  endfunction
endclass

class child extends parent;
int b=8;
  function void d1();
  	$display("Child d1");
  endfunction
  
  function void d2();
  	$display("Child d2");
  endfunction
endclass

module tb;
	initial begin
      parent p1; 
      child c1;
      
      c1=new;
      $cast(p1, c1);
      //p1=c1;
      // checks run-time casting errors
      //checks compile time casting errors
      //properties and virtual methods in parent class
      //points to one defined in child class
      p1.d1; 
      p1.d2;
      $display("p1.a=%0d", p1.a); 
      
      c1.a=9;
      $display("p1.a=%0d", p1.a);
    end

endmodule
