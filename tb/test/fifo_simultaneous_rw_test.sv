class fifo_simultaneous_rw_test extends fifo_base_test;
	`uvm_component_utils(fifo_simultaneous_rw_test)

	function new(string name="fifo_simultaneous_rw_test", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		fifo_simultaneous_rw_sequence seq;

		phase.raise_objection(this);

		seq = fifo_simultaneous_rw_sequence::type_id::create("simul");
		seq.start(env.fifo_agt.fifo_seqr);

		phase.drop_objection(this);
	endtask
endclass