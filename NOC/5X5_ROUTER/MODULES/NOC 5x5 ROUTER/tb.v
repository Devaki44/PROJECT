`timescale 1ns/1ps
`include "define.h"

module tb_router;

    // ------------------------------------------
    // VCD DUMP (GTKWave)
    // ------------------------------------------
    initial begin
        $dumpfile("router.vcd");
        $dumpvars(0, tb_router);
    end

    // ------------------------------------------
    // CLOCK & RESET
    // ------------------------------------------
    reg clk;
    reg rst_;

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_ = 0;
        #15;
        rst_ = 1;
    end

    // ------------------------------------------
    // INPUT PORTS (5 INPUTS)
    // ------------------------------------------
    reg [`DATAW:0] idata_0, idata_1, idata_2, idata_3, idata_4;
    reg            ivalid_0,ivalid_1,ivalid_2,ivalid_3,ivalid_4;
    reg [`VCHW:0]  ivch_0,ivch_1,ivch_2,ivch_3,ivch_4;

    wire [`VCH:0]  oack_0,oack_1,oack_2,oack_3,oack_4;
    wire [`VCH:0]  ordy_0,ordy_1,ordy_2,ordy_3,ordy_4;
    wire [`VCH:0]  olck_0,olck_1,olck_2,olck_3,olck_4;

    // ------------------------------------------
    // OUTPUT PORTS (5 OUTPUTS)
    // ------------------------------------------
    wire [`DATAW:0] odata_0,odata_1,odata_2,odata_3,odata_4;
    wire            ovalid_0,ovalid_1,ovalid_2,ovalid_3,ovalid_4;
    wire [`VCHW:0]  ovch_0,ovch_1,ovch_2,ovch_3,ovch_4;

    reg  [`VCH:0]   iack_0,iack_1,iack_2,iack_3,iack_4;
    reg  [`VCH:0]   ilck_0,ilck_1,ilck_2,ilck_3,ilck_4;

    // ------------------------------------------
    // ROUTER POSITION
    // ------------------------------------------
    reg [`ARRAYW:0] my_xpos, my_ypos;


    // ------------------------------------------
    // INITIALIZATION
    // ------------------------------------------
    initial begin
        idata_0 = 0; idata_1 = 0; idata_2 = 0; idata_3 = 0; idata_4 = 0;
        ivalid_0= 0; ivalid_1= 0; ivalid_2= 0; ivalid_3= 0; ivalid_4= 0;
        ivch_0  = 0; ivch_1  = 0; ivch_2  = 0; ivch_3  = 0; ivch_4  = 0;

        iack_0 = 2'b11; iack_1 = 2'b11; iack_2 = 2'b11; iack_3 = 2'b11; iack_4 = 2'b11;
        ilck_0 = 0;     ilck_1 = 0;     ilck_2 = 0;     ilck_3 = 0;     ilck_4 = 0;

        my_xpos = 1;    // router X coordinate
        my_ypos = 1;    // router Y coordinate

        $display("Router Testbench Initialized.");
    end

    // ------------------------------------------
    // DUT INSTANTIATION
    // ------------------------------------------
    router #(.ROUTERID(1)) DUT (
        idata_0, ivalid_0, ivch_0, oack_0, ordy_0, olck_0,
        idata_1, ivalid_1, ivch_1, oack_1, ordy_1, olck_1,
        idata_2, ivalid_2, ivch_2, oack_2, ordy_2, olck_2,
        idata_3, ivalid_3, ivch_3, oack_3, ordy_3, olck_3,
        idata_4, ivalid_4, ivch_4, oack_4, ordy_4, olck_4,

        odata_0, ovalid_0, ovch_0, iack_0, ilck_0,
        odata_1, ovalid_1, ovch_1, iack_1, ilck_1,
        odata_2, ovalid_2, ovch_2, iack_2, ilck_2,
        odata_3, ovalid_3, ovch_3, iack_3, ilck_3,
        odata_4, ovalid_4, ovch_4, iack_4, ilck_4,

        my_xpos, my_ypos,
        clk, rst_
    );

    // ------------------------------------------
    // FUNCTION: CREATE A FLIT
    // ------------------------------------------
    function [`DATAW:0] make_flit;
        input [3:0] dst_xy;
        input [3:0] src_xy;
        input [1:0] vch;
	input [21:0] spec;
        input [2:0] ftype;
        begin
            make_flit = {ftype,      // 34:32
		         spec,       // 10:31
                         vch,        // 9:8
                         src_xy,     // 7:4
                         dst_xy};    // 3:0
        end
    endfunction

    // ------------------------------------------
    // TASK: SEND PACKET (3-flit packet)
    // ------------------------------------------
    task send_packet;
        input integer port;
        input [3:0] dst;
        input [3:0] src;
        integer k;
        begin
            // HEAD
            case(port)


                0: begin idata_0 = make_flit(dst, src, 2'b0,22'ha,`TYPE_HEAD); ivalid_0 = 1;			
			$display("idata_0 = %b ",idata_0);
		   end
	        1: begin idata_1 = make_flit(dst, src, 2'b0,22'hb,`TYPE_HEAD); ivalid_1 = 1;					       		$display("idata_1 = %b ",idata_1);
		   end
	        2: begin idata_2 = make_flit(dst, src, 2'b0,22'hc,`TYPE_HEAD); ivalid_2 = 1;					       		$display("idata_2 = %b ",idata_2);
		   end
		3: begin idata_3 = make_flit(dst, src, 2'b0,22'hd, `TYPE_HEAD); ivalid_3 = 1;					       		$display("idata_3 = %b ",idata_3);
		   end
		4: begin idata_4 = make_flit(dst, src, 2'b0,22'he, `TYPE_HEAD); ivalid_4 = 1;			
	       		$display("idata_4 = %b ",idata_4);
		   end


            endcase
            @(posedge clk);

            // DATA
            for (k = 0; k < 1; k = k + 1) begin
                case(port)
			0:begin  idata_0 = make_flit(dst, src ,2'b0,22'ha,`TYPE_DATA);
			  	$display("idata_0 = %b ",idata_0);
			  end
			1:begin  idata_1 = make_flit(dst, src, 2'b0,22'hb, `TYPE_DATA);
			  	$display("idata_1 = %b ",idata_1);
			  end
			2:begin  idata_2 = make_flit(dst, src, 2'b0,22'hc, `TYPE_DATA);
			  	$display("idata_2 = %b ",idata_2);
			  end
			3:begin  idata_3 = make_flit(dst, src, 2'b0,22'hd, `TYPE_DATA);
			  	$display("idata_3 = %b ",idata_3);
			  end
			4:begin  idata_4 = make_flit(dst, src, 2'b0,22'he, `TYPE_DATA);
			  	$display("idata_4 = %b ",idata_4);
			  end

			
                endcase
                @(posedge clk);
            end

            // TAIL
            case(port)
                0: begin idata_0 = make_flit(dst, src, 2'b0,22'ha, `TYPE_TAIL); ivalid_0 = 1;
	       		$display("idata_0 = %b ",idata_0);	
		   end
		1: begin idata_1 = make_flit(dst, src, 2'b0,22'hb, `TYPE_TAIL);ivalid_1 = 1;
	       		$display("idata_1 = %b ",idata_1);
		   end
		2: begin idata_2 = make_flit(dst, src, 2'b0,22'hc, `TYPE_TAIL); ivalid_2 = 1;
	       		$display("idata_2 = %b ",idata_2);	
		   end
		3: begin idata_3 = make_flit(dst, src, 2'b0,22'hd, `TYPE_TAIL); ivalid_3 = 1;
	       		$display("idata_3 = %b ",idata_3);
		   end
		4: begin idata_4 = make_flit(dst, src,  2'b0,22'he, `TYPE_TAIL); ivalid_4 = 1;
	       		$display("idata_4 = %b ",idata_4);
		   end


       	    endcase
        end
    endtask

    // ------------------------------------------
    // STIMULUS
    // ------------------------------------------
    initial begin
        wait(rst_ == 1);
        $display("----- TEST STARTED -----");


	// send_packet(port,dst_addr,scr_addr)
	send_packet(0, 4'b0001, 4'h5);  // to output port 0 (NORTH)
	send_packet(1, 4'b0110, 4'h1);  // to output port 1 (EAST)
	send_packet(2, 4'b1001, 4'h4);  // to output port 2 (SOUTH)
	send_packet(3, 4'b0101, 4'h6);  // to output port 3 (WEST)
	send_packet(4, 4'b0101, 4'h9);  // to output port 4 (LOCAL)
    
        repeat(20) @(posedge clk);

        $display("----- TEST FINISHED -----");
        $finish;
    end


endmodule
