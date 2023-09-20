interface mem_intf(input logic clk, reset);
  
  
  logic [2:0] addr;
  logic wr_en;
  logic rd_en;
  logic [7:0] rdata;
  logic[7:0] wdata;
  
  
   
  clocking driver_cb @(posedge clk);

    output addr;
    output wr_en;
    output rd_en;
    output wdata;
    input rdata;
  endclocking
  
  clocking monitor_cb @(posedge clk);

    input wdata;
    input rdata;
    input addr;
    input wr_en;
    input rd_en;
  endclocking
  
  modport drv_mp (clocking driver_cb, input clk, input reset);
    modport mon_mp (clocking monitor_cb, input clk, input reset);
  
  
  
  
endinterface
