TOPMODULE = tb_top
SIM_NAME = fifo_tb
BUILD_DIR = de

COMPILE_FLAGS = -sv -L uvm

ELAB_FLAGS = -L uvm -s $(SIM_NAME) --timescale 1ns/1ps
RUN_FLAGS = -runall -log $(BUILD_DIR)/sim.log

RTL_FILES = \
	rtl/rtl_fifo.sv

INTF_FILES = \
	tb/interface/fifo_if.sv

TB_PKG_FILES = \
	tb/pkg/fifo_pkg.sv

TB_TOP_FILES = \
	tb/top_module/fifo_tb_top.sv

SOURCE_FILES = $(RTL_FILES) $(INTF_FILES) $(TB_PKG_FILES) $(TB_TOP_FILES)

all: compile elab run

compile:
	@mkdir -p $(BUILD_DIR)
	@echo "=== Compiling with Xsim ==="
	cd $(BUILD_DIR) && xvlog $(COMPILE_FLAGS) $(addprefix ../,$(SOURCE_FILES))

elab: compile
	@echo "=== Elaborating Design ==="
	cd $(BUILD_DIR) && xelab $(ELAB_FLAGS) $(TOPMODULE)

run: elab
	@echo "=== Running Simulation ==="
	cd $(BUILD_DIR) && xsim $(SIM_NAME) $(RUN_FLAGS)

gui: elab
	@echo "=== Opening GUI ==="
	cd $(BUILD_DIR) && xsim $(SIM_NAME) -gui

clean:
	@echo "=== Cleaning build directory ==="
	rm -rf $(BUILD_DIR)

help:
	@echo "FIFO UVM Verification Makefile"
	@echo "==============================="
	@echo "Build artifacts are stored in: $(BUILD_DIR)/"
	@echo ""
	@echo "Targets:"
	@echo "  make        - Compile, elaborate, run simulation"
	@echo "  make compile - Compile sources only"
	@echo "  make elab    - Compile and elaborate"
	@echo "  make run     - Run simulation"
	@echo "  make gui     - Open waveform viewer"
	@echo "  make clean   - Remove build directory"

.PHONY: all compile elab run gui clean help