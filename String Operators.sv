// module tb;
//   string firstname = "Joey";
//   string lastname  = "Tribbiani";

//   initial begin
//     // String Equality : Check if firstname equals or not equals lastname
//     if (firstname == lastname)
//       $display ("firstname=%s is EQUAL to lastname=%s", firstname, lastname);

//     if (firstname != lastname)
//       $display ("firstname=%s is NOT EQUAL to lastname=%s", firstname, lastname);

//     // String comparison : Check if length of firstname < length of lastname
//     if (firstname < lastname)
//       $display ("firstname=%s is LESS THAN lastname=%s", firstname, lastname);

//     // String comparison : Check if length of firstname > length of lastname
//     if (firstname > lastname)
//       $display ("firstname=%s is GREATER THAN lastname=%s", firstname, lastname);

//     // String concatenation : Join first and last names into a single string
//     $display ("Full Name = %s", {firstname, " ", lastname});

//     // String Replication
//     $display ("%s", {3{firstname}});

//     // String Indexing : Get the ASCII character at index number 2 of both first and last names
//     $display ("firstname[2]=%s lastname[2]=%s", firstname[2], lastname[2]);

//   end
// endmodule



// module tb;
//  string arr = "Eswar";
//  string orr = "Adithya";
  
//   initial begin
//     if (arr == orr)
//       $display("");
//   end
  
//   initial $display("%0s", arr[0]);
  
//   initial begin
//     foreach(arr[ar]) begin
//       $write("%s ", arr[ar]);
//     end
//   end


// endmodule
