module Z16DataMemory(
  input  wire           i_clk,
  input  wire   [15:0]  i_addr,
  input  wire           i_wen,
  input  wire   [15:0]  i_data,
  output wire   [15:0]  o_data
);

  reg [15:0] mem[1023:0];

    // Load
  assign o_data = mem[i_addr[10:1]];

  always @(posedge i_clk) begin
    // Store
    if(i_wen) begin
      mem[i_addr[10:1]] <= i_data;
    end
  end

endmodule
