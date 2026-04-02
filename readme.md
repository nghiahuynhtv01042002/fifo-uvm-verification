# FIFO Verification using SystemVerilog and UVM

## Introduction

This project demonstrates comprehensive SystemVerilog and UVM-based verification of a synchronous FIFO design. It implements a complete DV methodology with comprehensive test coverage for stress, corner-cases, and reset scenarios.

## Features Implemented

- **SystemVerilog RTL FIFO** (8-bit width, 16-entry depth)
- **Complete UVM Testbench** with layered architecture
- **Driver / Monitor / Sequencer / Agent** architecture
- **Scoreboard** with reference model checking
- **11 Comprehensive Test Scenarios**:
  - Basic I/O tests
  - Stress tests (write/read saturation)
  - Corner-case tests (overflow, underflow, boundary values)
  - Simultaneous read/write operations
  - Reset during activity recovery
- **Randomized Stimulus** generation with constrained transactions
- **Regression Suite** supporting single and batch test execution
- **Log Management** with per-test and regression logs

## Project Structure

```
fifo-uvm-verification/
│
├── rtl/
│   └── rtl_fifo.sv              # FIFO RTL implementation
│
├── tb/                          # Testbench components
│   ├── interface/
│   │   └── fifo_if.sv           # Virtual interface definition
│   ├── transaction/
│   │   └── fifo_transaction.sv  # Sequence item (transaction)
│   ├── agent/
│   │   ├── fifo_sequencer.sv    # Sequencer
│   │   ├── fifo_driver.sv       # Driver
│   │   ├── fifo_monitor.sv      # Monitor
│   │   └── fifo_agent.sv        # Agent (integrates driver/monitor/sequencer)
│   ├── sequence/
│   │   ├── fifo_sequence.sv     # Basic sequence
│   │   ├── fifo_stress_sequences.sv
│   │   ├── fifo_back_to_back_sequence.sv
│   │   ├── fifo_boundary_sequence.sv
│   │   ├── fifo_mixed_random_sequence.sv
│   │   ├── fifo_simultaneous_rw_sequence.sv
│   │   └── fifo_underflow_overflow_sequence.sv
│   ├── scoreboard/
│   │   └── fifo_scoreboard.sv   # Reference model & checking
│   ├── env/
│   │   └── fifo_env.sv          # Environment (integrates agent & scoreboard)
│   ├── test/
│   │   ├── fifo_test.sv         # Base test and basic tests
│   │   ├── fifo_stress_test.sv
│   │   ├── fifo_mixed_random_test.sv
│   │   ├── fifo_simultaneous_rw_test.sv
│   │   ├── fifo_boundary_test.sv
│   │   ├── fifo_reset_test.sv
│   │   └── fifo_underflow_overflow_test.sv
│   ├── pkg/
│   │   └── fifo_pkg.sv          # Package with all UVM definitions
│   └── top_module/
│       └── fifo_tb_top.sv       # Top-level testbench module
│
├── makefile                     # Build rules (compile, elab, run, regression)
├── readme.md                    # This file
└── de/                          # Build artifacts (created by make)
    ├── xsim.dir/               # Simulator working directory
    └── logs/                    # Test output logs (created by make regression)
```

## Prerequisites & Tools

- **Simulator:** Xilinx Vivado (xsim) — included with AMD Xilinx Vivado Design Suite
- **Language:** SystemVerilog
- **Methodology:** UVM (Universal Verification Methodology)
- **Build System:** GNU Make

## FIFO Specification

- Data width: 8 bits
- Depth: 16 entries
- Synchronous design
- Flags:
  - full
  - empty

## Verification Architecture
Testbench components:

- sequence_item
- sequence
- driver
- monitor
- agent
- scoreboard
- environment
- test

### Flow: 
```
sequence → driver → DUT → monitor → scoreboard
```

## Run Simulation

### Local (Makefile) usage with Vivado / xsim

Building and running tests using the provided Makefile:

```bash
# Compile, elaborate and run the default test (fifo_mixed_random_test)
make

# Run a single test (override UVM_TEST variable)
make run UVM_TEST=fifo_stress_test

# Run all tests in regression suite (saves logs to de/logs/)
make regression

# Display help
make help
```

### Test Suite

This project includes **11 comprehensive test scenarios**:

#### Basic Tests
- `fifo_base_test` — basic combined read/write sequence (10 transactions)
- `fifo_write_test` — basic write sequence followed by read
- `fifo_read_test` — basic read-only sequence

#### Stress Tests
- `fifo_write_stress_test` — sustained writes (256 transactions) to exercise full flag and FIFO saturation
- `fifo_read_stress_test` — sustained reads (256 transactions) to exercise empty flag and data order
- `fifo_mixed_random_test` — randomized read/write (512 transactions) to stress concurrency

#### Corner-Case Tests
- `fifo_simultaneous_rw_test` — simultaneous read and write (256 transactions) to verify behavior
- `fifo_back_to_back_sequence` — many consecutive writes (128) then reads (128) to stress pointer wraparound
- `fifo_overflow_test` — attempt writes when full (DEPTH+8 writes) to check overflow protection
- `fifo_underflow_test` — attempt reads when empty (32 reads) to check underflow protection
- `fifo_boundary_test` — boundary data patterns (0x00, 0xFF, alternating bits) to verify data width handling

#### Reset & Recovery Tests
- `fifo_reset_during_activity_test` — toggle reset while mixed traffic ongoing and verify recovery

### Coverage

Each test verifies:
- Data integrity (write/read data matching)
- Full/empty flag correctness
- Overflow protection (no data corruption when full)
- Underflow protection (no invalid data when empty)
- Reset behavior and recovery



## Example Simulation Output

<paste test picture and log here>

## Troubleshooting & Tips

### Environment Setup

Ensure Xilinx Vivado is installed and sourced:

```bash
# Example for Vivado 2023.2 on Linux
source /opt/Xilinx/Vivado/2023.2/settings64.sh

# Verify xsim is available
which xsim
which xvlog
which xelab
```

### Running Regression

When running `make regression`, each test runs in a **separate simulator invocation**. Results are saved to `de/logs/`:

```bash
# Clean previous build
make clean

# Run all tests sequentially
make regression

# Check results
ls -la de/logs/
cat de/logs/*.log  # view test logs
```

### Running Individual Tests

```bash
# Run specific test with verbose output
make run UVM_TEST=fifo_overflow_test

# Default test (fifo_mixed_random_test) if no UVM_TEST specified
make run

# Run compile, elaborate, and simulation in one step
make all
```

### Build Issues

If you encounter compilation errors:

1. Verify `xvlog`, `xelab`, and `xsim` are in your PATH (run Vivado settings script)
2. Ensure all `tb/sequence/*.sv` and `tb/test/*.sv` files are included in `tb/pkg/fifo_pkg.sv`
3. Check that `UVM` library is available in Vivado installation
4. Verify RTL `fifo_dut` module exists and matches top-level port connections in `fifo_tb_top.sv`

### xsim-Specific Options

Available options in the Makefile can be customized:

```makefile
COMPILE_FLAGS = -sv -L uvm          # Compile with SystemVerilog and UVM library
ELAB_FLAGS = -L uvm -s $(SIM_NAME)  # Elaborate with UVM
RUN_FLAGS = -R -log sim.log         # Run with GUI-less mode and logging
```

### Simulation Timeout

Default timeout is 500 µs. Adjust in [tb/top_module/fifo_tb_top.sv](tb/top_module/fifo_tb_top.sv#L48) if needed for longer tests.