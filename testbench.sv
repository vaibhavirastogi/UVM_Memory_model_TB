`include "mem_test.sv"
//`include "mem_test.sv"
//`include "design.sv"
`include "mem_interface.sv"

module top;
  
  bit clk;
  bit reset;
  
  always #2 clk = ~clk;
  
  initial begin
    reset=0;
    #1 reset=1;
  end
  
  initial begin
    run_test("mem_test");
  end
  
  //instantiate interface
  
  mem_intf intf(clk, reset);
  memory mem(.clk(clk), .reset(reset), .addr(intf.addr), .wdata(intf.wdata), .wr_en(intf.wr_en), .rd_en(intf.rd_en), .rdata(intf.rdata));
  
  //instantiate DUT
  
  //set config_db
  
  initial begin
    uvm_config_db#(virtual mem_intf)::set(uvm_root::get(), "*", "vif", intf);
    
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  
endmodule
