class fifo_scoreboard #(int WIDTH = 8, int DEPTH = 16) extends uvm_scoreboard;
	typedef fifo_scoreboard #(WIDTH, DEPTH) fifo_scoreboard_p;
	`uvm_component_param_utils(fifo_scoreboard_p)
 
	uvm_analysis_imp #(fifo_trans #(WIDTH), fifo_scoreboard_p) analysis_export;
 
	bit [WIDTH-1:0] fifo_model_q[$:DEPTH-1];
 
	function new(string name = "fifo_scoreboard", uvm_component parent = null);
		super.new(name, parent);
		analysis_export = new("analysis_export", this);
	endfunction
 
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
 
	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
	endtask
 
	function void reset_model();
		fifo_model_q.delete();
		`uvm_info(get_type_name(), "Scoreboard model reset", UVM_MEDIUM)
	endfunction
 
	virtual function void write(fifo_trans #(WIDTH) tr);
		if (tr.wr_en) begin
			if (fifo_model_q.size() < DEPTH)
				fifo_model_q.push_back(tr.data_wr);
			else
				`uvm_warning("SB", "Write attempted when model full  RTL should block via full_flag")
		end
 
		if (tr.rd_en) begin
			bit [WIDTH-1:0] exp;
			if (fifo_model_q.size() == 0) begin
				`uvm_warning("SB", "Read attempted when model empty  RTL should block via empty_flag")
				return;
			end
			exp = fifo_model_q.pop_front();
			if (exp != tr.data_rd)
				`uvm_error("SB", $sformatf("Mismatch: exp=0x%0h  act=0x%0h", exp, tr.data_rd))
			else
				`uvm_info("SB", $sformatf("PASS: data=0x%0h", exp), UVM_HIGH)
		end
	endfunction
 
endclass
 