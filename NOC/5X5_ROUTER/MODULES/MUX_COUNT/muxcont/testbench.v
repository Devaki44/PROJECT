`timescale 1ns/1ps
`define PORT 4
`define PORTW 2    

module testbench;

reg  [`PORTW:0] port_0;   
reg             req_0;    

reg  [`PORTW:0] port_1;   
reg             req_1;    

reg  [`PORTW:0] port_2;   
reg             req_2;    

reg  [`PORTW:0] port_3;   
reg             req_3;    

reg  [`PORTW:0] port_4;   
reg             req_4;    

wire [`PORT:0]  sel; 
wire [`PORT:0]  grt; 

reg clk, rst_;


muxcont #(.PORTID(0)) uut (
        .port_0 (port_0),   
        .req_0  (req_0),

        .port_1 (port_1),   
        .req_1  (req_1),

        .port_2 (port_2),   
        .req_2  (req_2),

        .port_3 (port_3),   
        .req_3  (req_3),

        .port_4 (port_4),   
        .req_4  (req_4),

        .sel    (sel),
        .grt    (grt),

        .clk    (clk),
        .rst_   (rst_)
);


always begin
    clk = 0;
    forever #5 clk = ~clk;
end
  
initial begin
    rst_ = 1;
    #10 rst_ = 0;
end

initial begin

    port_0 = 0; req_0 = 0;
    port_1 = 0; req_1 = 0;
    port_2 = 0; req_2 = 0;
    port_3 = 0; req_3 = 0;
    port_4 = 0; req_4 = 0;

    @(negedge rst_);

    #10;
    port_2 = 0; req_2 = 1; 

    #20;
    req_2 = 0;           

   
    #20;
    port_1 = 0; req_1 = 1;
    port_3 = 0; req_3 = 1;

    #20;
    req_1 = 0;
    req_3 = 0;

    #20;
    port_4 = 0; req_4 = 1;   

    #20;
    port_0 = 0; req_0 = 1;   

    #20;
    req_4 = 0;               

    #20;
    req_0 = 0;

    #50;
    $finish;
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,testbench);
end

endmodule
