module tb;
  typedef struct packed signed {
    // Only Packed Data Types are allowed
//  shortint a[3]; 
    shortint a; 
    byte b; 
    bit [7:0] c;
  } struct_s;
  
  struct_s s[2:0];
  
  initial begin
    s[0] = {a: 16'hABCD, b: -29, default: 20};
//     $display(s[0]); // Prints Entire array in decimal, So not recommended.
    $display("s[0].c = %0d", s[0].c);
    $display("s[0].b = %0p", s[0].b);
	// Size of struct is the Sum of sizes of all of variable declared inside that structure.
    $display("size of struct: %0d", s[0].size());    
  end
  
endmodule
