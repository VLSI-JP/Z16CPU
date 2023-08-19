module Z16CPU_wrapper(
  input  wire   i_clk,
  input  wire   i_rst,
  input  wire   i_button,
  output wire   [5:0]   o_led
);

  wire w_rst;
  wire w_button;
  wire [5:0] w_led;
  reg [31:0] r_counter = 32'h00000000;
  reg r_clk = 1'b0;

  always @(posedge i_clk) begin
    if(r_counter == 32'd1350000) begin
      r_counter <= 32'h00000000;
      r_clk     <= ~r_clk;
    end else begin
      r_counter <= r_counter + 32'h00000001;
      r_clk     <= r_clk;
    end
  end

  assign w_rst = ~i_rst;
  assign w_button = ~i_button;
  assign o_led = ~w_led;

  Z16CPU CPU(
    .i_clk      (r_clk      ),
    .i_rst      (w_rst      ),
    .i_button   (w_button   ),
    .o_led      (w_led      )
  );

endmodule
