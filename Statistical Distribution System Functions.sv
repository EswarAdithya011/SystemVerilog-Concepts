module tb;

  int seed = 123;   // must be variable
  int val;

  initial begin

    $display("1) UNIFORM DISTRIBUTION");
    repeat (10) begin
      val = $dist_uniform(seed, 0, 10);
      $display("Uniform [0:10] = %0d", val);
    end


    $display("2) NORMAL DISTRIBUTION");
    repeat (10) begin
      val = $dist_normal(seed, 50, 10);
      $display("Normal (mean=50, std=10) = %0d", val);
    end


    $display("3) EXPONENTIAL DISTRIBUTION");
    repeat (10) begin
      val = $dist_exponential(seed, 10);
      $display("Exponential (mean=10) = %0d", val);
    end


    $display("4) POISSON DISTRIBUTION");
    repeat (10) begin
      val = $dist_poisson(seed, 4);
      $display("Poisson (mean=4) = %0d", val);
    end


    $display("5) CHI-SQUARE DISTRIBUTION");
    repeat (10) begin
      val = $dist_chi_square(seed, 3);
      $display("Chi-square (df=3) = %0d", val);
    end


    $display("6) T-DISTRIBUTION");
    repeat (10) begin
      val = $dist_t(seed, 5);
      $display("T-distribution (df=5) = %0d", val);
    end


    $display("7) ERLANG DISTRIBUTION");
    repeat (10) begin
      val = $dist_erlang(seed, 3, 10);
      $display("Erlang (k=3, mean=10) = %0d", val);
    end

    $finish;
  end

endmodule
