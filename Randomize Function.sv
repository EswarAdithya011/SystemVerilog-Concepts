class sample;
 rand bit [1:0] num;
  
endclass

program test;
 sample s;
  
  initial begin
  	s = new;
    
    assert(std::randomize(s));
    $display(s.num);
  end
	
endprogram


// class packet;

//   rand bit [3:0] edho_okati;
//   randc bit [1:0] nik_enduku;
// //   constraint c_fail {
// //     edho_okati > 10;
// //     edho_okati < 5;
// //   }

// endclass


// module tb;

//   packet pkt;

//   initial begin
//     pkt = new;

//     assert (!pkt.randomize())
//       $display("Randomization FAILED");
//     else
//       $display("Randomization PASSED");
//   end
  
//   initial begin
//     $display("nik_enduku = %0d", pkt.nik_enduku);
//     $display("nik_enduku = %0d", pkt.edho_okati);
    
//   end

// endmodule
