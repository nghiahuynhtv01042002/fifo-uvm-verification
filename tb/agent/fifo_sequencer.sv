class fifo_sequencer #(int WIDTH = 8) 
	extends uvm_sequencer #(fifo_trans #(WIDTH));
	
	typedef fifo_sequencer #(int WIDTH) fifo_sequencer_p;
	`uvm_component_param_utils(fifo_sequencer_p)
	
	function new(string name = "fifo_sequencer", uvm_component parent = null);
		super.new(name, parent);
	endfunction
endclass //fifo_sequencer extends uvm_sequencer