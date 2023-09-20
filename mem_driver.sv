`define DRV_INTF vif.drv_mp.driver_cb
class mem_driver extends uvm_driver #(mem_seq_item);
  `uvm_component_utils(mem_driver)
  
  
  //declare seq_item_port ????, also create it in constructor??
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual mem_intf vif;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(virtual mem_intf)::get(this,"", "vif", vif))
      `uvm_fatal("Driver build","Failed to get intf")
    

  endfunction
  mem_seq_item request;
      
  virtual task run_phase(uvm_phase phase);
    
    forever begin
      seq_item_port.get_next_item(request);
      $display("DRIVER::Received below packet from sequencer");
      request.print();
      drive();
      $display("DRIVER:: Driven below packet to DUT");
      request.print(); //printing after driving to the DUT
      seq_item_port.item_done();
    end
    
  endtask
    
    virtual task drive();
      
    `DRV_INTF.addr<=0;
    `DRV_INTF.wr_en<=0;
    `DRV_INTF.rd_en<=0;
    `DRV_INTF.wdata<=0;
      @(posedge vif.clk);
      `DRV_INTF.addr<=request.addr;
    begin
        if(request.wr_en==1)
            begin
            `DRV_INTF.wdata<=request.wdata;
            `DRV_INTF.wr_en<=1'b1;
              @(posedge vif.clk);
            end
        else if(request.rd_en==1)
            begin     
            `DRV_INTF.rd_en<=1'b1;
              @(posedge vif.clk);
              @(posedge vif.clk);
              #1;
              request.rdata=`DRV_INTF.rdata;
             
              
              $display("DRIVER:: Request.rdata is %h", request.rdata);
               end
    end
 

      
      
endtask

  
endclass
