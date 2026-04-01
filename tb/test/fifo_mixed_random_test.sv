class fifo_mixed_random_test extends fifo_base_test;
	`uvm_component_utils(fifo_mixed_random_test)

	function new(string name="fifo_mixed_random_test", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		fifo_mixed_random_sequence mix;

		phase.raise_objection(this);

		mix = fifo_mixed_random_sequence::type_id::create("mix");
		mix.start(env.fifo_agt.fifo_seqr);

		phase.drop_objection(this);
	endtask
endclass
