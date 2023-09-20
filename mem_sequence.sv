class mem_sequence extends uvm_sequence#(mem_seq_item);
  
  `uvm_object_utils(mem_sequence)
  

  function new(string name= "mem_sequence");
    super.new(name);
  endfunction
  
  `uvm_declare_p_sequencer(mem_sequencer)
  
 mem_seq_item request;
  
  virtual task body();
    request = mem_seq_item::type_id::create("request");
//    start_item(request);
//    if(!request.randomize())
//       `uvm_error("body::seq_item", "randomization failure for packet");
//    finish_item(request);
    
    `uvm_do(request)
    
 
  endtask
endclass
