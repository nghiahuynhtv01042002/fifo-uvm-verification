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
		seq.start(fifo_env.fifo_agt.fifo_seqr);
 
		phase.drop_objection(this);
	endtask
endclass

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
 
		wr_seq = fifo_write_sequence#(WIDTH)::type_id::create("wr_seq");
		wr_seq.start(fifo_env.fifo_agt.fifo_seqr);
 
		rd_seq = fifo_read_sequence#(WIDTH)::type_id::create("rd_seq");
		rd_seq.start(fifo_env.fifo_agt.fifo_seqr);
 
		phase.drop_objection(this);
	endtask
 
endclass
 
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
		rd_seq.start(fifo_env.fifo_agt.fifo_seqr);
 
		phase.drop_objection(this);
	endtask
endclass


class fifo_write_test_run extends fifo_write_test#(int WIDTH = 8,int DEPTH = 16);
	`uvm_component_utils(fifo_write_test_run)
	function new(string name = "fifo_write_test_run", uvm_component parnet = null);
		super.new(name,parent);
	endfunction
endclass