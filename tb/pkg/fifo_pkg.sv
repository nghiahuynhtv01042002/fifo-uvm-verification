package fifo_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	`include "../transaction/fifo_transaction.sv"

	`include "../agent/fifo_sequencer.sv"
	`include "../agent/fifo_driver.sv"
	`include "../agent/fifo_monitor.sv"
	`include "../agent/fifo_agent.sv"

	`include "../sequence/fifo_sequence.sv"

	`include "../scoreboard/fifo_scoreboard.sv"

	`include "../env/fifo_env.sv"

	`include "../test/fifo_test.sv"

endpackage // fifo_pkg