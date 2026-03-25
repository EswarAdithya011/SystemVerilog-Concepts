module tb;
    // CPU Pipeline Handshaking (4 stages)
    event fetch;
    event decode;
    event execute;
    event writeback;
    event any_stage; // Same as any_stage = null;

     event optional_log;

    // Fetch Stage
    initial begin
        $display($time, "Fetch Stage Started");
        #20;
        // ->fetch; // Triggers at active region
        ->>fetch; // Triggers at NBA Region to avoid race conditon.
        $display($time, "Fetch Stage Done");
    end

    // Decode Stage
    initial begin
        #20;
        // Now race won't happen as we are triggering using ->> instead of ->
        @(fetch);
        $display($time, "Decode Stage Started");
        #15;
        ->decode;
        $display($time, "Decode Stage Done");
    end

    // Execute Stage
    initial begin
        wait (decode.triggered);
        $display($time, "Execute Stage Started");
        #10;
        ->execute;
        $display($time, "Execute Stage Done");
    end

    // writeback Stage
    initial begin
        @(execute);
        $display($time, "Writeback Stage Started");
        #5;
        ->writeback;
        $display($time, "Writeback Stage Done");
    end

    //  RACE CONDITION HANDLING.
    initial begin
        #20;
        // @(fetch);  // this would MISS event as fetch is triggering event at @30ns not 35ns.
        wait(fetch.triggered); // correct way. This will present at all delta cycles of current time stamp. 
        $display("%0t Race-safe fetch detected", $time);
    end
    
    // Checking Pipeline Order
    initial begin
    wait_order(fetch, decode, execute, writeback)
    else begin
        $display("ERROR: Pipeline stages are out of order!");
        $finish;
    end
    $display("PASS: All stages are in correct order.");
end
    // Passing Event to Task 
    // Using automatic for separate memory for 4 task calls to avoid memory overlapping..
    task automatic stage_monitor(ref event e, input string name);
        @(e);
        $display("[%0t] Stage %s completed", $time, name);
    endtask

    initial begin
        fork
        stage_monitor(fetch, "FETCH");
        stage_monitor(decode, "DECODE");
        stage_monitor(execute, "EXECUTE");
        stage_monitor(writeback, "WRITEBACK");
    join
    end

    //  EVENT ALIAS 
    initial begin
      #20;
        any_stage = fetch; // Both point to fetch refernce only.

        @(any_stage);
        $display("%0t Any stage triggered (alias working)", $time);
    end

    // This is a null event.
    initial begin : NULL
    if (optional_log != null)
      -> optional_log;
    else
      $display("[%0t] optional_log is null", $time);
  end
endmodule
