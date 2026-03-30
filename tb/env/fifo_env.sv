class fifo_env #(int WIDTH = 8, int DEPTH = 16) extends uvm_env;
	typedef fifo_env #(WIDTH, DEPTH) fifo_env_p;
	`uvm_component_param_utils(fifo_env_p)

	fifo_agent #(WIDTH) fifo_agt;
	fifo_scoreboard #(WIDTH, DEPTH) fifo_sb;

	function new(string name = "fifo_env", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		fifo_agt = fifo_agent #(WIDTH)::type_id::create("fifo_agt", this);
		fifo_sb  = fifo_scoreboard#(WIDTH, DEPTH)::type_id::create("fifo_sb",  this);
	endfunction

	virtual function void connect_phase(uvm_phase phase);
		fifo_agt.fifo_mon.analysis_port.connect(fifo_sb.analysis_export);
	endfunction

endclass // fifo_env