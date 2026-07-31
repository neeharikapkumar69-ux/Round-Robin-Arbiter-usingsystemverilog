// Monitor class
// Monitors the DUT outputs

class monitor;

    // Transaction handle
    transaction trans;

    // Virtual interface
    virtual arb_if vif;

    // Mailbox to send data to scoreboard
    mailbox #(transaction) mon2scb;

    // Constructor

    function new(virtual arb_if vif,
                 mailbox #(transaction) mon2scb);

        this.vif = vif;
        this.mon2scb = mon2scb;

    endfunction


    // Main task

    task run();

        forever
        begin

            // Wait for positive edge of clock
            @(posedge vif.clk);

            // Wait for DUT outputs to update
            #1;

            // Create a new transaction
            trans = new();

            // Capture DUT signals
            trans.req   = vif.req;
            trans.grant = vif.grant;

            // Check for a valid request
            if (trans.req != 4'b0000)
            begin
                // Display monitored values
                trans.display("Monitor");

                // Send transaction to scoreboard
                mon2scb.put(trans);
            end

        end

    endtask

endclass
