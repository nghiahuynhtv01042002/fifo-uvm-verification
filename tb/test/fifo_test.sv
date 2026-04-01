class fifo_base_test extends uvm_test;
	`uvm_component_utils(fifo_base_test)

	fifo_env env;
	int WIDTH;
	int DEPTH;

	function new(string name="fifo_base_test", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#(int)::get(this,"","WIDTH",WIDTH))
			`uvm_fatal("CFG","WIDTH not found")

		if(!uvm_config_db#(int)::get(this,"","DEPTH",DEPTH))
			`uvm_fatal("CFG","DEPTH not found")

		env = fifo_env::type_id::create("env",this);
	endfunction

	virtual task run_phase(uvm_phase phase);
		fifo_sequence seq;

		phase.raise_objection(this);

		seq = fifo_sequence::type_id::create("seq");
		seq.start(env.fifo_agt.fifo_seqr);

		phase.drop_objection(this);
	endtask
endclass

class fifo_write_test extends fifo_base_test;
	`uvm_component_utils(fifo_write_test)

	function new(string name="fifo_write_test", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		fifo_write_sequence wr_seq;
		fifo_read_sequence  rd_seq;

		phase.raise_objection(this);

		wr_seq = fifo_write_sequence::type_id::create("wr_seq");
		wr_seq.start(env.fifo_agt.fifo_seqr);

		rd_seq = fifo_read_sequence::type_id::create("rd_seq");
		rd_seq.start(env.fifo_agt.fifo_seqr);

		phase.drop_objection(this);
	endtask
endclass

class fifo_read_test extends fifo_base_test;
	`uvm_component_utils(fifo_read_test)

	function new(string name="fifo_read_test", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		fifo_read_sequence rd_seq;

		phase.raise_objection(this);

		rd_seq = fifo_read_sequence::type_id::create("rd_seq");
		rd_seq.start(env.fifo_agt.fifo_seqr);

		phase.drop_objection(this);
	endtask
endclass
