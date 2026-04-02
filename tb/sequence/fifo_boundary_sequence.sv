class fifo_boundary_sequence #(int WIDTH = 8)
	extends uvm_sequence#(fifo_trans #(WIDTH));
	typedef fifo_boundary_sequence#(WIDTH) fifo_boundary_sequence_p;
	`uvm_object_param_utils(fifo_boundary_sequence_p)

	function new(string name = "fifo_boundary_sequence");
		super.new(name);
	endfunction

	virtual task body();
		fifo_trans#(WIDTH) tr;
		// patterns: 0x00, 0xFF, 0xAA, 0x55 (constructed generically)
		bit [WIDTH-1:0] p0 = '0;
		bit [WIDTH-1:0] p1 = {WIDTH{1'b1}};
		bit [WIDTH-1:0] p2 = { { (WIDTH/2) {1'b1} }, { (WIDTH - WIDTH/2) {1'b0} } };
		bit [WIDTH-1:0] p3 = { { (WIDTH/2) {1'b0} }, { (WIDTH - WIDTH/2) {1'b1} } };

		bit [WIDTH-1:0] patterns[4];
		patterns[0] = p0;
		patterns[1] = p1;
		patterns[2] = p2;
		patterns[3] = p3;

		foreach (patterns[i]) begin
			tr = fifo_trans#(WIDTH)::type_id::create($sformatf("tr_%0d", i));
			start_item(tr);
			tr.wr_en = 1;
			tr.rd_en = 0;
			tr.data_wr = patterns[i];
			finish_item(tr);
		end
	endtask
endclass
