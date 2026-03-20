module tb;
	
  initial begin
  	// This Construct is used to generate random sequences of actions based on a grammar-like structure.. It is a Random Control-flow generator with our defined rules.
    // The randomize() ---> Used to control the data
    // The randsequence ---> Used to control data-flow. (Randomly it will choose the flow based on our flow).
    
//     A production is a rule that defines how a symbol expands.
      // General form:
      // symbol : expansion;
    
//     A production list is when a symbol has multiple possible expansions.
//     A production item is a single element inside a production list.
//     Breakdown:

      // Production → main : A B | C
      // Production list → A B | C
      // Production items → A, B, C
//     repeat(4) begin
//       randsequence(main)
//         main: A B C:= 5| C A B:=3 | A A B:=2;

//         A: {
//           $display("A");
//         };

//         B: {
//           $display("B");
//         };

//         C: {
//           $display("C");
//         };
//       endsequence
//       $display("--------------");
//     end
    int case_count;
    
    repeat(9) begin
      $display("-------------Case - %0d---------------", ++case_count);
      
      randsequence(transaction)
          transaction: header payload footer; 
          // HEADER
          header: start_frame;

          start_frame : { $display("START FRAME"); };

          // PAYLOAD
          payload: write_op:= 4 | read_op:= 4 | error_op:= 4;

          write_op: waddr data;
          read_op:  raddr data;
          error_op: error;

          waddr: {$display("WRITE ADDR");};
          raddr: {$display("READ ADDR");};
          data:  {$display("DATA");};
          error: {$display("ERROR PACKET");}; 

          // FOOTER
          footer: end_frame;

          end_frame: {$display("END FRAME");};
      endsequence
    end
  end
  
endmodule
