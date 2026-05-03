module tb;
  logic clk, req, ack, gnt, rdy, val, busy, flush, drain, stall, vld, sop, eop, pause;

  initial clk = 0;
  always #5 clk = ~clk;

  sequence seq_req_ack;
    req ##3 ack;
  endsequence

  sequence seq_gnt_rdy_val;
    gnt ##2 rdy ##2 val;
  endsequence

  // AND starts both sequences at the same cycle. Failure is reported at cycle 6 — the later endpoint — even if seq_req_ack already matched at cycle 4.
  property and_p;
    @(posedge clk) (req && gnt) |-> seq_req_ack and seq_gnt_rdy_val;
  endproperty
  and_assertion: assert property (and_p);

  sequence seq_req_ack_fixed;
    req ##3 ack ##1 1'b1;
  endsequence

  // INTERSECT demands identical endpoints. Extending seq_req_ack by ##1 aligns it to cycle 4. Any mismatch in endpoint — even by one cycle — means the property can never be satisfied regardless of stimulus.
  property intersect_p;
    @(posedge clk) (req && gnt) |-> seq_req_ack_fixed intersect seq_gnt_rdy_val;
  endproperty
  intersect_assertion: assert property (intersect_p);

  // ##[1:3] spawns 3 threads, OR passes if any one matches
  sequence seq_path_fast;
    vld ##[1:3] eop;
  endsequence

  sequence seq_path_slow;
    sop ##1 pause ##3 eop;
  endsequence

  property or_p;
    @(posedge clk) (vld || sop) |-> seq_path_fast or seq_path_slow;
  endproperty
  or_assertion: assert property (or_p);

  // throughout checks the condition at every cycle inside the sequence window. The failure cycle is where the condition breaks — not where the sequence ends. This is a cycle-by-cycle guard, not a start-and-end check.
  property throughout_p1;
    @(posedge clk) busy |-> (!stall) throughout (busy ##2 drain ##1 flush);
  endproperty
  throughout_assertion1: assert property (throughout_p1);

  property throughout_p2;
    @(posedge clk) sop |-> (!pause && vld) throughout (sop ##3 eop);
  endproperty
  throughout_assertion2: assert property (throughout_p2);

  // Without first_match, every cycle where ack is high within the range spawns a separate consequent check. first_match collapses all of them to the earliest match and discards the rest.
  sequence seq_gnt_window;
    gnt ##[1:4] ack;
  endsequence

  property first_match_p;
    @(posedge clk) gnt |-> first_match(seq_gnt_window) |=> rdy;
  endproperty
  first_match_assertion: assert property (first_match_p);

  // within requires the inner sequence to both start no earlier than the outer and complete no later than the outer. A one-cycle overshoot in either direction is a hard failure.
  sequence seq_outer;
    sop ##1 !busy ##3 eop;
  endsequence

  sequence seq_inner;
    vld ##2 drain;
  endsequence

  property within_p;
    @(posedge clk) sop |-> seq_inner within seq_outer;
  endproperty
  within_assertion: assert property (within_p);

  initial begin
    $assertoff(0, tb);
    {req,ack,gnt,rdy,val,busy,flush,drain,stall,vld,sop,eop,pause} = '0;
    repeat(2) @(posedge clk);

    // AND fail — seq_gnt_rdy_val breaks, rdy never arrives
    $asserton(0, tb.and_assertion);
    @(posedge clk); req=1; gnt=1;
    @(posedge clk); req=0; gnt=0;
    @(posedge clk);
    @(posedge clk); ack=1;
    @(posedge clk); ack=0;
    repeat(3) @(posedge clk);
    $assertoff(0, tb.and_assertion);
    {req,ack,gnt,rdy,val} = '0;
    repeat(2) @(posedge clk);

    // AND pass — req@0 gnt@0, rdy@2, ack@3, val@4
    $asserton(0, tb.and_assertion);
    @(posedge clk); req=1; gnt=1;
    @(posedge clk); req=0; gnt=0;
    @(posedge clk); rdy=1;
    @(posedge clk); ack=1; rdy=0;
    @(posedge clk); ack=0; val=1;
    @(posedge clk); val=0;
    repeat(2) @(posedge clk);
    $assertoff(0, tb.and_assertion);
    {req,ack,gnt,rdy,val} = '0;
    repeat(2) @(posedge clk);

    // INTERSECT pass — same timing, fixed seq endpoint aligns at cycle 4
    $asserton(0, tb.intersect_assertion);
    @(posedge clk); req=1; gnt=1;
    @(posedge clk); req=0; gnt=0;
    @(posedge clk); rdy=1;
    @(posedge clk); ack=1; rdy=0;
    @(posedge clk); ack=0; val=1;
    @(posedge clk); val=0;
    repeat(2) @(posedge clk);
    $assertoff(0, tb.intersect_assertion);
    {req,ack,gnt,rdy,val} = '0;
    repeat(2) @(posedge clk);

    // OR pass — fast path only, eop at delay 2
    $asserton(0, tb.or_assertion);
    @(posedge clk); vld=1;
    @(posedge clk); vld=0;
    @(posedge clk); eop=1;
    @(posedge clk); eop=0;
    repeat(2) @(posedge clk);
    $assertoff(0, tb.or_assertion);
    {vld,eop} = '0;
    repeat(2) @(posedge clk);

    // OR pass — slow path only, sop@0 pause@1 eop@4
    $asserton(0, tb.or_assertion);
    @(posedge clk); sop=1;
    @(posedge clk); sop=0; pause=1;
    @(posedge clk); pause=0;
    @(posedge clk);
    @(posedge clk); eop=1;
    @(posedge clk); eop=0;
    repeat(2) @(posedge clk);
    $assertoff(0, tb.or_assertion);
    {sop,pause,eop} = '0;
    repeat(2) @(posedge clk);

    // OR fail — both paths broken, eop never comes
    $asserton(0, tb.or_assertion);
    @(posedge clk); vld=1; sop=1;
    @(posedge clk); vld=0; sop=0;
    repeat(5) @(posedge clk);
    $assertoff(0, tb.or_assertion);
    {vld,sop} = '0;
    repeat(2) @(posedge clk);

    // THROUGHOUT p1 fail — stall high at cycle 2, fires before drain or flush
    $asserton(0, tb.throughout_assertion1);
    @(posedge clk); busy=1;
    @(posedge clk); busy=0; stall=1;
    @(posedge clk); stall=0;
    repeat(4) @(posedge clk);
    $assertoff(0, tb.throughout_assertion1);
    {busy,stall,drain,flush} = '0;
    repeat(2) @(posedge clk);

    // THROUGHOUT p1 pass — stall=0 throughout, drain@2 flush@3
    $asserton(0, tb.throughout_assertion1);
    @(posedge clk); busy=1;
    @(posedge clk); busy=0;
    @(posedge clk); drain=1;
    @(posedge clk); drain=0; flush=1;
    @(posedge clk); flush=0;
    repeat(2) @(posedge clk);
    $assertoff(0, tb.throughout_assertion1);
    {busy,drain,flush} = '0;
    repeat(2) @(posedge clk);

    // THROUGHOUT p2 fail — vld drops at cycle 1
    $asserton(0, tb.throughout_assertion2);
    @(posedge clk); sop=1; vld=1;
    @(posedge clk); sop=0; vld=0;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk); eop=1;
    @(posedge clk); eop=0;
    repeat(2) @(posedge clk);
    $assertoff(0, tb.throughout_assertion2);
    {sop,vld,eop,pause} = '0;
    repeat(2) @(posedge clk);

    // THROUGHOUT p2 fail — pause high at cycle 1
    $asserton(0, tb.throughout_assertion2);
    @(posedge clk); sop=1; vld=1;
    @(posedge clk); sop=0; pause=1;
    @(posedge clk); pause=0;
    @(posedge clk);
    @(posedge clk); eop=1;
    @(posedge clk); eop=0; vld=0;
    repeat(2) @(posedge clk);
    $assertoff(0, tb.throughout_assertion2);
    {sop,vld,eop,pause} = '0;
    repeat(2) @(posedge clk);

    // THROUGHOUT p2 pass — vld high pause low all 3 cycles, eop@3
    $asserton(0, tb.throughout_assertion2);
    @(posedge clk); sop=1; vld=1;
    @(posedge clk); sop=0;
    @(posedge clk);
    @(posedge clk); eop=1;
    @(posedge clk); eop=0; vld=0;
    repeat(2) @(posedge clk);
    $assertoff(0, tb.throughout_assertion2);
    {sop,vld,eop,pause} = '0;
    repeat(2) @(posedge clk);

    // FIRST_MATCH — gnt@0, ack@1, rdy@2 — first_match locks on cycle 1, rdy check at cycle 2 passes
    $asserton(0, tb.first_match_assertion);
    @(posedge clk); gnt=1;
    @(posedge clk); gnt=0; ack=1;
    @(posedge clk); ack=0; rdy=1;
    @(posedge clk); rdy=0;
    repeat(2) @(posedge clk);
    $assertoff(0, tb.first_match_assertion);
    {gnt,ack,rdy} = '0;
    repeat(2) @(posedge clk);

    // WITHIN pass — sop@0 busy=0, vld@1, drain@3, eop@4
    $asserton(0, tb.within_assertion);
    @(posedge clk); sop=1;
    @(posedge clk); sop=0; vld=1;
    @(posedge clk); vld=0;
    @(posedge clk); drain=1;
    @(posedge clk); drain=0; eop=1;
    @(posedge clk); eop=0;
    repeat(2) @(posedge clk);
    $assertoff(0, tb.within_assertion);
    {sop,vld,drain,eop,busy} = '0;
    repeat(2) @(posedge clk);

    // WITHIN fail — vld same cycle as sop, inner starts too early
    $asserton(0, tb.within_assertion);
    @(posedge clk); sop=1; vld=1;
    @(posedge clk); sop=0; vld=0;
    @(posedge clk); drain=1;
    @(posedge clk); drain=0;
    @(posedge clk); eop=1;
    @(posedge clk); eop=0;
    repeat(2) @(posedge clk);
    $assertoff(0, tb.within_assertion);
    {sop,vld,drain,eop,busy} = '0;
    repeat(2) @(posedge clk);

    // WITHIN fail — vld@3, drain needs cycle 5, outer closes at cycle 4
    $asserton(0, tb.within_assertion);
    @(posedge clk); sop=1;
    @(posedge clk); sop=0;
    @(posedge clk);
    @(posedge clk); vld=1;
    @(posedge clk); vld=0; eop=1;
    @(posedge clk); eop=0; drain=1;
    @(posedge clk); drain=0;
    repeat(2) @(posedge clk);
    $assertoff(0, tb.within_assertion);

    $finish;
  end

endmodule
