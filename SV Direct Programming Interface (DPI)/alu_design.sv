module alu_design(output int result, 
           input int a, b, opcode);
  
  always_comb begin
    case(opcode)
    	0: result =  a + b;
      	1: result =  a - b;
      	2: result =  a * b;
      	3: result =  a / b;
      	4: result =  a % b;
      	default: result = 0;
    endcase
  end

endmodule
