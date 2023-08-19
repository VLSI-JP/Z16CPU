module Z16CPU(
  input  wire   i_clk,
  input  wire   i_rst,
  input  wire   i_button,
  output reg    [5:0]   o_led
);

  // Program Counter
  reg   [15:0]  r_pc;

  wire  [15:0]  w_instr;
  wire [3:0]    w_rd_addr;
  wire [3:0]    w_rs1_addr;
  wire [3:0]    w_rs2_addr;
  wire [15:0]   w_imm;
  wire          w_rd_wen;
  wire          w_mem_wen;
  wire [3:0]    w_alu_ctrl;
  wire [3:0]    w_opcode;

  wire [15:0]   w_rs1_data;
  wire [15:0]   w_rs2_data;
  wire [15:0]   w_rd_data;
  
  wire [15:0]   w_data_b;
  wire [15:0]   w_alu_data;

  wire [15:0]   w_mem_rdata;

  always @(posedge i_clk) begin
    if(i_rst) begin
      r_pc  <= 16'h0000;
    end else if(w_opcode == 4'hC) begin // JAL
      r_pc  <= w_alu_data;
    end else if(w_opcode == 4'hD) begin // JRL
      r_pc  <= r_pc + w_alu_data;
    end else if((w_opcode == 4'hE) && (w_rs2_data == w_rs1_data)) begin // BEQ
      r_pc  <= r_pc + w_imm;
    end else if((w_opcode == 4'hF) && (w_rs2_data > w_rs1_data)) begin // BLT
      r_pc  <= r_pc + w_imm;
    end else begin
      r_pc  <= r_pc + 16'h0002;
    end
  end

  Z16InstrMemory InstrMem(
    .i_addr     (r_pc   ),
    .o_instr    (w_instr)
  );

  Z16Decoder Decoder(
    .i_instr    (w_instr    ),
    .o_opcode   (w_opcode   ),
    .o_rd_addr  (w_rd_addr  ),
    .o_rs1_addr (w_rs1_addr ),
    .o_rs2_addr (w_rs2_addr ),
    .o_imm      (w_imm      ),
    .o_rd_wen   (w_rd_wen   ),
    .o_mem_wen  (w_mem_wen  ),
    .o_alu_ctrl (w_alu_ctrl )
  );

  assign w_rd_data = select_rd_data(w_opcode, i_button, w_mem_rdata, r_pc, w_alu_data);

  function [15:0] select_rd_data(
    input   [3:0]   i_opcode,
    input           i_button,
    input   [15:0]  i_mem_rdata,
    input   [15:0]  i_pc,
    input   [15:0]  i_alu_data
  );
  begin
    case(i_opcode)
      4'hA  : begin
        if(w_alu_data == 16'h007C) begin // MMIO Button
          select_rd_data    = {15'b000_0000_0000_0000, i_button};
        end else begin
          select_rd_data    = i_mem_rdata;
        end
      end 
      4'hC  : select_rd_data    = r_pc + 16'h0002;
      4'hD  : select_rd_data    = r_pc + 16'h0002;
      default : select_rd_data  = i_alu_data;
    endcase
  end
  endfunction

  Z16RegisterFile RegFile(
    .i_clk      (i_clk      ),
    .i_rs1_addr (w_rs1_addr ),
    .o_rs1_data (w_rs1_data ),
    .i_rs2_addr (w_rs2_addr ),
    .o_rs2_data (w_rs2_data ),
    .i_rd_data  (w_rd_data  ),
    .i_rd_addr  (w_rd_addr  ),
    .i_rd_wen   (w_rd_wen   )
  );

  assign w_data_b = (w_opcode <= 8'h8) ? w_rs2_data : w_imm;
  Z16ALU ALU(
    .i_data_a   (w_rs1_data ),
    .i_data_b   (w_data_b   ),
    .i_ctrl     (w_alu_ctrl ),
    .o_data     (w_alu_data )
  );

  Z16DataMemory DataMem(
    .i_clk  (i_clk      ),
    .i_addr (w_alu_data ),
    .i_wen  (w_mem_wen  ),
    .i_data (w_rs2_data ),
    .o_data (w_mem_rdata)
  );

  // MMIO
  always @(posedge i_clk) begin
    // LED
    if(i_rst) begin
      o_led <= 6'b000000;
    end else if(w_mem_wen && (w_alu_data == 16'h007A)) begin
      o_led <= w_rs2_data[5:0];
    end else begin
      o_led <= o_led;
    end
  end

endmodule
