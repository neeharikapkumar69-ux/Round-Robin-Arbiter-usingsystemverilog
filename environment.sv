// Environment class
// Connects all verification components

class environment;

    // Component handles
    generator gen;//used to access generator object
    driver drv;//used to send i/p to dut
    monitor mon;//observes the dut signals
    scoreboard scb;//checks the o/p of dut 

    // Virtual interface handler
    virtual arb_if vif;

    // Mailboxes
    mailbox #(transaction) gen2drv;
    mailbox #(transaction) mon2scb;

    // Constructor

    function new(virtual arb_if vif);

        this.vif = vif;

        // Create mailboxes
        gen2drv = new();
        mon2scb = new();

        // Create components
        gen = new(gen2drv);
        drv = new(vif, gen2drv);
        mon = new(vif, mon2scb);
        scb = new(mon2scb);

    endfunction


    // Run all components togther

    task run();

        fork 

            gen.run();
            drv.run();
            mon.run();
            scb.run();

        join_none//Doesn't wait for the tasks to finish.

    endtask

endclass
