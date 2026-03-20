module string_methods_tb;

  string str = "HelloWorld";
  string str2 = "helloworld";
  string tmp;
  int cmp_result;
  byte ch;

  initial begin

    // len()
    $display("len = %0d", str.len());

    // putc()
    tmp = str;
    tmp.putc(0, "h");
    $display("after putc = %s", tmp);

    // getc()
    ch = str.getc(1);
    $display("getc(1) = %s  ASCII=%0d", ch, ch);

    // tolower()
    $display("tolower = %s", str.tolower());

    // compare()
    cmp_result = str.compare(str2);
    $display("compare = %0d", cmp_result);
    
    cmp_result = str.tolower().compare(str2);
    $display("compare = %0d", cmp_result);

    // icompare()
    cmp_result = str.icompare(str2);
    $display("icompare = %0d", cmp_result);

    // substr()
    $display("substr(2,6) = %s", str.substr(2,6));

  end

endmodule
