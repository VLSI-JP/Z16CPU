module Z16DataMemory_tb;

  reg i_clk = 1'b0;
  reg [15:0]    i_addr;
  reg           i_wen;
  reg [15:0]    i_data;
  wire [15:0]   o_data;

  always #1 begin
    i_clk <= ~i_clk;
  end

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, Z16DataMemory_tb);
  end

  Z16DataMemory DataMem(
    .i_clk  (i_clk  ),
    .i_addr (i_addr ),
    .i_wen  (i_wen  ),
    .i_data (i_data ),
    .o_data (o_data )
  );

  initial begin
    i_wen   = 1'b0;
    #3
    // データ書き込み
    i_wen   = 1'b1;
    i_addr  = 16'h8fff;
    i_data  = 16'h5555;
    #2
    i_wen   = 1'b0;
    #2
    // データ読み出し
    i_addr  = 16'h8fff;
    #2
    i_addr  = 16'h0fff;
    #2
    #2
    $finish;
  end

endmodule
