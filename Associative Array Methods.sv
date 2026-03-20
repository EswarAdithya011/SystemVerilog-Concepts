module tb;
  string array[int];
  int idx;
  initial begin
    array = '{1: "Korrapolu",
              3: "Eswar",
              2: "Adithya"};
    $display(array.exists(2));
    $display(array.size());
    
    if (array.first(idx))
      $display("first key = %0d", idx);

    if (array.last(idx))
      $display("last key = %0d", idx);

    idx = 1;
    if (array.next(idx))
      $display("next after 1 = %0d", idx);

    idx = 2;
    if (array.prev(idx))
      $display("prev before 2 = %0d %0p", idx, array[3]);
    
// 	$display(array);

    
  end
endmodule
