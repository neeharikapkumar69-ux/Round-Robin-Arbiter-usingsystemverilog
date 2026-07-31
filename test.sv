// Test class
// Creates and runs the environment

class test;//creates a test class

    // Environment handle
    environment env;

    // Virtual interface
    virtual arb_if vif;

    // Constructor
    function new(virtual arb_if vif);

        // Store interface
        this.vif = vif;

        // Create environment
        env = new(vif);

    endfunction


    // Main test task
    task run();

        // Number of transactions
        env.gen.count = 20;

        // Start verification
        env.run();

        // Wait for 60 clock cycles
      repeat(10)
            @(posedge vif.clk);

        // End simulation
        $finish;

    endtask

endclass
