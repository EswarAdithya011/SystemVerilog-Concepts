class soft_constraint;
  rand int a;
  // A soft constraint is a low-priority constraint that can be overridden by:
    // 1. other constraints
    // 2. inline constraints during randomize()

  // soft constraint
  constraint c_soft {
    soft a == 5;
  }
  // hard constraint 
  constraint c_hard {
    a inside {[1:10]};
  }
endclass

module tb;
  soft_constraint sc;

  initial begin
    sc = new();

    $display("\n---- Case 1: Only soft constraint ----");
    // disable hard constraint
    sc.c_hard.constraint_mode(0);

    repeat(3) begin
      assert(sc.randomize());
      $display("a = %0d", sc.a); // expect mostly 5
    end

    $display("\n---- Case 2: soft + hard constraint (no conflict) ----");
    sc.c_hard.constraint_mode(1);

    repeat(3) begin
      assert(sc.randomize());
      $display("a = %0d", sc.a); // still 5 (valid in [1:10])
    end

    $display("\n---- Case 3: inline constraint overrides soft ----");
    repeat(3) begin
      assert(sc.randomize() with { a == 8; });
      $display("a = %0d", sc.a); // should be 8
    end

    $display("\n---- Case 4: inline + hard + soft ----");
    repeat(3) begin
      assert(sc.randomize() with { a == 3; });
      $display("a = %0d", sc.a); // 3 (valid + overrides soft)
    end

    $display("\n---- Case 5: hard vs soft conflict ----");

    // modify hard constraint dynamically using inline
    repeat(3) begin
      assert(sc.randomize() with { a > 6; });
      $display("a = %0d", sc.a); // 7-10, soft ignored
    end

    $display("\n---- Case 6: soft vs soft ----");

    repeat(5) begin
      assert(sc.randomize() with { soft a == 9; });
      $display("a = %0d", sc.a); // could be 5 or 9
    end

    $display("\n---- Case 7: impossible hard constraint (should fail) ----");

    if (!sc.randomize() with { a > 20; }) begin
      $display("Randomization FAILED as expected");
    end
  end

endmodule
