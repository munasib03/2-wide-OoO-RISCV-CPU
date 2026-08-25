// memory.sv

module memory #(
  parameter WORDS = 64
) (
  input logic clk,
  input logic [31:0] address,
  input logic [31:0] write_data,
  input logic wr_en,
  input logic rst_n

  output logic [31:0] read_data
);

  logic [31:0] mem [0:WORDS-1];

  // Write logic
  always_ff(@posedge clk) begin
    if (!rst_n) begin
      for (int i = 0; i < WORDS; i++) begin
        mem[i] <= 31'b0;
      end
    end
    else if (wr_en) begin
      if (address[1:0] == 2'b00) begin
        mem[address[31:0]] <= write_data;
      end
    end
  end

  // Read logic
  always_comb begin
    read_data = mem[address[31:2]];
  end

endmodule
