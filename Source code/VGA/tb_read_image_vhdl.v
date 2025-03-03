`timescale 1ns/1ns

module tb_read_image_vhdl;

  // Read image in Verilog
  read_image_VHDL uut (
    .clock(clock),
    .data(data),
    .rdaddress(rdaddress),
    .wraddress(wraddress),
    .we(we),
    .re(re),
    .q(q)
  );

  // Inputs
  reg clock = 0;
  reg [7:0] data = 8'b00000000;
  reg [3:0] rdaddress = 4'b0000;
  reg [3:0] wraddress = 4'b0000;
  reg we = 0;
  reg re = 0;

  // Outputs
  wire [7:0] q;

  // Clock process definition
  always @(*) begin
    clock = 0;
    #5;
    clock = 1;
    #5;
  end
  integer i;
  // Stimulus process
  initial begin
    data <= 8'b00;
    rdaddress <= 4'b0000;
    wraddress <= 4'b0000;
    we <= 0;
    re <= 0;
    #100 re = 1;

    // Loop to iterate through addresses

    for (i = 0; i < 16; i = i + 1) begin
      rdaddress <= i;
      #20;
    end

    $stop;
  end

endmodule