module tb;
  process p_a, p_b, p_c;
  
  initial begin
  	fork: Work
    	begin
          p_a = process::self();
          $display("[%0t] Worker A Started", $time);
          #15;
          $display("[%0t] Worker A Completed", $time);
        end
      
      	begin
          p_b = process::self();
          $display("[%0t] Worker B Started", $time);
          #35;
          $display("[%0t] Worker B Completed", $time);
        end
      
        begin
          p_c = process::self();
          $display("[%0t] Worker C Started", $time);
          #50;
          $display("[%0t] Worker C Completed", $time);
        end
    join_any
    
    $display("Worker B and C are suspending");
    p_b.suspend();
    p_c.suspend();
    
    #10;
    
    $display("Worker B and C are Resuming");
    p_b.resume();
    p_c.resume();
    
    #5;
    
    $display("Worker B is going to be killed");
    p_b.kill();
    
    fork
      p_b.await();
//       p_c.await();
    join
    
     $display("All workers done");
   	 $finish;
  end
endmodule


// module tb;
//   logic clk = 0;
//   logic a = 0, b = 0;
  
//   initial begin
//   	fork
//       begin: clk_generator
//       	forever #5 clk = ~clk;
//       end
      
//       begin: stimulus
//         	a = 0; b = 0;
//         #10 a = 1; b = 0;
//         #10 a = 1; b = 1;
//         #10 a = 0; b = 1;
//         #10;
//         disable clk_generator; // If i don't disable wait fork will never exits
//         disable monitor; // In the same fashion monitor continuosly monitors value so i never ends so need to disable to get "SIm Done" Message.
//       end
      
//       begin: monitor
//         forever begin
//           @(posedge clk);
//           	$display("[%0t] clk=%0b a=%0b b=%0b", $time, clk, a, b);
//         end
//       end
    
//     join_none
    
//     // As fork-join_none will not block parent process here we are waiting till all threads to be completed
//     wait fork;
//     $display("Simulation Done!!!");
      
//     $finish;
//   end
// endmodule
