package fifo_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  `include "tb/transaction/fifo_transaction.sv"

  `include "tb/agent/fifo_sequencer.sv"
  `include "tb/agent/fifo_driver.sv"
  `include "tb/agent/fifo_monitor.sv"
  `include "tb/agent/fifo_agent.sv"

  `include "tb/sequence/fifo_sequence.sv"

  `include "tb/scoreboard/fifo_scoreboard.sv"

  `include "tb/env/fifo_env.sv"

  `include "tb/test/fifo_test.sv"

endpackage // fifo_pkg