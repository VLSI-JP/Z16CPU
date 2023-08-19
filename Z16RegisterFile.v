module Z16RegisterFile(
  input  wire           i_clk,
  input  wire   [3:0]   i_rs1_addr,
  input  wire   [3:0]   i_rs2_addr,
  input  wire   [3:0]   i_rd_addr,
  input  wire           i_rd_wen,
  input  wire   [15:0]  i_rd_data,
  output wire   [15:0]  o_rs1_data,
  output wire   [15:0]  o_rs2_data
);

  // レジスタファイル本体
  reg [15:0] mem[15:0];

  // Read
  // アドレスが0なら0を出力
  assign o_rs1_data = (i_rs1_addr == 4'h0) ? 16'h0000 : mem[i_rs1_addr];
  assign o_rs2_data = (i_rs2_addr == 4'h0) ? 16'h0000 : mem[i_rs2_addr];

  // Write
  always @(posedge i_clk) begin
    if(i_rd_wen) begin
      mem[i_rd_addr]  <= i_rd_data;
    end else begin
      mem[i_rd_addr]  <= mem[i_rd_addr];
    end
  end
endmodule
