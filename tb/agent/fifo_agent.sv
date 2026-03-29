class fifo_agent #(int WIDTH = 8) extends uvm_agent;

	fifo_sequencer #(WIDTH) fifo_seqr;
	fifo_driver #(WIDTH) fifo_drv;
	fifo_monitor #(WIDTH) fifo_mon;
	
	virtual fifo_if #(WIDTH) vfifo_if;
	
	function new(string name = "fifo_agent", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual function build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (get_is_active() == UVM_ACTIVE) begin
			fifo_seqr = fifo_sequencer::type_id::create("fifo_seqr", this);
			fifo_drv = fifo_driver::type_id::create("fifo_drv", this);
			fifo_mon = fifo_monitor::type_id:create("fifo_mon",this);
			if (! uvm_config_db#(virtual fifo_if #(WIDTH))::set(this,"fifo_drv","vfifo_if",vfifo_if)) begin
				`uvm_fatal(get_type_name(), "Didn't get handle to virtual interface vfifo_if");
			end

			if(! uvm_config_db#(virtual fifo_if #(WIDTH))::set(this,"fifo_mon","vfifo_if",vfifo_if)) begin
				`uvm_fatal(get_type_name(),"Didn't get handle to virtual interface vfifo_if");
			end
		end
	endfunction

	virtual task connect_phase(uvm_phase phase);
		seq_item_port.connect(fifo_seqr.seq_item_export);
		//fifo_mon.ap.connect(scoreboard.analysis_export);
	endtask
endclass //fifo_agent