module tb;
       // PACKED + UNPACKED ARRAYS

  
//   bit [3:0][7:0] mem[4];
// Q3
// Randomize only packed portion using foreach.
//   initial begin
//     foreach (mem[anything]) begin
//       mem[anything] = $urandom;  
//     end

//     foreach (mem[i])
//       $display("mem[%0d] = %0b", i, mem[i]);
//   end
  
  
//   Q2
// Initialize entire unpacked memory to zero using loop.
//   initial begin
//     for (int i = 0; i < $size(mem); i = i + 1) begin
//       mem[i] = 'b0;
//       $display("mem[%0d] = %0d", i, mem[i]);
//     end
    
//   end
   
//  Q1 
//   Declare bit [3:0][7:0] mem[4].
//     Access:

//     mem[2]

//     mem[2][1]

//     mem[2][1][3]

//     Explain what each returns.
  
//   initial begin
//     mem[0] = 32'hAAAA_ABAB;
//     mem[1] = 32'hAAAB_CCDD;
//     mem[2] = 32'hAAAC_AEAF;
//     mem[3] = 32'hAAAD_ABAB;
    
//     $display("mem[2] = %0h", mem[2]);
//     $display("mem[2][1] = %0h", mem[2][1]);
//     $display("mem[2][1][3] = %0b", mem[2][1][3]);
    
    
//   end

  
  
  
  
  
  
  
  
  // UNPACKED ARRAYS

//   int arr[10];
//   bit [7:0] mem [8];
//   int mat[4][4], mat2[4][4];
//   bit isEqual;
  
  
// Q5
// Compare two arrays and print if equal.
//   initial begin
//   			mat = '{'{1, 2, 2, 4}, 
//                      '{5, 5, 5, 5}, 
//                      '{4, 6, 7, 9}, 
//                      '{5, 8, 8, 0}};
  
//   mat2 = '{'{1, 2, 2, 4}, 
//                      '{5, 5, 5, 5}, 
//                      '{4, 6, 7, 9}, 
//                      '{5, 8, 8, 0}};
  
//     isEqual = 1;
    
//     for (int i = 0; i < $size(mat); i = i + 1) begin
//       for (int j = 0; j < $size(mat2[i]); j = j + 1) begin
//         if (mat[i][j] != mat2[i][j])
//           isEqual = 0;
//       end
//     end
//     $display(isEqual);
//   end
  
  //   Q3
// Create 4x4 matrix int mat[4][4].
// Fill diagonal = 1, others = 0.
//   initial begin
//     $display($size(mat));
//     for (int i = 0; i < $size(mat); i = i + 1) begin
//       for (int j = 0; j < $size(mat[i]); j = j + 1) begin
//         if (i == j) begin
//           	mat[i][j] = 1;
//           $display("mat[%0d][%0d] = %0b", i, j, mat[i][j]);
//         end
//         else begin
//           mat[i][j] = 0;
//         end
//       end
//     end
    
//   end
  
  
  
  //   Q2
// Declare bit [7:0] mem[8].
// Initialize even locations = 8'hAA
// Odd locations = 8'h55
  
  
//   initial begin 
//       for (int i = 0; i < 8; i = i + 1) begin
//         if (i % 2 == 0) begin
//           mem[i] = 8'hAA;
//           $display("mem[%0d] = %0d", i, mem[i]);
//         end
//         else begin
//            mem[i] = 8'h55;
//           $display("mem[%0d] = %0d", i, mem[i]);
//         end
//       end
      
//   end
  
  
  
  
  
  

  
//   Declare int arr[10].
// Initialize each element = index * 3.
  
//   initial begin
//     for (int i = 0; i < 10; i=i+1) begin
//       arr[i] = i * 3;
//       $display("arr[%0d] = %0d", i, arr[i]);
//     end
//   end
  
  
  
  
  
  
  
  
  
//    bit [15:0] data;
//   bit [3:0][7:0] arr;
//   bit [7:0] a;
//   bit [3:0] b;
//   bit [15:0] rev;
//   bit [1:0][3:0][7:0] cube;
//   bit [7:0]x;
  
  // PACKED ARRAYS
  
//   Show arithmetic working:
// Add 8'd10 to bit [3:0][7:0] A.
//   initial begin
//     arr[0] = 8'h0;
//     x = 8'd10 + arr[0];
//     $strobe("x = %0d", x);
//   end
  
//   initial begin
//     cube = 64'hABCD_EFABC_AACB_BBDD;
    
//     $display("First Element = %0b, Third 8-bit element inside it = %0b, Bit 5 of that element = %0b", cube[1], cube[1][3], cube[1][3][5]);
    
//   end
//   initial begin
//   	data = 16'hABCD;
//   	arr = 32'hAABBCCDD;
//     a = 8'b11010110;
//     b = a[6:3];
  
//     rev = {<<{data}};
    
//     $display("MSB = %0h || LSB = %0h", data[15:8], data[7:0]);
//     $display("Pack-1 = %0h || Pack-2 = %0h, Pack-3 = %0h, Pack-4 = %0h", arr[3], arr[2], arr[1], arr[0]);
//     $display("a = %0b, b(a[6:3]) = %0b", a, b);
    
//     $display("Original = %0b", data);
//     $display("Reversed = %0b", rev);
//     $display(data.size());
    
//   end
endmodule
