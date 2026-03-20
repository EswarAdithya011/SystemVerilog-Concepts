class rectangle;
local int l, b;
  
  extern function new(int x, int y);
  extern function void display();
    
  extern static function void stat_method();
  extern static function void stat_method2();
    
    	
endclass
    
    
function rectangle::new(int x, int y);
	l = x;
  	b = y;
endfunction
    
function void rectangle::display();
  $display("l = %0d, b = %0d", l, b);    	
endfunction
      
function void rectangle::stat_method();
	int i;
	i++;
  $display("i = %0d", i);  
endfunction
    
function void rectangle::stat_method2();
	static int j;
	j++;
  $display("j = %0d", j);  
endfunction
    
module tb;
	rectangle r;
  initial begin
    r = new(10 , 20);
    r.display();
    r.display();
    r.display();
    r.display();
//     rectangle::stat_method();
    r.stat_method();
    r.stat_method();
    r.stat_method();
    r.stat_method();
    
     r.stat_method2();
    r.stat_method2();
    r.stat_method2();
    
  end
  
endmodule
