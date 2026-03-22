class constraints;
  randc bit [3:0]a;
  // Belongs to class rather an instance of class. Shared across all the instances of class 
  static constraint stat_const {
  	a < 10;
  }
  
endclass

module tb;
  constraints c;
  
  initial begin
  	c = new;
    
    $display("------- (a < 10) ---------");
    repeat(5) begin
      assert(c.randomize());
      $display("a = %0d", c.a);
    end
    
    $display("------- (a < 10) Turned Off --------");
    // Turning-off Static Constraint with handle reference
//     c.c1.constraint_mode(0);
    // Turning-off without handle reference
    constraints::stat_const.constraint_mode(0);
    repeat(5) begin
      assert(c.randomize());
      $display("a = %0d", c.a);
    end
  end
  
  
endmodule
