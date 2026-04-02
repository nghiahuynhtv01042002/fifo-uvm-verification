class fifo_simultaneous_rw_sequence #(int WIDTH = 8, int COUNT = 256)
	extends uvm_sequence#(fifo_trans #(WIDTH));
	typedef fifo_simultaneous_rw_sequence#(WIDTH, COUNT) fifo_simultaneous_rw_sequence_p;
	`uvm_object_param_utils(fifo_simultaneous_rw_sequence_p)

	function new(string name = "fifo_simultaneous_rw_sequence");
		super.new(name);
	endfunction

	virtual task body();
		fifo_trans#(WIDTH) tr;
		repeat (COUNT) begin
			tr = fifo_trans#(WIDTH)::type_id::create("tr");
			start_item(tr);
			assert(tr.randomize() with { wr_en == 1; rd_en == 1; });
			finish_item(tr);
		end
	endtask
endclass