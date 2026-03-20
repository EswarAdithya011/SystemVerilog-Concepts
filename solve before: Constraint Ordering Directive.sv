class solve_before_demo;

  rand bit x;
  rand bit [1:0] y;

  // Control switch
  bit solve_x_first;

  // Constraint
  constraint c {
    (x == 0) -> (y == 0);
  }

  // Solve ordering
  constraint order {
    if (solve_x_first)
      solve x before y;
    else
      solve y before x;
  }

endclass



module tb;

  solve_before_demo s;

  int count[2][4]; // count[x][y]

  task run_case(string name, bit solve_x_first);
    int i, j;

    // Reset counters
    for (i = 0; i < 2; i++)
      for (j = 0; j < 4; j++)
        count[i][j] = 0;

    s.solve_x_first = solve_x_first;

    // Run randomization
    repeat (10000) begin
      assert(s.randomize());
      count[s.x][s.y]++;
    end

    // Print results
    $display("\n===== %s =====", name);
    for (i = 0; i < 2; i++) begin
      for (j = 0; j < 4; j++) begin
        $display("x=%0d y=%0d count=%0d prob=%0f",
                 i, j, count[i][j], count[i][j]/10000.0);
      end
    end
  endtask


  initial begin
    s = new();

    // CASE 1: solve x before y
    run_case("solve x before y", 1);

    // CASE 2: solve y before x
    run_case("solve y before x", 0);

  end

endmodule
