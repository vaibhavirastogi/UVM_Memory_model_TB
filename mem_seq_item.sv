class mem_seq_item extends uvm_sequence_item;
 
  randc bit [2:0] addr;
 rand bit wr_en;
 rand bit rd_en;
 rand bit[7:0] wdata;
  bit[7:0]rdata;
  
  `uvm_object_utils_begin(mem_seq_item)
  `uvm_field_int(addr,UVM_ALL_ON)
  `uvm_field_int(wr_en, UVM_ALL_ON)
  `uvm_field_int(rd_en, UVM_ALL_ON)
  `uvm_field_int(wdata, UVM_ALL_ON)
  `uvm_field_int(rdata, UVM_ALL_ON)
  `uvm_object_utils_end
  
  
  
  function new(string name= "mem_seq_item");
    super.new(name);
  endfunction
  
 
  constraint wr_rd_sel {wr_en != rd_en; };
  
  constraint wdata_lim {wdata>'h77;}
  
  constraint addr_lim {addr>3;}
  
  function void custom_print();
  $display("---------------------------");
    $display("Transaction Details from scoreboard");
  $display("---------------------------");
  $display("Address: %0h", addr);
  $display("Write Enable: %0b", wr_en);
  $display("Read Enable: %0b", rd_en);
  $display("Write Data: %0h", wdata);
  $display("Read Data: %0h", rdata);
  $display("---------------------------");
endfunction

  
endclass
