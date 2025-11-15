`define PORT 4
module testbench;
  
reg  [`PORT:0]  req;      
wire [`PORT:0]  grt;      
reg  clk, rst_;
  
  arb uut(req,grt,clk,rst_);
  
  initial begin
    clk = 0;
    forever #5 clk = ~clk ;
  end
  
  initial begin
    rst_ = 1;
    #5;
    rst_ = 0;
    req = 5'b11000;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #100;
    $finish;
  end
endmodule
