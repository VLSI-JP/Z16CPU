module Z16InstrMemory_tb;

  reg [15:0]    i_addr;
  wire [15:0]   o_instr;

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, Z16InstrMemory_tb);
  end

  Z16InstrMemory InstrMem(
    .i_addr (i_addr ),
    .o_instr(o_instr)
  );

  initial begin
    #2
    i_addr  = 16'h0000;
    #2
    i_addr  = 16'h0002;
    #2
    i_addr  = 16'h0004;
    #2
    i_addr  = 16'h0006;
    #2
    i_addr  = 16'h0008;
    #2
    i_addr  = 16'h000A;
    #2
    i_addr  = 16'h000C;
    #2
    $finish;
  end

endmodule
