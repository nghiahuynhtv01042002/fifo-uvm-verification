interface fifo_if #(parameter WIDTH = 8);
	logic wr_en;
	logic rd_en;
	logic clk;
	logic rst;
	logic [WIDTH - 1 : 0] data_wr;
	logic [WIDTH - 1 : 0] data_rd;
	logic full_flag;
	logic empty_flag
	
endinterface //fifo_if