class mem_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(mem_scoreboard)
  uvm_analysis_imp#(mem_seq_item, mem_scoreboard) item_collected_export;

  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  mem_seq_item pkt_queue [$];
  bit[7:0] sc_mem[8];
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export = new("item_collected_export", this);
    foreach(sc_mem[i]) sc_mem[i] = 'hca;
  endfunction: build_phase
  
  mem_seq_item pkt;
  
  // write
  virtual function void write(mem_seq_item pkt);
    $display("SCB:: Below Pkt recived from monitor");
    pkt.custom_print();
    pkt_queue.push_back(pkt);
    endfunction : write

  // run phase
  virtual task run_phase(uvm_phase phase);
    //comparison logic   
    mem_seq_item mem_pkt;
    
    forever begin
    wait(pkt_queue.size()>0);
    mem_pkt=pkt_queue.pop_front();
    
    if(mem_pkt.wr_en)
      begin
        
        $display("SCB:: WRITE DATA is given below!!!");
        $display("SCB:: Write addr is %h",mem_pkt.addr);
        $display("SCB:: Write data is %h",mem_pkt.wdata);
      end
    else if(mem_pkt.rd_en)
      begin
        if(mem_pkt.rdata==sc_mem[mem_pkt.addr])
          begin
          $display("SCB:: READ DATA MATCH!!!");
        $display("SCB:: READ DATA is given below!!!");
        $display("SCB:: READ addr is %h",mem_pkt.addr);
        $display("SCB:: READ data is %h",mem_pkt.rdata);
          end
      end
    else
      $display("SCB: ERROR, DATA MISMATCH");
    
    end
    
  endtask : run_phase
  
endclass : mem_scoreboard
