`timescale 1ns/1ps
`include "define.sv"

module tb_cb;

    reg clk, rst_;

    reg  [`DATAW:0] idata_0, idata_1, idata_2, idata_3, idata_4;
    reg             ivalid_0, ivalid_1, ivalid_2, ivalid_3, ivalid_4;
    reg  [`VCHW:0]  ivch_0, ivch_1, ivch_2, ivch_3, ivch_4;

    reg  [`PORTW:0] port_0, port_1, port_2, port_3, port_4;
    reg             req_0, req_1, req_2, req_3, req_4;

    wire [`DATAW:0] odata_0, odata_1, odata_2, odata_3, odata_4;
    wire            ovalid_0, ovalid_1, ovalid_2, ovalid_3, ovalid_4;
    wire [`VCHW:0]  ovch_0, ovch_1, ovch_2, ovch_3, ovch_4;

    // DUT
    cb dut (
        .idata_0(idata_0), .ivalid_0(ivalid_0), .ivch_0(ivch_0),
        .idata_1(idata_1), .ivalid_1(ivalid_1), .ivch_1(ivch_1),
        .idata_2(idata_2), .ivalid_2(ivalid_2), .ivch_2(ivch_2),
        .idata_3(idata_3), .ivalid_3(ivalid_3), .ivch_3(ivch_3),
        .idata_4(idata_4), .ivalid_4(ivalid_4), .ivch_4(ivch_4),

        .port_0(port_0), .req_0(req_0), .grt_0(),
        .port_1(port_1), .req_1(req_1), .grt_1(),
        .port_2(port_2), .req_2(req_2), .grt_2(),
        .port_3(port_3), .req_3(req_3), .grt_3(),
        .port_4(port_4), .req_4(req_4), .grt_4(),

        .odata_0(odata_0), .ovalid_0(ovalid_0), .ovch_0(ovch_0),
        .odata_1(odata_1), .ovalid_1(ovalid_1), .ovch_1(ovch_1),
        .odata_2(odata_2), .ovalid_2(ovalid_2), .ovch_2(ovch_2),
        .odata_3(odata_3), .ovalid_3(ovalid_3), .ovch_3(ovch_3),
        .odata_4(odata_4), .ovalid_4(ovalid_4), .ovch_4(ovch_4),

        .clk(clk),
        .rst_(rst_)
    );
  
      initial begin
        clk = 0;
        forever #5 clk = ~clk;
      end



//     ======================================================
//     DEBUG MONITOR : SEL + REQUESTS
//     ======================================================
    always @(posedge clk) begin
      $display("[%0t] sel0=%b sel1=%b sel2=%b sel3=%b sel4=%b | req0=%b req1=%b req2=%b req3=%b req4=%b",$time,dut.cb_sel_0, dut.cb_sel_1, dut.cb_sel_2, dut.cb_sel_3, dut.cb_sel_4,req_0, req_1, req_2, req_3, req_4);
    end


    // ======================================================
    // OUTPUT MONITORS
    // ======================================================
    always @(posedge clk) if (ovalid_0) $display(">>> OUT0 : %h", odata_0);
    always @(posedge clk) if (ovalid_1) $display(">>> OUT1 : %h", odata_1);
    always @(posedge clk) if (ovalid_2) $display(">>> OUT2 : %h", odata_2);
    always @(posedge clk) if (ovalid_3) $display(">>> OUT3 : %h", odata_3);
    always @(posedge clk) if (ovalid_4) $display(">>> OUT4 : %h", odata_4);


    // ======================================================
    // SEND PACKET TASK
    // ======================================================
    task send_packet(input int inport, input int outport);
        begin
          $display("\nSending packet IN = %0d → OUT = %0d", inport, outport);

            // Head
            case(inport)
                0: begin req_0=1; port_0=outport; ivalid_0=1; idata_0=35'h111000001; end
                1: begin req_1=1; port_1=outport; ivalid_1=1; idata_1=35'h111000001; end
                2: begin req_2=1; port_2=outport; ivalid_2=1; idata_2=35'h111000001; end
                3: begin req_3=1; port_3=outport; ivalid_3=1; idata_3=35'h111000001; end
                4: begin req_4=1; port_4=outport; ivalid_4=1; idata_4=35'h111000001; end
            endcase
            @(posedge clk);

            // Body
            case(inport)
                0: idata_0=35'h111000002;
                1: idata_1=35'h111000002;
                2: idata_2=35'h111000002;
                3: idata_3=35'h111000002;
                4: idata_4=35'h111000002;
            endcase
            @(posedge clk);

            // Tail
            case(inport)
                0: idata_0=35'h111000003;
                1: idata_1=35'h111000003;
                2: idata_2=35'h111000003;
                3: idata_3=35'h111000003;
                4: idata_4=35'h111000003;
            endcase
            @(posedge clk);

            // Deassert
            case(inport)
                0: begin req_0=0; ivalid_0=0; end
                1: begin req_1=0; ivalid_1=0; end
                2: begin req_2=0; ivalid_2=0; end
                3: begin req_3=0; ivalid_3=0; end
                4: begin req_4=0; ivalid_4=0; end
            endcase
        end
    endtask


    // ======================================================
    // MAIN TEST
    // ======================================================

    initial begin

        rst_ = 0;

        {idata_0,idata_1,idata_2,idata_3,idata_4} = 0;
        {ivalid_0,ivalid_1,ivalid_2,ivalid_3,ivalid_4} = 0;
        {port_0,port_1,port_2,port_3,port_4} = 0;
        {req_0,req_1,req_2,req_3,req_4} = 0;

        @(posedge clk);
        rst_ = 1;
        $display("RESET DEASSERTED\n");

        @(posedge clk);

        // TESTCASE 1
        $display("====================================");
        $display("     TESTCASE 1 : IN → OUT        ");
        $display("====================================");
        send_packet(0, 2);
        $display("-------------------------------------------------------------------------------------------------------------------");
     	send_packet(3, 3);
		$display("-------------------------------------------------------------------------------------------------------------------");



        $finish;
    end

endmodule



https://www.edaplayground.com/x/MTYn



