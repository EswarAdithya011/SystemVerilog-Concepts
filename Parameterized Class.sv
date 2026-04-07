class para_class #(int size = 32, type T = string); // default size = 32 and default datatype is logic if not provided explicitly.
  T a[size];  // unpacked array (works for both bit and string cases)
  
endclass

module tb;
  // Passing the size and datatype 
  para_class #(8, bit) p1;
  para_class p2;

  initial begin
  	p1 = new;
    $display("size = %0d", $size(p1.a));
    
    p2 = new;
    $display("size = %0d", $size(p2.a));
    
    foreach (p1.a[i]) begin
      p1.a[i] = i*3;
    end
    
    foreach (p1.a[i]) begin
      $write("%0b", p1.a[i]);
    end
    $display;
    
    p2.a[0] = "default type is string";  
    $display("%s", p2.a[0]);
    
  end

endmodule
