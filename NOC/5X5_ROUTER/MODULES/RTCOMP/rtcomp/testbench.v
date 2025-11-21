`timescale 1ns/1ns
`include "define.sv"

module tb_rtcomp;

    reg  [`ENTRYW:0] addr;
    reg  [`ENTRYW:0] ivch;
    reg              en;
    wire [`PORTW:0]  port;
    wire [`VCHW:0]   ovch;

    reg  [`ARRAYW:0] my_xpos;
    reg  [`ARRAYW:0] my_ypos;

    reg clk, rst_;

    // Instantiate DUT
    rtcomp dut (
        .addr(addr),
        .ivch(ivch),
        .en(en),
        .port(port),
        .ovch(ovch),
        .my_xpos(my_xpos),
        .my_ypos(my_ypos),
        .clk(clk),
        .rst_(rst_)
    );

    // Clock generation
    always #5 clk = ~clk;   // 10 ns period

    // Task to apply stimulus
    task send_route;
        input [3:0] dx, dy;   // destination X, Y
        input [3:0] mx, my;   // my X, my Y
        input        vc;
        begin
            my_xpos = mx;
            my_ypos = my;
            addr[`DSTX_MSB:`DSTX_LSB] = dx;
            addr[`DSTY_MSB:`DSTY_LSB] = dy;
            ivch = vc;
            
            en = 1;
            #10;   // wait for one cycle
            
            $display("Time=%0t | My(%0d,%0d) -> Dst(%0d,%0d) | Port=%0d | VC=%0d",
                      $time, mx, my, dx, dy, port, ovch);
        end
    endtask


    // Main test
    initial begin
        clk = 0;
        rst_ = 0;
        en = 0;
        addr = 0;
        ivch = 0;
        my_xpos = 0;
        my_ypos = 0;

        #20 rst_ = 1;   // release reset

        $display("\n--- Starting Routing Computation Test ---\n");

        // Local delivery test (same coordinates)
        send_route(2, 3, 2, 3, 1);

        // East routing (dst_x > my_x)
        send_route(5, 1, 2, 1, 0);

        // West routing (dst_x < my_x)
        send_route(1, 2, 4, 2, 1);

        // South routing (dst_y > my_y)
        send_route(3, 6, 3, 1, 0);

        // North routing (dst_y < my_y)
        send_route(2, 1, 2, 5, 0);

        // Disable en → output should hold previous value
        en = 0;
        addr = 0; ivch = 0;
        #20;
        $display("Disabled EN → Port should hold last value: %0d", port);

        $display("\n--- Test Completed ---\n");
        $finish;
    end

endmodule












# KERNEL: 
# KERNEL: --- Starting Routing Computation Test ---
# KERNEL: 
# KERNEL: Time=30 | My(2,3) -> Dst(2,3) | Port=4 | VC=1
# KERNEL: Time=40 | My(2,1) -> Dst(5,1) | Port=3 | VC=0
# KERNEL: Time=50 | My(4,2) -> Dst(1,2) | Port=1 | VC=1
# KERNEL: Time=60 | My(3,1) -> Dst(3,6) | Port=2 | VC=0
# KERNEL: Time=70 | My(2,5) -> Dst(2,1) | Port=4 | VC=0
# KERNEL: Disabled EN â†’ Port should hold last value: 4
# KERNEL: 
# KERNEL: --- Test Completed ---
# KERNEL: 
