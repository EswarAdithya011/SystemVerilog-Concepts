class transaction;

  rand bit [7:0] addr;
  rand bit [3:0] data;
  rand bit       write;

  // Normal constraints
  constraint addr_range { addr inside {[10:50]}; }
  constraint data_even  { data % 2 == 0; }

  function void display(string tag);
    $display("[%s] addr=%0d data=%0d write=%0b",
              tag, addr, data, write);
  endfunction

endclass


module tb;

  transaction tx;

  initial begin

    tx = new();

    //--------------------------------------------------
    // 1) Normal randomization
    //--------------------------------------------------
    if (tx.randomize())
      tx.display("NORMAL");
    else
      $display("Randomization failed");

    //--------------------------------------------------
    // 2) Disable addr randomization
    //--------------------------------------------------
    tx.addr.rand_mode(0);     // addr won't change
    tx.addr = 25;             // legal value (within constraint)

    if (tx.randomize())
      tx.display("ADDR FIXED (LEGAL)");
    else
      $display("Randomization failed");

    //--------------------------------------------------
    // 3) Show rand_mode status
    //--------------------------------------------------
    $display("addr rand_mode = %0d", tx.addr.rand_mode());

    //--------------------------------------------------
    // 4) Force illegal value → randomization fails
    //--------------------------------------------------
    tx.addr = 100;   // violates addr_range constraint

    if (!tx.randomize())
      $display("Randomization FAILED due to constraint conflict");

    //--------------------------------------------------
    // 5) Re-enable addr randomization
    //--------------------------------------------------
    tx.addr.rand_mode(1);

    if (tx.randomize())
      tx.display("ADDR RE-ENABLED");

  end

endmodule
