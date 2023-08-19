module Z16CPU_tb;

  reg i_clk = 1'b0;
  reg i_rst = 1'b0;
  reg i_button = 1'b0;
  wire [5:0] o_led;

  always #1 begin
    i_clk <= ~i_clk;
  end

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, Z16CPU_tb);
  end

  Z16CPU CPU(
    .i_clk      (i_clk      ),
    .i_rst      (i_rst      ),
    .i_button   (i_button   ),
    .o_led      (o_led      )
  );

  initial begin
    // リセット
    i_rst   = 1'b1;
    #2
    // リセットを落とし、実行開始
    i_rst   = 1'b0;
    #100
    // 100クロック後にボタンを押す
    i_button = 1'b1;
    #20
    // 20クロック後にボタンを離す
    i_button = 1'b0;
    #100
    $finish;
  end

endmodule
