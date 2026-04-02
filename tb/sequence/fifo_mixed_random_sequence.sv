class fifo_mixed_random_sequence #(int WIDTH = 8, int COUNT = 512)
	extends uvm_sequence#(fifo_trans #(WIDTH));
	typedef fifo_mixed_random_sequence#(WIDTH, COUNT) fifo_mixed_random_sequence_p;
	`uvm_object_param_utils(fifo_mixed_random_sequence_p)

	function new(string name = "fifo_mixed_random_sequence");
		super.new(name);
	endfunction

	virtual task body();
		fifo_trans#(WIDTH) tr;
		repeat (COUNT) begin
			tr = fifo_trans#(WIDTH)::type_id::create("tr");
			start_item(tr);
			// allow random read/write including simultaneous
			assert(tr.randomize());
			finish_item(tr);
		end
	endtask
endclass