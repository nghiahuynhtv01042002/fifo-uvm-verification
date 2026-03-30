module fifo_dut #(
	parameter DEPTH = 16,
	parameter WIDTH = 8
)(
	input logic wr_en,
	input logic rd_en,
	input logic clk,
	input logic rst,
	input logic [WIDTH - 1 : 0] data_wr,
	output logic [WIDTH - 1 : 0] data_rd,
	output logic full_flag,
	output logic empty_flag
);
	logic [WIDTH -1 : 0] mem[DEPTH];
	logic [$clog2(DEPTH) -1 : 0] wr_ptr;
	logic [$clog2(DEPTH) -1 : 0] rd_ptr;
	
	assign empty_flag = (wr_ptr == rd_ptr);
	assign full_flag  = ((wr_ptr - rd_ptr) == DEPTH);

	always_ff @( posedge clk ) begin : write_mem
		if(rst) begin
			wr_ptr <= 0;
		end
		else if (wr_en && !full_flag) begin
			mem[wr_ptr % DEPTH] <= data_wr;
			wr_ptr <= wr_ptr + 1;
		end
	end

	always_ff @( posedge clk ) begin : read_mem
		if(rst) begin
			rd_ptr <= 0;
		end
		else if (rd_en && !empty_flag) begin
			data_rd <= mem[rd_ptr % DEPTH];
			rd_ptr <= rd_ptr + 1;
		end
	end
endmodule
