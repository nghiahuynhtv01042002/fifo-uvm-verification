class fifo_driver #(int WIDTH = 8 ) 
	extends uvm_driver#(fifo_trans #(WIDTH));
	
	typedef fifo_driver #(WIDTH) fifo_driver_p;
	`uvm_component_param_utils(fifo_driver_p);
	
	virtual fifo_if #(WIDTH) vfifo_if;
	
	function new(string name = "fifo_driver", uvm_component parent = null);
		super.new(name, parent);
	endfunction 
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (! uvm_config_db#(virtual fifo_if #(WIDTH))::get(this,"","vfifo_if",vfifo_if)) begin
			`uvm_fatal(get_type_name(), "Didn't get handle to virtual interface vfifo_if" );
		end
	endfunction
	
	virtual task run_phase(uvm_phase phase);
		fifo_trans #(WIDTH) tr;
		forever begin
			// get next sequence from the sequencer
			seq_item_port.get_next_item(tr); 
			// temp logic
			`uvm_info(get_type_name(),"[DRIVER] contain the temp logic",UVM_LOW);
			
			vfifo_if.wr_en <= tr.wr_en;
			vfifo_if.rd_en <= tr.rd_en;
			vfifo_if.data_wr <= tr.data_wr;
			@(posedge vfifo_if.clk);
			if (tr.rd_en) 
				tr.data_rd <= vfifo_if.data_rd;

			seq_item_port.item_done();
		end
	endtask
	
endclass //fifo_driver