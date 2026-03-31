class fifo_base_test #(int WIDTH = 8, int DEPTH =16 ) extends uvm_test;
	typedef fifo_base_test #(WIDTH, DEPTH) fifo_base_test_p;
	`uvm_component_param_utils(fifo_base_test_p)
	
	fifo_env #(WIDTH, DEPTH) fifo_env;
	
	function new(string name = "fifo_base_test", uvm_component parent =  null);
		super.new(name,parent);
	endfunction
	
	virtual task run_phase(uvm_phase phase);
		fifo_sequence #(WIDTH) seq;
		phase.raise_objection(this);

		seq = fifo_sequence#(WIDTH)::type_id::create("seq");
		seq.start(env.fifo_agt.fifo_seqr);
 
		phase.drop_objection(this);
	endtask
endclass // fifo_base_test

class fifo_write_test #(int WIDTH = 8, int DEPTH = 16)
	extends fifo_base_test #(WIDTH, DEPTH);
 
	typedef fifo_write_test #(WIDTH, DEPTH) fifo_write_test_p;
	`uvm_component_param_utils(fifo_write_test_p)
 
	function new(string name = "fifo_write_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction
 
	virtual task run_phase(uvm_phase phase);
		fifo_write_sequence #(WIDTH) wr_seq;
		fifo_read_sequence  #(WIDTH) rd_seq;
		phase.raise_objection(this);
 
		// Write DEPTH entries.
		wr_seq = fifo_write_sequence#(WIDTH)::type_id::create("wr_seq");
		wr_seq.start(env.fifo_agt.fifo_seqr);
 
		// Read them all back.
		rd_seq = fifo_read_sequence#(WIDTH)::type_id::create("rd_seq");
		rd_seq.start(env.fifo_agt.fifo_seqr);
 
		phase.drop_objection(this);
	endtask
 
endclass // fifo_write_test
 
class fifo_read_test #(int WIDTH = 8, int DEPTH = 16)
	extends fifo_base_test #(WIDTH, DEPTH);
 
	typedef fifo_read_test #(WIDTH, DEPTH) fifo_read_test_p;
	`uvm_component_param_utils(fifo_read_test_p)
 
	function new(string name = "fifo_read_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction
 
	virtual task run_phase(uvm_phase phase);
		fifo_read_sequence #(WIDTH) rd_seq;
		phase.raise_objection(this);
		
		rd_seq = fifo_read_sequence#(WIDTH)::type_id::create("rd_seq");
		rd_seq.start(env.fifo_agt.fifo_seqr);
 
		phase.drop_objection(this);
	endtask
 
endclass : fifo_read_test