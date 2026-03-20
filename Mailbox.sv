class transaction;
  randc bit [7:0] data;
  
  constraint c_range {
    	data inside {[0:255]};
  }
  
  function void display();
    $display("data = %0h", data);
  endfunction
endclass

module tb;
  mailbox #(transaction) mb;  // Parameterized Mailbox of type 'transaction class'. It can accepts only transaction handles message only. This is done to avoid Mismatch errors
  transaction tr;
  
  task generator();
    int gen_count = 0;
    repeat(3) begin
      tr = new();
      // std::randomize(): Used to randomize local variables or when not using a class-based randomize method, offering 		   high random stability.
  // 	Ex:  	std::randomize(var) with {var > 0;};
      assert(std::randomize(tr)); // assert(tr.randomize()); // Both ways are correct
      gen_count++;
      mb.put(tr); // This will generate 3 $errors If commented.
      $display("Generated and Sent: Count = %0d || Packet Value = %0p @ %0tns", gen_count, tr, $time);
    end
  endtask
  
  task driver();
    int driv_count = 0;
    repeat(3) begin
      if (mb.try_get(tr)) begin
      	driv_count++;
        $display("Received: Count = %0d @ %0tns", driv_count, $time);
        tr.display();
      end
      else
        $error("Packed Failed to Receive @ %0tns", $time);
    end
  endtask
  
  initial begin
    mb = new(); // Unbounded Mailbox
    
    fork
      generator();
      driver();
    join
  end
endmodule


// module tb;
//   mailbox mb;
  
//   initial begin
//     mb = new(5);
//     fork
//       producer(mb);
//       consumer(mb);
//     join_none
//   end
// endmodule

// task producer(mailbox mb_producer);
//   for (int i = 0; i < 5; i++) begin
//     bit [7:0] rand_no;
//     rand_no = $urandom_range(0,255);;
//     mb_producer.put(rand_no);
//     $display("Produced: %0d at time %0t", rand_no, $time);
//     #5;
//   end
// endtask

// task consumer(mailbox mb_consumer);
//   bit [7:0] data;
//   repeat(5) begin
//     mb_consumer.get(data);
//     $display("Consumed: %0d at time %0t", data, $time);
//     #10;
//   end
// endtask

