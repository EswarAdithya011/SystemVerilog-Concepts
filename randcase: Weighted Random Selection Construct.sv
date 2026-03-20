module tb;
	int seed = 9;
  int rand_value;
  
  initial begin
    repeat(10) begin
      // Only one branch selected at a time randomly based on weights of the branches.
      randcase
        0: rand_value = $random(seed); // As weight is 0 It never executes.
        2: rand_value = $urandom();
      	4: rand_value = $urandom_range(30, 40);
      	4: rand_value = $urandom_range(50, 50);
      endcase
      
      $display("[%0t] rand_value = %0d", $time, rand_value);
    end
  end
endmodule
