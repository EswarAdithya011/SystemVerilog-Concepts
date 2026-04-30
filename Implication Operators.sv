module test;
  bit en, req, gnt;
  bit [1:0] mode;
  logic clk;

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  property p1;
    en |-> ##2 req ##4 gnt;
  endproperty
  AP1: assert property (@(posedge clk) p1)
  else $error("AP1 failed: en fired but req/gnt chain broken");

  property p2;
    @(posedge clk) en |=> req ##2 gnt;
  endproperty
  AP2: assert property (p2)
  else $error("AP2 failed: |=> req##2gnt violated");

  property chk_overlapping;
    @(posedge clk) (en && (mode == 2'b01)) |-> ##3 gnt;
  endproperty
  AP3: assert property (chk_overlapping)
  else $error("AP3 failed: overlapping, gnt not at +3");

  property chk_nonoverlapping;
    @(posedge clk) (en && (mode == 2'b01)) |=> ##2 gnt;
  endproperty
  AP4: assert property (chk_nonoverlapping)
  else $error("AP4 failed: non-overlapping, gnt not at +3");

  task tick(int n = 1);
    repeat(n) @(posedge clk); #1;
  endtask

  initial begin
    $assertvacuousoff(0);
    {en, req, gnt, mode} = 0;
    $assertoff(0, test.AP1);
    $assertoff(0, test.AP2);
    $assertoff(0, test.AP3);
    $assertoff(0, test.AP4);

    // Part A
    $asserton(0, test.AP1);

    tick(); en = 1;
    tick(); en = 0;
    tick(8);

    tick(); en = 1;
    tick(); en = 0;
    tick(); req = 1;
    tick(); req = 0;
    tick(2); gnt = 1;
    tick(); gnt = 0;
    tick(3);

    tick(); en = 1;
    tick(); en = 0;
    tick(); req = 1;
    tick(); req = 0;
    tick(3); gnt = 1;
    tick(); gnt = 0;
    tick(3);

    $assertoff(0, test.AP1);

    // Part B
    $asserton(0, test.AP1);
    tick(15);
    $assertoff(0, test.AP1);

    // Part C
    $asserton(0, test.AP2);

    tick(); en = 1; req = 1;
    tick(); en = 0; req = 0;
    tick(6);

    tick(); en = 1;
    tick(); en = 0; req = 1;
    tick(); req = 0;
    tick(6);

    tick(); en = 1;
    tick(); en = 0; req = 1;
    tick(); req = 0;
    tick();
    tick(); gnt = 1;
    tick(); gnt = 0;
    tick(3);

    tick(); en = 1;
    tick(); en = 1; req = 1;
    tick(); en = 0; req = 1;
    tick(); req = 0;
    tick(); gnt = 1;
    tick(); gnt = 1;
    tick(); gnt = 0;
    tick(4);

    $assertoff(0, test.AP2); // Just given full heirarchial path 

    // Part D
    $asserton(0, AP3);
    $asserton(0, AP4);

    mode = 2'b01;
    tick(); en = 1;
    tick(); en = 0;
    tick(2); gnt = 1;
    tick(); gnt = 0;
    tick(4);

    mode = 0;
    $assertoff(0, AP3);
    $assertoff(0, AP4);

    $finish;
  end
endmodule
