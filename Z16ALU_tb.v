module Z16ALU_tb;

  reg [15:0]    i_data_a;
  reg [15:0]    i_data_b;
  reg [3:0]     i_ctrl;
  wire [15:0]   o_data;

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, Z16ALU_tb);
  end

  Z16ALU ALU(
    .i_data_a   (i_data_a   ),
    .i_data_b   (i_data_b   ),
    .i_ctrl     (i_ctrl     ),
    .o_data     (o_data     )
  );

  initial begin
    i_data_a    = 16'h0004;
    i_data_b    = 16'h0008;
    i_ctrl      = 4'h0; // ADD
    #2
    i_ctrl      = 4'h1; // SUB
    #2
    i_ctrl      = 4'h2; // MUL
    #2
    i_ctrl      = 4'h3; // DIV
    #2
    i_ctrl      = 4'h4; // OR
    #2
    $finish;
  end

endmodule
