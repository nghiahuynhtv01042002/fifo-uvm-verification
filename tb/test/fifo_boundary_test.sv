class fifo_boundary_test extends fifo_base_test;
	`uvm_component_utils(fifo_boundary_test)

	function new(string name="fifo_boundary_test", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		fifo_boundary_sequence seq;

		phase.raise_objection(this);

		seq = fifo_boundary_sequence::type_id::create("boundary");
		seq.start(env.fifo_agt.fifo_seqr);

		phase.drop_objection(this);
	endtask
endclass