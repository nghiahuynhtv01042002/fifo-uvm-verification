class fifo_overflow_test extends fifo_base_test;
	`uvm_component_utils(fifo_overflow_test)

	function new(string name="fifo_overflow_test", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		fifo_overflow_sequence seq;

		phase.raise_objection(this);

		seq = fifo_overflow_sequence::type_id::create("overflow");
		seq.start(env.fifo_agt.fifo_seqr);

		phase.drop_objection(this);
	endtask
endclass

class fifo_underflow_test extends fifo_base_test;
	`uvm_component_utils(fifo_underflow_test)

	function new(string name="fifo_underflow_test", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		fifo_underflow_sequence seq;

		phase.raise_objection(this);

		seq = fifo_underflow_sequence::type_id::create("underflow");
		seq.start(env.fifo_agt.fifo_seqr);

		phase.drop_objection(this);
	endtask
endclass