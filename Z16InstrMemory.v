module Z16InstrMemory(
  input  wire           i_clk,
  input  wire   [15:0]  i_addr,
  output wire   [15:0]  o_instr
);

  wire [15:0] mem[14:0];

  assign o_instr = mem[i_addr[15:1]];

  assign mem[0] = 16'h0010; // ADD ZR ZR B1    // B1 <- 0
  assign mem[1] = 16'h0119; // ADDI 1 B1       // B1 <- B1 + 1
  assign mem[2] = 16'h0040; // ADD ZR ZR G0    // G0 <- 0
  assign mem[3] = 16'h7A49; // ADDI 122 G0     // G0 <- G0 + 122
  assign mem[4] = 16'h0050; // ADD ZR ZR G1    // G1 <- 0
  assign mem[5] = 16'h7C59; // ADDI 124 G1     // G1 <- G1 + 124
  assign mem[6] = 16'h0070; // ADD ZR ZR G3    // G3 <- 0
  assign mem[7] = 16'hF879; // ADDI -8 G3      // G3 <- -8
  assign mem[8] = 16'h0060; // ADD ZR ZR G2    // G2 <- 0
  assign mem[9] = 16'h0169; // ADDI 1 G2       // G2 <- G2 + 1
  assign mem[10] = 16'h640B; // STORE G2 G0 0   // [LED] <- G2
  assign mem[11] = 16'h052A; // LOAD 0 G1 B2    // B2 <- [Button]
  assign mem[12] = 16'h046E; // BEQ B1 B2 4     // if B1 == B2, then PC <- PC + 4
  assign mem[13] = 16'h070D; // JRL 0 G3 ZR     // PC <- PC + G3
  assign mem[14] = 16'h00FD; // JRL 0 ZR G11    // STOP

endmodule
