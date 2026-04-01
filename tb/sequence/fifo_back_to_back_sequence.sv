class fifo_back_to_back_sequence #(int WIDTH = 8, int WCOUNT = 128, int RCOUNT = 128)
	extends uvm_sequence#(fifo_trans #(WIDTH));
	typedef fifo_back_to_back_sequence#(WIDTH, WCOUNT, RCOUNT) fifo_back_to_back_sequence_p;
	`uvm_object_param_utils(fifo_back_to_back_sequence_p)

	function new(string name = "fifo_back_to_back_sequence");
		super.new(name);
	endfunction

	virtual task body();
		fifo_trans#(WIDTH) tr;
		// many writes
		repeat (WCOUNT) begin
			tr = fifo_trans#(WIDTH)::type_id::create("tr");
			start_item(tr);
			assert(tr.randomize() with { wr_en == 1; rd_en == 0; });
			finish_item(tr);
		end
		// many reads
		repeat (RCOUNT) begin
			tr = fifo_trans#(WIDTH)::type_id::create("tr");
			start_item(tr);
			assert(tr.randomize() with { wr_en == 0; rd_en == 1; });
			finish_item(tr);
		end
	endtask
endclass