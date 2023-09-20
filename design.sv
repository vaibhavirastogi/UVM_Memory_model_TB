module memory (input clk, input reset, input [2:0]addr, input [7:0]wdata, input wr_en, input rd_en, output [7:0]rdata);

  reg [7:0] mem [8];
  reg [7:0] rdata;

  always@(posedge clk)
    begin
      if(wr_en)
        mem[addr] <= wdata;
    end

always @(posedge clk)
  begin
    if (rd_en) rdata <= mem[addr];
  end

  initial
    begin
      for(int i=0; i<8; i++)
        mem[i] = 'hca;
    end

endmodule
