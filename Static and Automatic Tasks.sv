module tb;
  int shared = 100;
  
  // Static task (default behavior)
  task update_static(int a);
    #5;
    a = a * 2;
    shared = shared + a;
    $display("%0t : static task -> input doubled to %0d, shared becomes %0d", $time, a, shared);
  endtask

  // Automatic task (independent for each call)
  task automatic update_auto(int a);
    #5;
    a = a * 2;
    shared = shared + a;
    $display("%0t : automatic task -> input doubled to %0d, shared becomes %0d", $time, a, shared);
  endtask

  // Pass by reference
  task automatic update_ref(ref int a);
    #5;
    a = a * 2;
    $display("%0t : reference task updated value to %0d", $time, a);
  endtask

  // Static local variable
  task static_counter();
    static int count = 0; 
      count++;
    $display("%0t : static counter value is %0d", $time, count);
  endtask

  // Automatic local variable
  task automatic auto_counter();
    int count = 0;
    count++;
    $display("%0t : automatic counter value is %0d", $time, count);
  endtask

  initial begin
      int x = 5;
    int y = 7;

    $display("\nStarting static task demonstration");
    fork
      update_static(10);
      #2 
      update_static(20);
    join
    #10;
    $display("\nStarting automatic task demonstration");

    fork
      update_auto(10);
      #2 update_auto(20);
    join

    #10;
    $display("Demonstrating Pass by value and pass by reference");

    fork
      update_auto(x);
      update_ref(y);
    join

    $display("%0t : after calls, x = %0d and y = %0d", $time, x, y);

    #10;
    $display("Comparing static and automatic local variables");

    fork
      static_counter();
      static_counter();
      auto_counter();
      auto_counter();
    join
    
    #10;
    $display("Demonstrating fork join_none behavior");

    fork
      update_auto(3);
      update_auto(4);
    join_none

    $display("%0t : main thread continues without waiting", $time);

    #20;
    $finish;
  end

endmodule
