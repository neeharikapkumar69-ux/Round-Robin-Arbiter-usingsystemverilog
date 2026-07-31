// Driver class
// Drives input signals to the DUT

class driver;

    // Transaction handle
    transaction trans;

    // Virtual interface is created
    //Connects the Driver class to the DUT interface
    virtual arb_if vif;

    // Mailbox to receive data from generator
    mailbox #(transaction) gen2drv;

    // Constructor

    function new(virtual arb_if vif,
                 mailbox #(transaction) gen2drv);

        this.vif = vif;
        this.gen2drv = gen2drv;

    endfunction


    // Main task

task run();

    wait(vif.rst==0);

    forever
    begin

        gen2drv.get(trans);

        @(posedge vif.clk);

        vif.req <= trans.req;

        trans.display("Driver");

        @(posedge vif.clk);

        vif.req <= 4'b0000;

    end

endtask

endclass
