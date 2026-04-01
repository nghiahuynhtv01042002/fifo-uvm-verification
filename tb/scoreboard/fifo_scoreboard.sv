class fifo_scoreboard #(int WIDTH = 8, int DEPTH = 16) extends uvm_scoreboard;
	typedef fifo_scoreboard #(WIDTH, DEPTH) fifo_scoreboard_p;
	`uvm_component_param_utils(fifo_scoreboard_p)
	
	uvm_analysis_imp #(fifo_trans #(WIDTH), fifo_scoreboard) analysis_export;
	
	bit [WIDTH-1:0] fifo_model_q[$:DEPTH +1];

	function new(string name  = "fifo_scoreboard", uvm_component parent = null);
		super.new(name, parent);
		analysis_export = new("analysis_export",this);
	endfunction
	
	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
	endtask
	
	virtual function void write(fifo_trans #(WIDTH) tr);
		if(tr.wr_en) begin
			fifo_model_q.push_back(tr.data_wr);
		end
		
		if(tr.rd_en) begin
			bit [WIDTH - 1 : 0] exp;
			if (fifo_model_q.size() == 0) begin
				`uvm_error("SB", "Read when model is empty")
				return;
			end
			exp = fifo_model_q.pop_front();
			
			if (exp != tr.data_rd)
				`uvm_error("SB",$sformatf("Mismatch exp=%0h act=%0h",exp,tr.data_rd))
		end
	endfunction
	
endclass