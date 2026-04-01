import uvm_pkg::*;
import fifo_pkg::*;
`include "uvm_macros.svh"

module tb_top;
	parameter int WIDTH = 8;
	parameter int DEPTH = 16;
	
	logic clk = 0;
	always #5 clk = ~clk;
	
	fifo_if #(WIDTH) fifo_vif();
	assign fifo_vif.clk = clk;
	
	fifo_dut #(
		.DEPTH (DEPTH),
		.WIDTH (WIDTH)
	) dut (
		.clk		(fifo_vif.clk),
		.rst		(fifo_vif.rst),
		.wr_en		(fifo_vif.wr_en),
		.rd_en		(fifo_vif.rd_en),
		.data_wr	(fifo_vif.data_wr),
		.data_rd	(fifo_vif.data_rd),
		.full_flag	(fifo_vif.full_flag),
		.empty_flag	(fifo_vif.empty_flag)
		 
	);
	
	initial begin
		uvm_config_db #(virtual fifo_if #(WIDTH))::set(
			null,
			"uvm_test_top.env.fifo_agt.*",
			"vfifo_if",
			fifo_vif
		);
		uvm_config_db #(int) :: set (null,"*","WIDTH",WIDTH); 
		uvm_config_db #(int) :: set (null,"*","DEPTH",DEPTH); 
	end
	
	initial begin
		$dumpfile("fifo_tb.vcd");
		$dumpvars(0, tb_top);
	end
	
	initial begin
		#500_000;
		`uvm_fatal("TB_TOP", "Simulation timeout — objection not dropped in 500 us")
	end
	
	initial begin
		run_test();
	end
endmodule