// Scoreboard class
// Checks DUT output

class scoreboard;

    transaction trans;//transaction handler

    mailbox #(transaction) mon2scb;

    // Priority pointer
    logic [1:0] pointer;

    function new(mailbox #(transaction) mon2scb);

        // Connect mailbox
        this.mon2scb = mon2scb;https://www.doulos.com/events/webinars/the-rust-journey-exploring-safe-systems-programming/?source=edap
        // Start from request 0
        pointer = 2'd0;

    endfunction


    task run();

        // Expected output
        logic [3:0] expected_grant;

        forever
        begin

            // Get data from monitor
            mon2scb.get(trans);

            // Default: no grant
            expected_grant = 4'b0000;

            // Check based on pointer
            case(pointer)

                2'd0:
                begin
                    if(trans.req[0])
                    begin
                        expected_grant = 4'b0001;
                        pointer = 2'd1; // Next priority
                    end
                    else if(trans.req[1])
                    begin
                        expected_grant = 4'b0010;
                        pointer = 2'd2;
                    end
                    else if(trans.req[2])
                    begin
                        expected_grant = 4'b0100;
                        pointer = 2'd3;
                    end
                    else if(trans.req[3])
                    begin
                        expected_grant = 4'b1000;
                        pointer = 2'd0;
                    end
                end


                2'd1:
                begin
                    if(trans.req[1])
                    begin
                        expected_grant = 4'b0010;
                        pointer = 2'd2;
                    end
                    else if(trans.req[2])
                    begin
                        expected_grant = 4'b0100;
                        pointer = 2'd3;
                    end
                    else if(trans.req[3])
                    begin
                        expected_grant = 4'b1000;
                        pointer = 2'd0;
                    end
                    else if(trans.req[0])
                    begin
                        expected_grant = 4'b0001;
                        pointer = 2'd1;
                    end
                end


                2'd2:
                begin
                    if(trans.req[2])
                    begin
                        expected_grant = 4'b0100;
                        pointer = 2'd3;
                    end
                    else if(trans.req[3])
                    begin
                        expected_grant = 4'b1000;
                        pointer = 2'd0;
                    end
                    else if(trans.req[0])
                    begin
                        expected_grant = 4'b0001;
                        pointer = 2'd1;
                    end
                    else if(trans.req[1])
                    begin
                        expected_grant = 4'b0010;
                        pointer = 2'd2;
                    end
                end


                2'd3:
                begin
                    if(trans.req[3])
                    begin
                        expected_grant = 4'b1000;
                        pointer = 2'd0;
                    end
                    else if(trans.req[0])
                    begin
                        expected_grant = 4'b0001;
                        pointer = 2'd1;
                    end
                    else if(trans.req[1])
                    begin
                        expected_grant = 4'b0010;
                        pointer = 2'd2;
                    end
                    else if(trans.req[2])
                    begin
                        expected_grant = 4'b0100;
                        pointer = 2'd3;
                    end
                end

            endcase

            // Compare expected and actual
            if(expected_grant == trans.grant)

                $display("PASS : Request = %b Grant = %b",
                         trans.req,
                         trans.grant);

            else

                $display("FAIL : Request = %b Expected = %b Actual = %b",
                         trans.req,
                         expected_grant,
                         trans.grant);

        end

    endtask

endclass
