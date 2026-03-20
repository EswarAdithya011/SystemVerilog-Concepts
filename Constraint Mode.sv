class packet;

  rand int length;
  rand int addr;

  // Short packet
  constraint c_short {
    length inside {[1:32]};
  }

  // Long packet
  constraint c_long {
    length inside {[1000:1023]};
  }

  // Address constraint
  constraint c_addr {
    addr inside {[10:20]};
  }

  function void display(string tag);
    $display("[%s] length=%0d addr=%0d", tag, length, addr);
  endfunction

endclass



module tb;

  packet p;

  initial begin
    p = new;

    // Fix conflict FIRST
    p.c_long.constraint_mode(0);

    assert(p.randomize());
    p.display("INITIAL (SHORT ACTIVE)");

    // Enable long, disable short
    p.c_short.constraint_mode(0);
    p.c_long.constraint_mode(1);

    assert(p.randomize());
    p.display("LONG ACTIVE");

    // Disable all
    p.constraint_mode(0);

    assert(p.randomize());
    p.display("ALL OFF");

    // Enable only short
    p.constraint_mode(0);
    p.c_short.constraint_mode(1);

    assert(p.randomize());
    p.display("ONLY SHORT");

    // Enable addr also
    p.c_addr.constraint_mode(1);

    assert(p.randomize());
    p.display("SHORT + ADDR");

    // Restore carefully (avoid conflict!)
    p.c_long.constraint_mode(1);
    p.c_short.constraint_mode(0);

    assert(p.randomize());
    p.display("RESTORED (LONG ONLY)");
  end
endmodule
