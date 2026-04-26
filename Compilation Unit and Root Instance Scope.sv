// Compilation Unit Scope ($unit)
// Top-Level Instance Path ($root)

int value = 100; // In $unit

module sub;
    int signal = 42;
endmodule

module top;
    sub u_sub();
    int value = 5;

    initial begin
        #1;
        $display($unit::value);           // Prints 100
        $display(value);                  // Prints 5
        $display($root.top.u_sub.signal); // Prints 42
    end
endmodule
