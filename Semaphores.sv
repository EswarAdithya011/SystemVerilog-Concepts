module tb;
	semaphore smp;
  
  initial begin
    smp = new(5);
    
    fork
      process1(smp);
      process2(smp);
    join
  end
endmodule

task process1(semaphore smp);
  smp.get(3);
  $display("Process - 1 Started");
  #15;
  $display("Process - 1 Ended");
  //   smp.put(3); // As I am not returning the 3 keys process - 2 will never start because it requires keys = 3 but  available keys = 2. So process - 2 is blocked permanently
endtask

task process2(semaphore smp);
  smp.get(3);
  $display("Process - 2 Started");
  #20;
  $display("Process - 2 Ended");
  smp.put(3);
endtask

// module tb;
// 	semaphore smp;
//   	int a = 10;
//   	int b = 220;
  
//   // Both Synopsys VCS and Cadence Xcelium compilers are executing sequentially (from top to bottom) when there are 2 initial blk's  
//   initial begin
// 	smp = new(1);
//     smp.get;
//   	b = a;
//     smp.put;
    
//     $strobe(a, b); // Same with $display().
//   end
  
//   initial begin
//     smp.get;
//   	a = b;
//     smp.put;
//     $strobe(a, b);
//   end
  
  
  
// endmodule
