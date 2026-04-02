TOPMODULE = tb_top
SIM_NAME = fifo_tb
BUILD_DIR = de

UVM_TEST ?=fifo_read_test

TESTS = fifo_write_test \
		fifo_read_test \
		fifo_base_test \
		fifo_write_stress_test \
		fifo_read_stress_test \
		fifo_mixed_random_test \
		fifo_simultaneous_rw_test \
		fifo_overflow_test \
		fifo_underflow_test \
		fifo_boundary_test \
		fifo_reset_during_activity_test

TESTS_CSV := $(shell echo $(TESTS) | tr ' ' ',')

COMPILE_FLAGS = -sv -L uvm
ELAB_FLAGS = -L uvm -s $(SIM_NAME) -timescale 1ns/1ps 

RUN_FLAGS = -R -log sim.log

RTL_FILES = \
    rtl/rtl_fifo.sv

INTF_FILES = \
    tb/interface/fifo_if.sv

TB_PKG_FILES = \
    tb/pkg/fifo_pkg.sv

TB_TOP_FILES = \
    tb/top_module/fifo_tb_top.sv

SOURCE_FILES = $(RTL_FILES) $(INTF_FILES) $(TB_PKG_FILES) $(TB_TOP_FILES) 

all: run

compile:
	@mkdir -p $(BUILD_DIR)
	@echo "=== Compiling with Xsim ==="
	cd $(BUILD_DIR) && xvlog $(COMPILE_FLAGS) $(addprefix ../,$(SOURCE_FILES))

elab: compile
	@echo "=== Elaborating Design ==="
	cd $(BUILD_DIR) && xelab $(ELAB_FLAGS) $(TOPMODULE)

run: elab
	@echo "=== Running Simulation ==="
	cd $(BUILD_DIR) && xsim $(SIM_NAME) $(RUN_FLAGS) --testplusarg UVM_TESTNAME=$(UVM_TEST)
	
regression: compile elab
	@echo "=== Running Regression ==="
	@mkdir -p $(BUILD_DIR)/logs
	@for t in $(TESTS); do \
		echo "Running test: $$t"; \
		cd $(BUILD_DIR) && xsim $(SIM_NAME) $(RUN_FLAGS) \
		-testplusarg UVM_TESTNAME=$$t \
		-log logs/$$t.log; \
		cd ..; \
	done
	@echo "=== Regression Finished. Check $(BUILD_DIR)/logs for results."
	
gui: elab
	@echo "=== Opening GUI ==="
	cd $(BUILD_DIR) && xsim $(SIM_NAME) -gui

clean:
	@echo "=== Cleaning build directory ==="
	rm -rf $(BUILD_DIR)
	rm -rf xvlog.log xvlog.pb xelab.log xelab.pb xsim.log xsim.pb webtalk.log webtalk.jou xsim.dir

help:
	@echo "FIFO UVM Verification Makefile"
	@echo "==============================="
	@echo "Build artifacts are stored in: $(BUILD_DIR)/"
	@echo ""
	@echo "Targets:"
	@echo "  make         - Compile, elaborate, run simulation"
	@echo "  make run UVM_TEST=<testname>"
	@echo "testname list: "
	@echo "    fifo_write_test"
	@echo "    fifo_read_test"
	@echo "    fifo_base_test"
	@echo "    fifo_write_stress_test"
	@echo "    fifo_read_stress_test"
	@echo "    fifo_mixed_random_test"
	@echo "    fifo_simultaneous_rw_test"
	@echo "    fifo_overflow_test"
	@echo "    fifo_underflow_test"
	@echo "    fifo_boundary_test"
	@echo "    fifo_reset_during_activity_test"
	@echo "  make compile - Compile sources only"
	@echo "  make elab    - Compile and elaborate"
	@echo "  make run     - Run simulation (use UVM_TEST=testname)"
	@echo "  make gui     - Open waveform viewer"
	@echo "  make clean   - Remove build directory and Vivado root logs"

.PHONY: all compile elab run regression gui clean help