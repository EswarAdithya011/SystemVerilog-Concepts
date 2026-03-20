module tb;
//   real a;
//   int b;
  
  typedef enum {r, g, b} color;
  color tl;
  int c;
    
  initial begin
   
  	c = 4;
   // color = c; // ERROR
    
    tl = color'(c);	 // Static Casting
    $display("%s: %d", tl.name, tl);
    
    tl = 2;
    $display("%s: %d", tl.name, tl);
    
    if (!$cast(tl, c))
      $display("Casting Failed!!");
    
    c = 2;
    if ($cast(tl, c))
      $display("Casting Successful!!");

  end
  	
  
  initial begin
    // Implicit Conversion
//     a = 10.00;
//     b = a;
//     $display("b: %d", b);
    
//     a = b;
//     $display("a: %d", a);
    // Static Conversion
//     a = 10.0;
//     b = 4;
//     a = real'(b);
//     $display("a: %d", a);
  end


    
endmodule
