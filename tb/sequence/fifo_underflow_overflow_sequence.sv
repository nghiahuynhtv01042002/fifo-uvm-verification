class fifo_overflow_sequence #(int WIDTH = 8, int DEPTH = 16)
	extends uvm_sequence#(fifo_trans #(WIDTH));
	typedef fifo_overflow_sequence#(WIDTH, DEPTH) fifo_overflow_sequence_p;
	`uvm_object_param_utils(fifo_overflow_sequence_p)

	function new(string name = "fifo_overflow_sequence");
		super.new(name);
	endfunction

	virtual task body();
		fifo_trans#(WIDTH) tr;
		// write DEPTH + a few to attempt overflow
		repeat (DEPTH + 8) begin
			tr = fifo_trans#(WIDTH)::type_id::create("tr");
			start_item(tr);
			assert(tr.randomize() with { wr_en == 1; rd_en == 0; });
			finish_item(tr);
		end
	endtask
endclass

class fifo_underflow_sequence #(int WIDTH = 8, int COUNT = 32)
	extends uvm_sequence#(fifo_trans #(WIDTH));
	typedef fifo_underflow_sequence#(WIDTH, COUNT) fifo_underflow_sequence_p;
	`uvm_object_param_utils(fifo_underflow_sequence_p)

	function new(string name = "fifo_underflow_sequence");
		super.new(name);
	endfunction

	virtual task body();
		fifo_trans#(WIDTH) tr;
		// attempt reads when FIFO likely empty
		repeat (COUNT) begin
			tr = fifo_trans#(WIDTH)::type_id::create("tr");
			start_item(tr);
			assert(tr.randomize() with { wr_en == 0; rd_en == 1; });
			finish_item(tr);
		end
	endtask
endclass
