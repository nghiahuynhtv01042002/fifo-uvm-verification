
class fifo_write_stress_test extends fifo_base_test;
	`uvm_component_utils(fifo_write_stress_test)

	function new(string name="fifo_write_stress_test", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		fifo_write_stress_sequence wr_stress;

		phase.raise_objection(this);

		wr_stress = fifo_write_stress_sequence::type_id::create("wr_stress");
		wr_stress.start(env.fifo_agt.fifo_seqr);

		phase.drop_objection(this);
	endtask
endclass

class fifo_read_stress_test extends fifo_base_test;
	`uvm_component_utils(fifo_read_stress_test)

	function new(string name="fifo_read_stress_test", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		fifo_read_stress_sequence rd_stress;

		phase.raise_objection(this);

		rd_stress = fifo_read_stress_sequence::type_id::create("rd_stress");
		rd_stress.start(env.fifo_agt.fifo_seqr);

		phase.drop_objection(this);
	endtask
endclass
