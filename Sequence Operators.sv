module tb;
  logic clk;
  logic valid, ack;
  logic data_ready, load;
  logic start, done;
  logic req, gnt;
  logic a_c1, b_c1;
  logic a_c2, b_c2;
  logic a_d1, b_d1;
  logic a_d2, b_d2;
  logic req1, ack1;
  logic req2, ack2;

  initial clk = 0;
  always #5 clk = ~clk;

  task tick(int n);
    repeat(n) @(posedge clk); #1;
  endtask

  // Delay Operators
  property p1;
    @(posedge clk) valid |-> ##3 ack;
  endproperty
  assert property(p1)
    else $error("ack is not high exactly 3 clk's after valid");

  property p2;
    @(posedge clk) load |-> data_ready;
  endproperty
  assert property(p2)
    else $error("data_ready not high same cycle as load");

  property p3;
    @(posedge clk) start |-> ##[2:5] done; // the simulator tries all windows in parallel — if done is high at ANY of +2, +3, +4, +5, the sequence matches.
  endproperty
  assert property(p3)
    else $error("done did not arrive in window +2 to +5 after start");

  // Infinite Range
  property p4;
    @(posedge clk) req |-> ##[2:$] gnt; // $ means no upper bound. The assertion only fails if gnt never arrives before simulation ends.
  endproperty
  assert property(p4)
    else $error("gnt never arrived after req");

  // Consecutive Repetition
  assert property (@(posedge clk) a_c1 |-> ##1 b_c1[*3])
    else $error("b not high 3 consecutive cycles after a");

  assert property (@(posedge clk) a_c2 |-> ##1 b_c2[*2:5])
    else $error("b not high 2 to 5 consecutive cycles after a");

  // *[n] means consecutive every cycle, [=m] means anywhere within the window with gaps allowed.
  // Non-Consecutive Repetition
  property p5;
    @(posedge clk) a_d1 |-> ##1 b_d1[=2];
  endproperty
  assert property(p5)
    else $error("b not high exactly 2 times after a");

  assert property (@(posedge clk) a_d2 |-> ##1 b_d2[=2:3])
    else $error("b not high 2 to 3 times after a");

  // Parameterised Sequence
  sequence handshake_seq(req_sig, ack_sig);
    req_sig ##2 ack_sig;
  endsequence

  property first_p;
    @(posedge clk) req1 |-> ##2 ack1;
  endproperty

  property second_p;
    @(posedge clk) req2 |-> ##2 ack2;
  endproperty

  assert property(first_p)
    else $error("ack1 did not arrive 2 cycles after req1");
  assert property(second_p)
    else $error("ack2 did not arrive 2 cycles after req2");


  initial begin

    {valid, ack, load, data_ready, start, done} = '0;
    {req, gnt} = '0;
    {a_c1, b_c1, a_c2, b_c2} = '0;
    {a_d1, b_d1, a_d2, b_d2} = '0;
    {req1, ack1, req2, ack2} = '0;
    tick(2);

    // p1 fail
    valid = 1; tick(1); valid = 0;
    tick(1);
    ack = 1; tick(1); ack = 0;
    tick(3);

    // p1 pass
    valid = 1; tick(1); valid = 0;
    tick(2);
    ack = 1; tick(1); ack = 0;
    tick(3);

    // p2 pass
    load = 1; data_ready = 1; tick(1);
    load = 0; data_ready = 0;
    tick(3);

    // p3 fail
    start = 1; tick(1); start = 0;
    tick(6);
    done = 1; tick(1); done = 0;
    tick(3);

    // p3 pass
    start = 1; tick(1); start = 0;
    tick(3);
    done = 1; tick(1); done = 0;
    tick(3);

    // p4 pass
    req = 1; tick(1); req = 0;
    tick(9);
    gnt = 1; tick(1); gnt = 0;
    tick(3);

    // b[*3] fail
    a_c1 = 1; tick(1); a_c1 = 0;
    tick(1);
    b_c1 = 1; tick(1); b_c1 = 0;
    tick(4);

    // b[*3] pass
    a_c1 = 1; tick(1); a_c1 = 0;
    tick(1);
    b_c1 = 1; tick(3); b_c1 = 0;
    tick(4);

    // b[*2:5] fail
    a_c2 = 1; tick(1); a_c2 = 0;
    tick(1);
    b_c2 = 1; tick(1); b_c2 = 0;
    tick(4);

    // b[*2:5] pass
    a_c2 = 1; tick(1); a_c2 = 0;
    tick(1);
    b_c2 = 1; tick(3); b_c2 = 0;
    tick(4);

    // b[=2] fail
    a_d1 = 1; tick(1); a_d1 = 0;
    tick(1);
    b_d1 = 1; tick(1); b_d1 = 0;
    tick(6);

    // b[=2] pass
    a_d1 = 1; tick(1); a_d1 = 0;
    tick(1);
    b_d1 = 1; tick(1); b_d1 = 0;
    tick(1);
    b_d1 = 1; tick(1); b_d1 = 0;
    tick(4);

    // b[=2:3] pass
    a_d2 = 1; tick(1); a_d2 = 0;
    tick(1);
    b_d2 = 1; tick(1); b_d2 = 0;
    tick(2);
    b_d2 = 1; tick(1); b_d2 = 0;
    tick(4);

    // first_p pass — req1 then ack1 exactly 2 cycles later
    req1 = 1; tick(1); req1 = 0;
    tick(1);
    ack1 = 1; tick(1); ack1 = 0;
    tick(3);

    // second_p fail — ack2 comes at +5 instead of +2
    req2 = 1; tick(1); req2 = 0;
    tick(4);
    ack2 = 1; tick(1); ack2 = 0;
    tick(3);

    tick(10);
    $display("simulation done");
    $finish;

  end

endmodule
