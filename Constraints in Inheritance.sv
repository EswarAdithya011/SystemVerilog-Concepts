class parent;
	rand int data;
  
  constraint limit1 {
  	data > 0;
    data < 100;
  }
endclass

class child extends parent;
  // Overriding Parent field Declaration. So, Only need to satisfy the child constraints only.
  rand int data;
  
  // Overridden the Parent Constraint Using same constraint name of parent. 
  constraint limit {
  	data > 0;
    data < 40;
  }
  
  constraint limit2 {
  	data > 30;
    data < 50;
  }
  
  task display();
    $display("data = %0d", data);
  endtask
  
endclass

module tb;
	child c;
  
  initial begin
  	c = new;
    
    repeat(2) begin
      assert(c.randomize())
        c.display();
      else
        $display("Randomization Failed");
    end
  end
  
endmodule
