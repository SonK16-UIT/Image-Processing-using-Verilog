module read_image_Verilog (
  input clock,
  input [DATA_WIDTH-1:0] data,
  input [ADDR_WIDTH-1:0] rdaddress,
  input [ADDR_WIDTH-1:0] wraddress,
  input we,
  input re,
  output reg [DATA_WIDTH-1:0] q
);

parameter ADDR_WIDTH = 4;        
parameter DATA_WIDTH = 8;
parameter IMAGE_SIZE = 15;
parameter IMAGE_FILE_NAME = "IMAGE_FILE.MIF";

// Memory type definition
reg [DATA_WIDTH-1:0] ram_block [0:IMAGE_SIZE];
reg [ADDR_WIDTH-1:0] read_address_reg;

// Initialization
initial begin
  integer i;
  integer j;
  
  // Declare temp_mem as an array of reg
  reg [$clog2(DATA_WIDTH)-1:0] temp_mem [0:IMAGE_SIZE * DATA_WIDTH - 1];
  
  // Initialize memory from MIF file
  $readmemb(IMAGE_FILE_NAME, temp_mem);
  
  for (i = 0; i <= IMAGE_SIZE; i = i + 1) begin
    for (j = 0; j < DATA_WIDTH; j = j + 1) begin
      ram_block[i][j] = temp_mem[i * DATA_WIDTH + j];
    end
  end
end

// Read and write logic
always @(posedge clock) begin
  if (we) begin
    ram_block[wraddress] <= data;
  end
  if (re) begin
    q <= ram_block[rdaddress];
  end
end

endmodule