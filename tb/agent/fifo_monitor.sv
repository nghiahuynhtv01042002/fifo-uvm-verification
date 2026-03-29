class fifo_monitor #(int WIDTH = 8) extends uvm_monitor;
	typedef fifo_monitor #(int WIDTH) fifo_monitor_p;
	`uvm_component_param_utils(fifo_monitor_p)
	
	virtual fifo_if #(WIDTH) vfifo_if;
	uvm_analysis_port#(fifo_trans #(WIDTH)) ap;
	fifo_trans #(WIDTH) mon_trans;
	
	function new(string name = "fifo_monitor", uvm_component parent = null);
		super.new(name, parent);
		item_collect_port = new("item_collect_port",this);
		mon_trans = new();
	endfunction
	
	virtual function build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(! uvm_config_db#(virtual fifo_if #(WIDTH)::get(this,"", "vfifo_if",vfifo_if))) begin
			`uvm_fatal(get_type_name(),"No virtual interface vfifo_if specified for monitor");
		end
	endfunction
	
	virtual task run_phase(uvm_phase phase);
		fifo_trans #(WIDTH) tr;
		forever begin
			// temp logic
			@(posedge vfifo_if.clk);
			tr = fifo_trans#(WIDTH)::type_id::create("tr_mon");
			tr.wr_en   = vfifo_if.wr_en;
			tr.rd_en   = vfifo_if.rd_en;
			tr.data_wr = vfifo_if.data_wr;
			
			if (vfifo_if.rd_en)
				tr.data_rd = vfifo_if.data_rd;
				
			ap.write(tr);
			item_collect_port.write(mon_trans);
			'uvm_info(get_type_name(),"[MONITOR] contain the temp logic",UVM_LOW);
			
		end
	endtask
endclass //fifo_monitor