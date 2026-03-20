module string_conversion_tb;

  string s_dec  = "255";
  string s_hex  = "1A";
  string s_oct  = "17";
  string s_bin  = "1010";
  string s_real = "12.75";

  string out;
  int    i_val;
  real   r_val;

  initial begin

    // STRING → NUMBER

    i_val = s_dec.atoi();
    $display("atoi  ('%s')  = %0d", s_dec, i_val);

    i_val = s_hex.atohex();
    $display("atohex('%s')  = %0h", s_hex, i_val);

    i_val = s_oct.atooct();
    $display("atooct('%s')  = %0O", s_oct, i_val);

    i_val = s_bin.atobin();
    $display("atobin('%s')  = %0b", s_bin, i_val);

    r_val = s_real.atoreal();
    $display("atoreal('%s') = %f", s_real, r_val);


    // --------------------------
    // NUMBER → STRING
    // --------------------------

    out.itoa(255);
    $display("itoa(255)     = %s", out);

    out.hextoa(26);
    $display("hextoa(26)    = %s", out);

    out.octtoa(15);
    $display("octtoa(15)    = %s", out);

    out.bintoa(10);
    $display("bintoa(10)    = %s", out);

    out.realtoa(3.14);
    $display("realtoa(3.14) = %s", out);

  end

endmodule
