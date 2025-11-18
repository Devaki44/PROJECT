`timescale 1ns/1ps


module testbench;

reg  [`DATAW:0] idata_0, idata_1, idata_2, idata_3, idata_4;
reg             ivalid_0, ivalid_1, ivalid_2, ivalid_3, ivalid_4;
reg  [`VCHW:0]  ivch_0, ivch_1, ivch_2, ivch_3, ivch_4;

reg  [`PORT:0]  sel;

wire [`DATAW:0] odata;
wire            ovalid;
wire [`VCHW:0]  ovch;

mux dut (
    idata_0, ivalid_0, ivch_0,
    idata_1, ivalid_1, ivch_1,
    idata_2, ivalid_2, ivch_2,
    idata_3, ivalid_3, ivch_3,
    idata_4, ivalid_4, ivch_4,
    sel,
    odata, ovalid, ovch
);

initial begin
    idata_0 = 8'h10; ivalid_0 = 1; ivch_0 = 1;
    idata_1 = 8'h21; ivalid_1 = 1; ivch_1 = 0;
    idata_2 = 8'h32; ivalid_2 = 1; ivch_2 = 1;
    idata_3 = 8'h43; ivalid_3 = 1; ivch_3 = 0;
    idata_4 = 8'h54; ivalid_4 = 1; ivch_4 = 1;

    sel = 5'b00001;
    #1;
    assert(odata == idata_0 && ovalid == ivalid_0 && ovch == ivch_0)
        else $error("TEST FAILED: sel=00001");

    sel = 5'b00010;
    #1;
    assert(odata == idata_1 && ovalid == ivalid_1 && ovch == ivch_1)
        else $error("TEST FAILED: sel=00010");

    sel = 5'b00100;
    #1;
    assert(odata == idata_2 && ovalid == ivalid_2 && ovch == ivch_2)
        else $error("TEST FAILED: sel=00100");

    sel = 5'b01000;
    #1;
    assert(odata == idata_3 && ovalid == ivalid_3 && ovch == ivch_3)
        else $error("TEST FAILED: sel=01000");

    sel = 5'b10000;
    #1;
    assert(odata == idata_4 && ovalid == ivalid_4 && ovch == ivch_4)
        else $error("TEST FAILED: sel=10000");

    sel = 5'b00000;
    #1;
    assert(ovalid == 0)
        else $error("TEST FAILED: default case");

    $display("ALL TESTS PASSED");
    $finish;
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,testbench);
end

endmodule
