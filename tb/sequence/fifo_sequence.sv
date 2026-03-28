class fifo_sequence #(int WIDTH = 8) 
	extends uvm_sequence #(fifo_trans #(WIDTH));
	
	typedef fifo_sequence #(int) fifo_sequence_p;
	`uvm_object_param_utils(fifo_sequence_p);
	function new(string name = "fifo_sequence");
		super.new(name);
	endfunction

	virtual task body();
		fifo_trans #(WIDTH) tr;
		repeat (10) begin
			tr = fifo_trans#(WIDTH) :: type_id :: create("tr");
			start_item(tr);
			assert (tr.randomize());
			finish_item(tr);
		end
	endtask
endclass

class fifo_write_sequence #(int WIDTH = 8)
	extends uvm_sequence#(fifo_trans #(WIDTH));
	
	typedef fifo_write_sequence #(int) fifo_write_sequence_p;
	`uvm_object_param_utils(fifo_write_sequence_p);
	function new(string name = "fifo_write_sequence");
		super.new(name);
	endfunction
	
	virtual task body();
		fifo_trans #(WIDTH) tr;
		repeat (10) begin
			tr = fifo_trans#(WIDTH) :: type_id :: create("tr");
			start_item(tr);
			assert (tr.randomize() with {
				 wr_en == 1;
				 rd_en == 0;
			});
			finish_item(tr);
		end
	endtask
endclass //fifo_write_sequence


	
class fifo_read_sequence #(int WIDTH = 8)
	extends uvm_sequence#(fifo_trans #(WIDTH));
	
	typedef fifo_read_sequence #(int) fifo_read_sequence_p;
	`uvm_object_param_utils(fifo_read_sequence_p);
	function new(string name = "fifo_read_sequence");
		super.new(name);
	endfunction
	
	virtual task body();
		fifo_trans #(WIDTH) tr;
		repeat (10) begin
			tr = fifo_trans#(WIDTH) :: type_id :: create("tr");
			start_item(tr);
			assert (tr.randomize() with {
				 wr_en == 0;
				 rd_en == 1;
			});
			finish_item(tr);
		end
	endtask
endclass //fifo_read_sequence