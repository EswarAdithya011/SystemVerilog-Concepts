module task2a;
  logic clk, a, b, c;
  logic reset, trigger;
  
  initial begin
    clk = 0;
    fork
      forever #5 clk = ~clk;
      #200 $finish;        
    join
  end
  
  // Inline Property 
  assert property (@(posedge clk) a |-> ##1 b ##1 c)
    else
      $error("Sequence Broke: Inline Assertion");
      
  // Named Property
  property abc_property;
    @(posedge clk) disable iff (reset)
    a |-> ##1 b ##1 c;
  endproperty
      
  assert property (abc_property)
    else
      $error("Sequence Broke: Named Property");

  // Sequences + Properties
  sequence s1;
    a ##1 b ##1 c;
  endsequence
    
  sequence s2;
    a ##1 b;
  endsequence
    
  property p1;
    @(posedge clk) disable iff (reset)
    trigger |-> s1 ##1 s2;
  endproperty
    
  assert property (p1)
    else
      $error("Sequence Broke: p1");
    
  initial begin
    reset = 1;
    trigger = 0;
    {a, b, c} = 0;        // 0ns
    @(posedge clk); #1;   // 6ns 
    a = 1;                // 6ns
    @(posedge clk); #1;   // 16ns
    a = 0; b = 1;         // 16ns
    @(posedge clk); #1;   // 26ns
    b = 0; c = 1;         // 26ns
    @(posedge clk); #1;   // 36ns
    c = 0;
    reset = 0;            // 36ns

    // PASS scenario abc_property
    @(posedge clk); #1;   // 46ns
    a = 1;                // 46ns
    @(posedge clk); #1;   // 56ns
    a = 0; b = 1;         // 56ns
    @(posedge clk); #1;   // 66ns
    b = 0; c = 1;         // 66ns — PASS
    @(posedge clk); #1;   // 76ns
    c = 0;                // 76ns

    // FAIL scenario abc_property
    @(posedge clk); #1;   // 86ns
    a = 1;                // 86ns
    @(posedge clk); #1;   // 96ns
    a = 0; b = 1;         // 96ns
    @(posedge clk); #1;   // 106ns
    b = 0; c = 0;         // 106ns — FAIL abc_property
    @(posedge clk); #1;   // 116ns

    // p1 scenario — trigger fires s1 then s2
    @(posedge clk); #1;   // 126ns
    trigger = 1;          // 126ns — p1 activates
    @(posedge clk); #1;   // 136ns
    trigger = 0; a = 1;   // 136ns — s1: a
    @(posedge clk); #1;   // 146ns
    a = 0; b = 1;         // 146ns — s1: b
    @(posedge clk); #1;   // 156ns
    b = 0; c = 1;         // 156ns — s1: c done
    @(posedge clk); #1;   // 166ns — ##1 gap
    c = 0; a = 1;         // 166ns — s2: a
    @(posedge clk); #1;   // 176ns
    a = 0; b = 1;         // 176ns — s2: b — PASS p1
    @(posedge clk); #1;   // 186ns
    b = 0;                // 186ns
  end
    
endmodule
