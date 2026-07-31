// Interface connects the DUT and the testbench
//declares input-outputs

interface arb_if(input logic clk);  //arb is arbiter

    // Reset signal
    logic rst;

    // Request input to DUT
    logic [3:0] req;

    // Grant output from DUT
    logic [3:0] grant;

endinterface
