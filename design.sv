// Code your design here
// Code your design here

// 4-Request Round Robin Arbiter
// Grants one requester at a time in a fair round-robin order

module round_robin_arbiter (

    input  logic       clk,      // clock
    input  logic       rst,      // reset
    input  logic [3:0] req,      // inputs
    output logic [3:0] grant     // grant output

);

    // Current priority pointer
    //Who has the highest priority now
    logic [1:0] pointer;

    // Next priority pointer
    //This separates combinational logic from sequential logic, which is good hardware design practice
    logic [1:0] next_pointer;


    // Sequential block
    // Updates the pointer on every clock edge

    always_ff @(posedge clk or posedge rst)
    begin
        if (rst)
            pointer <= 2'd0;          // Start from requester 0
        else
            pointer <= next_pointer;  // Update pointer
    end


    // Combinational block
    // Generates grant and next pointer

    always_comb
    begin

        // Default values
        grant        = 4'b0000;
        next_pointer = pointer;

        case (pointer)
          
            //the four rquests are 00,01,10,11
            // Check requesters in the order 0 → 1 → 2 → 3
        
            2'd0:
            begin
                if (req[0])
                begin
                    grant        = 4'b0001;
                    next_pointer = 2'd1;
                end
                else if (req[1])
                begin
                    grant        = 4'b0010;
                    next_pointer = 2'd2;
                end
                else if (req[2])
                begin
                    grant        = 4'b0100;
                    next_pointer = 2'd3;
                end
                else if (req[3])
                begin
                    grant        = 4'b1000;
                    next_pointer = 2'd0;
                end
            end


            // Check requesters in the order 1 → 2 → 3 → 0

            2'd1:
            begin
                if (req[1])
                begin
                    grant        = 4'b0010;
                    next_pointer = 2'd2;
                end
                else if (req[2])
                begin
                    grant        = 4'b0100;
                    next_pointer = 2'd3;
                end
                else if (req[3])
                begin
                    grant        = 4'b1000;
                    next_pointer = 2'd0;
                end
                else if (req[0])
                begin
                    grant        = 4'b0001;
                    next_pointer = 2'd1;
                end
            end


            // Check requesters in the order 2 → 3 → 0 → 1

            2'd2:
            begin
                if (req[2])
                begin
                    grant        = 4'b0100;
                    next_pointer = 2'd3;
                end
                else if (req[3])
                begin
                    grant        = 4'b1000;
                    next_pointer = 2'd0;
                end
                else if (req[0])
                begin
                    grant        = 4'b0001;
                    next_pointer = 2'd1;
                end
                else if (req[1])
                begin
                    grant        = 4'b0010;
                    next_pointer = 2'd2;
                end
            end


            // Check requesters in the order 3 → 0 → 1 → 2

            2'd3:
            begin
                if (req[3])
                begin
                    grant        = 4'b1000;
                    next_pointer = 2'd0;
                end
                else if (req[0])
                begin
                    grant        = 4'b0001;
                    next_pointer = 2'd1;
                end
                else if (req[1])
                begin
                    grant        = 4'b0010;
                    next_pointer = 2'd2;
                end
                else if (req[2])
                begin
                    grant        = 4'b0100;
                    next_pointer = 2'd3;
                end
            end


            // Default case

            default:
            begin
                grant        = 4'b0000;
                next_pointer = 2'd0;
            end

        endcase

    end

endmodule
