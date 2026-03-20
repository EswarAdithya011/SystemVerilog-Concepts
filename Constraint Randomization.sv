class constraints;

  typedef enum {Red, Green, Blue} color_t;

  rand bit [31:0] addr;
  rand bit [7:0] data, alt;
  rand bit [3:0] array[4];
  rand bit write, read;
  rand bit [11:0] ctrl;
  rand color_t col;
  rand int a, b, c;

  int redw = 5, greenw = 3, bluew = 4;

  // Set Membership
  constraint c_range {
    data inside {[20:100]};
  }

  // Relations in Constriants
  constraint c_relational {
    array.sum() < 30;
    data == addr / 5;
    write != read;
  } 
    
//   constraint limit {
//     ((data==5) || (data==7) || (data==9));
//   }
  
  // Implication Constraint
  constraint c_implication {
    write == 1 -> data inside {[20:100]};
    write == 0 -> data inside {[0:20]};
  }
  
  constraint c_weights {
    // := Gives Same Weight to all the values
    ctrl dist {0:= 10, [1:5]:= 25, [6:32]:= 110}; // Total Weight = 10 + 5*25 + 27*110 = 3105
    
    alt dist {0:/ 0, [1:10]:/ 10, [11:44]:/ 11, [45:90]:/ 20, [91:255]:/ 59}; // Total Weight = 10 + 11 + 20 + 59 = 100

    col dist {Red := redw,
              Green := greenw,
              Blue := bluew};
  }
  
  // All Constraints are active at the same time and dependent on one another. This is bidirectional Constraint.
  constraint c_bidirectional {
  	a < b;
    b > c;
    a >= c;
    b > 11;
    a != 11;
  }
  
  // Efficient Constraints. This is necessary for lowering the computational burden on the constraint solver.
  	// 1. Reduce Search Domain
  	// 2. Avoid Unnecessary Equalities
 	// 3. Avoid Redundtant Constraints   
//   constraint slow { 
//     addr % 4096 inside { [0:20], [4075:4095] };
//   }
  constraint fast { 
  	addr [11:0] inside { [100:500] };
  }

  function void pre_randomize();
    write = 1;
    read = 0;
  endfunction
  
  function void post_randomize();
    $display("""!!Randomization Successful!!
             write = %0b, read = %0b""", write, read);
  endfunction
  
  function string toString(string s_value = "");
    // Used for String Representation of Object
    // It just format the data given and return it..
    return $sformatf("addr = %0d, data = %0d, array[0] = %0d, ctrl = %0d, alt = %0d, col = %0s, {a, b, c} = %0h %0h %0h",
                     addr, data, array[0], ctrl, alt, col.name(), a, b, c);	
  endfunction
  
endclass



module tb;

  constraints c[3];
  
  initial begin
    c[0] = new;

    // Inline Constraint
    repeat (20) begin
      assert (c[0].randomize() with { data != 150; })
        else 
          $error("Randomization Failed");

      $display("%s", c[0].toString());
      $display("c[0].ctrl = %0d", c[0].ctrl);
      $display("c[0].alt  = %0d", c[0].alt);
      $display("--------------------------------------------");
    end
  end

endmodule
