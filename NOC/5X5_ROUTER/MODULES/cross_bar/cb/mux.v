`include "define.sv"

module mux (
    input  [`DATAW:0] idata_0,
    input             ivalid_0,
    input  [`VCHW:0]  ivch_0,

    input  [`DATAW:0] idata_1,
    input             ivalid_1,
    input  [`VCHW:0]  ivch_1,

    input  [`DATAW:0] idata_2,
    input             ivalid_2,
    input  [`VCHW:0]  ivch_2,

    input  [`DATAW:0] idata_3,
    input             ivalid_3,
    input  [`VCHW:0]  ivch_3,

    input  [`DATAW:0] idata_4,
    input             ivalid_4,
    input  [`VCHW:0]  ivch_4,

    input  [`PORT:0]  sel,

    output [`DATAW:0] odata,
    output            ovalid,
    output [`VCHW:0]  ovch
);

assign odata =
    (sel == 5'b00001) ? idata_0 :
    (sel == 5'b00010) ? idata_1 :
    (sel == 5'b00100) ? idata_2 :
    (sel == 5'b01000) ? idata_3 :
    (sel == 5'b10000) ? idata_4 :
    {(`DATAW+1){1'b0}};

assign ovalid =
    (sel == 5'b00001) ? ivalid_0 :
    (sel == 5'b00010) ? ivalid_1 :
    (sel == 5'b00100) ? ivalid_2 :
    (sel == 5'b01000) ? ivalid_3 :
    (sel == 5'b10000) ? ivalid_4 :
    1'b0;

assign ovch =
    (sel == 5'b00001) ? ivch_0 :
    (sel == 5'b00010) ? ivch_1 :
    (sel == 5'b00100) ? ivch_2 :
    (sel == 5'b01000) ? ivch_3 :
    (sel == 5'b10000) ? ivch_4 :
    {(`VCHW+1){1'b0}};

endmodule
