class fifo_agent #(int WIDTH = 8) extends uvm_agent;

	fifo_sequencer #(WIDTH) fifo_seqr;
	fifo_driver #(WIDTH) fifo_drv;
	fifo_monitor #(WIDTH) fifo_mon;
	
	typedef fifo_agent#(WIDTH) fifo_agent_p;
	`uvm_component_param_utils(fifo_agent_p)
	
	virtual fifo_if #(WIDTH) vfifo_if;
	
	function new(string name = "fifo_agent", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (get_is_active() == UVM_ACTIVE) begin
			fifo_seqr = fifo_sequencer::type_id::create("fifo_seqr", this);
			fifo_drv = fifo_driver::type_id::create("fifo_drv", this);
			fifo_mon = fifo_monitor::type_id::create("fifo_mon",this);
			if (! uvm_config_db#(virtual fifo_if #(WIDTH))::get(this,"fifo_drv","vfifo_if",vfifo_if)) begin
				`uvm_fatal(get_type_name(), "Didn't get handle to virtual interface vfifo_if");
			end

			if(! uvm_config_db#(virtual fifo_if #(WIDTH))::get(this,"fifo_mon","vfifo_if",vfifo_if)) begin
				`uvm_fatal(get_type_name(),"Didn't get handle to virtual interface vfifo_if");
			end
		end
	endfunction

	virtual function void connect_phase(uvm_phase phase);
		fifo_drv.seq_item_port.connect(fifo_seqr.seq_item_export);
	endfunction
endclass //fifo_agent