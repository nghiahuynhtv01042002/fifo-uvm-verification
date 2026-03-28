class fifo_trans #(int WIDTH = 8) extends uvm_sequence_item ;
	rand logic wr_en;
	rand logic rd_en;
	rand logic [WIDTH - 1 : 0] data_wr;
	logic [WIDTH - 1 : 0] data_rd;
	
	typedef fifo_trans #(int) fifo_trans_p;
	
	`uvm_object_utils(fifo_trans_p);

	function new(string name = "fifo_trans");
		super.new(name);
	endfunction
endclass // fifo_trans