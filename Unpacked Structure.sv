module tb;
  typedef struct {
  	int a;
    bit [5:0] x, y;
    real r;
    string s;
  } struct_s;
  
  struct {bit [7:0] r, g, b;} pixel;
  
  struct_s s[3:0];
  
  initial begin
    // Named Based Assignments. So need of Struct literal (') although I can give.
    s[0] = {x: 45, a: 32'd255,y: 32, r: 3.14, s: 				"Sample"};
    $display(s[0]);
	
    // Order Based Assignments
    pixel = '{21, 22, 23};
    $display(pixel);
    $display(pixel.g, pixel.b);
    
    
    // Data Type Based Assignments
    // Incomplete Assignments are not allowed so I gave defualt value as 0.
    s[1] = {int: 1, string: """Urikeyy..""", /*bit: 				101,*/ r: 69.69, default: 0};
    $display(s[1]);
    
    s[2] = {default: 0};
    $display(s[2]);
    // Size of the structure is the max size of all the variables that are declared inside of that structure. 
    // This works with packed structures I think.
//     $display("Size of Structure: %0d", s[0].size());
  
    
    // Copying strutures is allowed
    s[3] = s[0];
    $display(s[3]);
  end
endmodule
