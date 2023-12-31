`include "mem_seq_item.sv"

`include "mem_sequencer.sv"
`include "mem_driver.sv"
`include "mem_monitor.sv"


`include "write_sequence.sv"


class mem_agent extends uvm_agent;
  
  `uvm_component_utils(mem_agent);
  
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    
  endfunction
  
  
  mem_driver driver;
  mem_monitor monitor;
  mem_sequencer sequencer;
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active()==UVM_ACTIVE) begin
    driver=mem_driver::type_id::create("driver", this);
    sequencer=mem_sequencer::type_id::create("sequencer", this);
      
    end
    
    monitor=mem_monitor::type_id::create("monitor", this);
    
  endfunction
  
  
  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(get_is_active()==UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
    
  endfunction
  
  
  
  
  
  
endclass
