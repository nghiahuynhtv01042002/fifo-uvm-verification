package fifo_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	`include "../transaction/fifo_transaction.sv"

	`include "../agent/fifo_sequencer.sv"
	`include "../agent/fifo_driver.sv"
	`include "../agent/fifo_monitor.sv"
	`include "../agent/fifo_agent.sv"

	`include "../sequence/fifo_sequence.sv"
	`include "../sequence/fifo_back_to_back_sequence.sv"
	`include "../sequence/fifo_boundary_sequence.sv"
	`include "../sequence/fifo_mixed_random_sequence.sv"
	`include "../sequence/fifo_simultaneous_rw_sequence.sv"
	`include "../sequence/fifo_stress_sequences.sv"
	`include "../sequence/fifo_underflow_overflow_sequence.sv"
	
	`include "../scoreboard/fifo_scoreboard.sv"

	`include "../env/fifo_env.sv"

	`include "../test/fifo_test.sv"
	`include "../test/fifo_boundary_test.sv"
	`include "../test/fifo_mixed_random_test.sv"
	`include "../test/fifo_reset_test.sv"
	`include "../test/fifo_simultaneous_rw_test.sv"
	`include "../test/fifo_stress_test.sv"
	`include "../test/fifo_underflow_overflow_test.sv"

endpackage // fifo_pkg