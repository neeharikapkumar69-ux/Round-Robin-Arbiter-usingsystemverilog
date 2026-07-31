// Generator class
//generator : it creates valid data transactions
//mailbox carries the message frm generator to driver 
// Generates random transactions

class generator;

    // Transaction handle is created
    transaction trans;

    // Mailbox sends data to driver
    mailbox #(transaction) gen2drv;

    // Number of transactions
    int count;

    // Constructor
    function new(mailbox #(transaction) gen2drv);
        this.gen2drv = gen2drv;
    endfunction

    // Main task

    task run();

        repeat(count)
        begin
            // Creating a new transaction
            trans = new();

            // Randomizing the request
            assert(trans.randomize())
            else
              $fatal(1,"Randomization Failed");

            //To display generated values
            trans.display("Generator");

            //this is sent to the driver
            gen2drv.put(trans);
        end

        $display("Generator Finished");

    endtask

endclass
