module tb;
  int array[9] = '{4, 7, 2, 5, 7, 1, 6, 3, 1};
  int res[$];
  
  initial begin   
    res = array.min();
    $display ("min          : %p", res);
    
    res = array.max();
    $display ("max          : %p", res);
    
    res = array.unique();
    $display ("unique       : %p", res);
    
    res = array.unique(x) with (x < 3);
    $display ("unique       : %p", res);
    
    res = array.unique_index;
    $display ("unique_index : %p", res);
  end
endmodule



/*
Simulation Log:
---------------

ncsim> run
min          : '{1}
max          : '{7}
unique       : '{4, 7, 2, 5, 1, 6, 3}
unique       : '{4, 2}
unique_index : '{0, 1, 2, 3, 5, 6, 7}
ncsim: *W,RNQUIE: Simulation is complete.
ncsim> exit
*/
