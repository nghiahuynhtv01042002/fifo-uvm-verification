class fifo_reset_during_activity_test extends fifo_base_test;
	`uvm_component_utils(fifo_reset_during_activity_test)

	function new(string name="fifo_reset_during_activity_test", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		fifo_mixed_random_sequence mix;

		phase.raise_objection(this);

		mix = fifo_mixed_random_sequence::type_id::create("mix_reset");

		// fork a reset toggler that manipulates the virtual interface through env
		fork
			begin
				// small delay to let stimulus start
				#100;
				env.fifo_agt.vfifo_if.rst = 1;
				#20;
				env.fifo_agt.vfifo_if.rst = 0;
				#200;
				env.fifo_agt.vfifo_if.rst = 1;
				#10;
				env.fifo_agt.vfifo_if.rst = 0;
			end
			begin
				mix.start(env.fifo_agt.fifo_seqr);
			end
		join_any

		// allow some time after join_any for activity to settle
		#50;

		phase.drop_objection(this);
	endtask
endclass