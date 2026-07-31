// Transaction class
// generator to driver communication occurs through transaction
// monitor to scoreboard also occurs through transaction
// Stores one set of input and output values

class transaction;

    // Randomisation 
    rand logic [3:0] req;

    // Grant from DUT
    logic [3:0] grant;

    // Generates only valid requests
    constraint req_c   //usage of constraint
    {
      req inside {[4'b0001:4'b1111]}; //we use the inside operator
      // inside operator checks whether a value belongs to a specified set or range
    }

    // Display transaction

    function void display(string name);

        $display("--------------------------------");

        $display("%s", name);
        $display("Request = %b", req);
        $display("Grant   = %b", grant);

        $display("--------------------------------");

    endfunction

endclass
