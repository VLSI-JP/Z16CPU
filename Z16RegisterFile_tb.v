module Z16RegisterFile_tb;
  
  reg i_clk = 1'b0;

  reg [3:0]     i_rs1_addr;
  reg [3:0]     i_rs2_addr;
  reg [3:0]     i_rd_addr;
  reg           i_rd_wen;
  reg [15:0]    i_rd_data;
  wire [15:0]   o_rs1_data;
  wire [15:0]   o_rs2_data;

  always #1 begin
    i_clk <= ~i_clk;
  end
  
  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, Z16RegisterFile_tb);
  end

  Z16RegisterFile Regfile(
    .i_clk      (i_clk      ),
    .i_rs1_addr (i_rs1_addr ),
    .i_rs2_addr (i_rs2_addr ),
    .i_rd_addr  (i_rd_addr  ),
    .i_rd_wen   (i_rd_wen   ),
    .i_rd_data  (i_rd_data  ),
    .o_rs1_data (o_rs1_data ),
    .o_rs2_data (o_rs2_data )
  );

  initial begin
    i_rd_wen = 1'b0;
    i_rs1_addr  = 4'h0;
    i_rs2_addr  = 4'h0;
    #2
    // 値を書き込み
    i_rd_wen = 1'b1;
    i_rd_addr = 4'hA;
    i_rd_data = 16'h5555;
    #2
    i_rd_wen = 1'b0;
    #2
    // RS1から値を読み出し
    i_rs1_addr  = 4'hA;
    #2
    // RS2から値を読み出し
    i_rs2_addr  = 4'hA;
    #2
    $finish;
  end

endmodule
