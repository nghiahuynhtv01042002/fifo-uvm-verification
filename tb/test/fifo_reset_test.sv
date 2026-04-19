class fifo_reset_during_activity_test extends fifo_base_test;
	`uvm_component_utils(fifo_reset_during_activity_test)
 
	virtual fifo_if #(8) vfifo_if; // lấy WIDTH=8 mặc định; nếu parameterized test thì dùng parameter
 
	function new(string name = "fifo_reset_during_activity_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction
 
	// Lấy interface từ config_db thay vì đi qua hierarchy
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db#(virtual fifo_if #(8))::get(this, "", "vfifo_if", vfifo_if))
			`uvm_fatal(get_type_name(), "Cannot get vfifo_if from config_db")
	endfunction
 
	virtual task run_phase(uvm_phase phase);
		fifo_mixed_random_sequence mix;
 
		phase.raise_objection(this);
 
		mix = fifo_mixed_random_sequence::type_id::create("mix_reset");
 
		fork
			// Reset toggler — drive đồng bộ với clock, dùng NBA
			begin
				#100;
				@(posedge vfifo_if.clk); vfifo_if.rst <= 1;
				repeat(2) @(posedge vfifo_if.clk);
				vfifo_if.rst <= 0;
 
				#200;
				@(posedge vfifo_if.clk); vfifo_if.rst <= 1;
				@(posedge vfifo_if.clk);
				vfifo_if.rst <= 0;
			end
			begin
				mix.start(env.fifo_agt.fifo_seqr);
			end
		join_any
 
		#50;
		phase.drop_objection(this);
	endtask
 
endclass