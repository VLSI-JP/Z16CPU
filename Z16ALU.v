module Z16ALU(
  input  wire   [15:0]  i_data_a,
  input  wire   [15:0]  i_data_b,
  input  wire   [3:0]   i_ctrl,
  output wire   [15:0]  o_data
);

  assign o_data = alu(i_data_a, i_data_b, i_ctrl);

  function [15:0] alu(
    input [15:0]    i_data_a,
    input [15:0]    i_data_b,
    input [3:0]     i_ctrl
  );
    begin
      case(i_ctrl)
        4'h0 : alu  = i_data_b + i_data_a;
        4'h1 : alu  = i_data_b - i_data_a;
        4'h2 : alu  = i_data_b * i_data_a;
        4'h3 : alu  = i_data_b / i_data_a;
        4'h4 : alu  = i_data_b | i_data_a;
        4'h5 : alu  = i_data_b & i_data_a;
        4'h6 : alu  = i_data_b ^ i_data_a;
        4'h7 : alu  = i_data_a << i_data_a;
        4'h8 : alu  = i_data_a >> i_data_a;
        default: alu = i_data_b + i_data_a;
      endcase
    end
  endfunction

endmodule
