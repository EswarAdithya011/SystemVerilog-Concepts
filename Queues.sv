// Code your testbench here
// or browse Examples
module tb;
  int q[$];
  int k;
  
  initial begin
    q = {1, 2, 3};
    
    // Checking the size of the queue
    $display("Size of the Queue: %0d", q.size());
    
    // Pushing elements from the front
    q.push_front(0);
    $display("Size of the Queue: %0d", q.size());
    $display("Update-1 of Queue: %p", q);
    
    q.push_front(9);
    $display("Size of the Queue: %0d", q.size());
    $display("Update-2 of Queue: %p", q);
    
    // Inserting at specfic position
    q.insert(3, 69);
    $display("Size of the Queue: %0d", q.size());
    $display("Update-3 of Queue: %p", q); 
    
    // Printing value at specific position
    $display("Value at @3rd Index of Queue: %0d", q[3]); 
    
    // Popping and storing in a temp. variable
    k = q.pop_front();
    $display("Element popped from the Queue = %0d", k);
    $display("Size of the Queue: %0d", q.size());
    $display("Update-4 of Queue: %p",  q); 
    
    k = q.pop_front();
    $display("Element popped from the Queue = %0d", k);
    $display("Size of the Queue: %0d", q.size());
    $display("Update-5 of Queue: %p",  q); 
    
    // Deleting the element at @2nd Position
    q.delete(2);
    $display("Size of the Queue: %0d", q.size());
    $display("Update-6 of Queue (After Deletion): %p", q);
    
    // Deleting the entire queue
    q.delete();
    $display("Size of the Queue: %0d", q.size());
    $display("Update-7 of Queue (After Queue Removal): %p", q);
    
  end
endmodule
