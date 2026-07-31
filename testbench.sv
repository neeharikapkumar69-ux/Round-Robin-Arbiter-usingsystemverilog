// Code your testbench here
// or browse Examples
// Top testbench
// Connects the DUT and verification environment
`include "interface.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"

module testbench;

    // Clock signal
    logic clk;

    // Create interface
    arb_if vif(clk);

    // Test handle
    test t;

    // Instantiate the DUT

    round_robin_arbiter dut (

        .clk   (clk),
        .rst   (vif.rst),
        .req   (vif.req),
        .grant (vif.grant)

    );


    // Clock generation
    // Clock period = 10 ns

    initial
    begin
        clk = 0;

        forever
            #5 clk = ~clk;
    end


    // Apply reset

    initial
    begin

        vif.rst = 1'b1;
        vif.req = 4'b0000;

        #20;

        vif.rst = 1'b0;

    end


    // Create and start test

    initial
    begin

        t = new(vif);

        t.run();

    end


    // Display waveform

    initial
    begin

        $dumpfile("dump.vcd");
        $dumpvars;

    end

endmodule
