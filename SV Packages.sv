// reusable transaction system
package my_pkg;
  typedef enum {
	READ, WRITE, ERROR
  } pkt_type_t;

  class transaction;
    rand bit [7:0] addr;
    rand bit [7:0] data;
    rand pkt_type_t p_type;
    
    constraint c_default {
    	soft p_type == READ;
    }
    constraint c_address_range {
      addr inside {[0:100]};
    }
    constraint c_conditional {
      if (p_type == ERROR)
        data == 0;
    }
    static constraint error_bias {
      soft p_type == ERROR;
    }
    
    task display();
      $display("Type = %s, addr = %0h, data = %0d", p_type.name(), addr, data);
    endtask
    
  endclass

endpackage

package my_pkg_ext;

  typedef enum { READ, WRITE, ERROR } pkt_type_t;

  class transaction;

    rand bit [7:0] addr;
    rand bit [7:0] data;
    rand pkt_type_t p_type;

    // override behavior
    constraint c_override {
      p_type == WRITE;
    }

    constraint c_address_range {
      addr inside {[50:150]};
    }

    task display();
      $display("[EXT] Type=%s addr=%0h data=%0d",
                p_type.name(), addr, data);
    endtask

  endclass

endpackage


module tb;
//   There is no conflict because:
    // 1. only one package is imported with *
    // 2. the other is accessed explicitly using ::
  import my_pkg::*; // * -> Used for wildcard import only the items that are actually utilized in the module or interface are imported. Any definitions and declarations 
                    // in the package that are not referenced remain unimported
  import my_pkg_ext::transaction;  
  transaction t; // my_pkg::transaction t;
  
  my_pkg::transaction t1, t2, t3;
  my_pkg_ext::transaction t_ext;
  
  initial begin
    my_pkg::transaction::error_bias.constraint_mode(0);  
    
  	t = new;
    
    $display("Case 1: Default behavior");

    repeat(5) begin
      assert(t.randomize())
        else
          $display("Randomization Failed!!");
      t.display();
    end
    
    $display("Case 2: Override using inline");
    
    repeat(5) begin
      assert(t.randomize() with {p_type == WRITE;})
        else
          $display("Randomization Failed!!");
      t.display();
    end
    
    $display("Case 3: Conflict check");
	
    repeat(5) begin
      if (!t.randomize() with {
            p_type == ERROR;  
            data != 0;
          })
        $display("Expected conflict -> randomization failed");
    end
    
    $display("\n---- Case 4: Multiple objects ----");

    t1 = new();
    t2 = new();

    assert(t1.randomize());
    assert(t2.randomize());

    $display("t1:");
    t1.display();

    $display("t2:");
    t2.display();
    
   	$display("\n---- Case 5: Using scope resolution ----");

	t3 = new();

    assert(t3.randomize())
      t3.display();
    
    $display("\n---- Case 6: Enable static constraint ----");

    my_pkg::transaction::error_bias.constraint_mode(1);

    repeat(5) begin
      assert(t1.randomize());
      t1.display(); // expect more ERROR packets
    end
    
     $display("\n---- Case 7: Disable static constraint ----");

    my_pkg::transaction::error_bias.constraint_mode(0);

    repeat(5) begin
      assert(t1.randomize());
      t1.display();
    end
    
    $display("\n---- Case 8: Using EXT package ----");

    t_ext = new();

    repeat(5) begin
      assert(t_ext.randomize());
      t_ext.display();
    end

  end
  
endmodule
