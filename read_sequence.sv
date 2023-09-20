class read_sequence extends uvm_sequence#(mem_seq_item);
  
  `uvm_object_utils(read_sequence)
  
  function new(string name="read_sequence");
    super.new(name);
  endfunction
    `uvm_declare_p_sequencer(mem_sequencer)
  mem_seq_item request;
  
  virtual task body();
    repeat(10) begin
    request = mem_seq_item::type_id::create("request");
    `uvm_do_with(request, {request.rd_en == 1;})
    end
  endtask
  
endclass
