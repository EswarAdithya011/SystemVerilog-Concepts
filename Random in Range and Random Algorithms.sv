module tb;
  bit [7:0] result;
  	int max = 0, min = 200; // Range of No's
  
  initial begin
    result = min + {$random} % (max - min + 1); // +ve Range
    $display("+ve Range: %0d", result);
    result = -min - {$random} % (max - min + 1); // -ve Range
    $display("-ve Range: %0d", result);

    result = -min + {$random} % (max + min + 1); // Mix Range
    $display("Mix Range: %0d", result);

  end
endmodule



// module tb;
// 	int a;
//   initial begin
//     repeat(30) begin 
//     a = $random; // 32-bit signed random no
//       $display("32-bit signed random no: %0d", a);
//     #2;
//       $display("-----------------------");
//     a = $urandom(); // 32-bit un-signed random no
//       $display("32-bit un-signed random no: %0d", a);
//     #2;
//        $display("-----------------------");     

//     a = $urandom_range(100, 0); // // 32-bit signed random no whose range is 0(min) to 100(max).
//       $display("Unsigned Range(0 to 100): %0d", a);
//     #2;
//       $display("-----------------------");
//     a = $random % 20; // -19 to +19
//       $display("-19 to +19: %0d", a);
//     #2;
//       $display("-----------------------");
//     a = {$random} % 15; // 0 to 14
//       $display("0 to 14: %0d", a);
//     #2;
//       $display("-----------------------");
//     a = $unsigned($random) % 15;
//       $display("0 to 14: %0d", a);
//       $display("-----------------------");
//       a = 20 + {$random()} % 6; // 20 to 25
//       $display("20 to 25: %0d", a);
//       $display("-----------------------");
//     a = -5 - {$random()} % 6; // -5 to -10
//       $display("-5 to -10: %0d", a);
// 	  $display("-----------------------");
//     a = -10 + {$random()} % 12; // -10 to 2
//       $display("-10 to 2: %0d", a);  
//     end
    
//     end
// endmodule
