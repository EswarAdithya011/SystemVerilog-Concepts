module tb;
  // I will use 'tagged' for typesafe. typesafe = It will throw error when active member and accessing memebr are different. It will internally store the active member with a tag. 
  
  typedef union /*tagged*/{
  	shortreal r;
    longint i;
    byte bytee;
//     string s; Dynamic Type can't be used in Union as they are static. 
    

    bit [3:0] b;
  }union_sample;
  
  union_sample u[3:0];
  initial begin
    u[0].r = 171.205;
    u[0].i = 67676;
    $display("%f", u[0].i); // This is legal but don't know why not working here
  end
endmodule
