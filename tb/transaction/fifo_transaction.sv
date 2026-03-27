class fifo_trans #(parameter WIDTH = 8) extends uvm_sequence_item ;
	rand logic wr_en;
	rand logic rd_en;
	rand logic [WIDTH - 1 : 0] data_wr;
	logic [WIDTH - 1 : 0] data_rd;
	
	`uvm_object_utils(fifo_trans);
	
	function new(string name = "fifo_trans");
		super.new(name);
	endfunction //new()
endclass // fifo_trans