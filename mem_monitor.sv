`define MON_INTF vif.mon_mp.monitor_cb
class mem_monitor extends uvm_monitor;
  

    virtual mem_intf vif;

  uvm_analysis_port #(mem_seq_item) item_collected_port;

    mem_seq_item trans_collected;

  `uvm_component_utils(mem_monitor)

  function new (string name, uvm_component parent);
    super.new(name, parent);
       item_collected_port = new("item_collected_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    trans_collected=mem_seq_item::type_id::create("trans_collected", this);
    
    if(!uvm_config_db#(virtual mem_intf)::get(this, "", "vif", vif))
      `uvm_fatal("Monitor build", "Failed to get intf")
  endfunction


  virtual task run_phase(uvm_phase phase);
    forever begin
    sample();
      trans_collected.print();
    end
    
  endtask
    
   virtual task sample();
      begin
       
         @(posedge vif.clk);
        wait(`MON_INTF.wr_en || `MON_INTF.rd_en);

        trans_collected.addr = `MON_INTF.addr;

        
        if(`MON_INTF.wr_en) begin
        trans_collected.wr_en = `MON_INTF.wr_en;
        trans_collected.wdata = `MON_INTF.wdata;
        trans_collected.rd_en = 0;

      end
        
        if(`MON_INTF.rd_en) begin
        trans_collected.rd_en = `MON_INTF.rd_en;
        trans_collected.wr_en = 0;
          @(posedge vif.clk);
       
         
          #1
        trans_collected.rdata = `MON_INTF.rdata;
          $display("Mon:: rdata is %h", trans_collected.rdata);
      end
	  item_collected_port.write(trans_collected);
      end
      
    endtask
    
    
    
endclass
