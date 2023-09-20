class write_sequence extends uvm_sequence#(mem_seq_item);
  
  `uvm_object_utils(write_sequence)
  
  function new(string name="write_sequence");
    super.new(name);
  endfunction
  `uvm_declare_p_sequencer(mem_sequencer)
  mem_seq_item request;
  
  virtual task body();
    repeat(2)begin
    request = mem_seq_item::type_id::create("request");
    `uvm_do_with(request, {request.wr_en == 1;})
    end
  endtask
  
endclass
