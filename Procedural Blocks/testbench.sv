module traffic_light_tb;
  logic clk = 0, rst, en;
  logic green, yellow, red;

  traffic_light dut (
    .clk(clk),
    .rst(rst),
    .en(en),
    .green(green),
    .yellow(yellow),
    .red(red)
  );

  always #5 clk = ~clk;

  initial begin
    rst = 1;
    en = 0;
    #10;
    rst = 0;

    $display("--- en=1: normal cycling ---");
    en = 1;
    #60;

    $display("--- en=0: outputs hold ---");
    en = 0;
    #30;

    $display("--- en=1: resumes ---");
    en = 1;
    #30;

    $finish;
  end

  initial begin
    forever begin
      @(posedge clk);
      $display("Time=%0t | green=%0b yellow=%0b red=%0b",
                $time, green, yellow, red);
    end
  end

endmodule
