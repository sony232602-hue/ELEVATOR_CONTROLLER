//============================================================
// Project    : 4-Floor Elevator Controller
// File       : elevator_controller_tb.v
// Description: Testbench for Elevator Controller
//============================================================

`timescale 1ns/1ps

module elevator_controller_tb;

    //========================================================
    // Testbench Signals
    //========================================================

    reg        clk;
    reg        reset;
    reg [1:0]  request_floor;

    wire [1:0] current_floor;
    wire       move_up;
    wire       move_down;
    wire       door_open;

    //========================================================
    // Instantiate Elevator Controller
    //========================================================

    elevator_controller uut (
        .clk           (clk),
        .reset         (reset),
        .request_floor (request_floor),
        .current_floor (current_floor),
        .move_up       (move_up),
        .move_down     (move_down),
        .door_open     (door_open)
    );

    //========================================================
    // Clock Generation
    // 10 ns clock period
    //========================================================

    initial begin
        clk = 1'b0;

        forever #5 clk = ~clk;
    end

    //========================================================
    // Test Sequence
    //========================================================

    initial begin

        // Generate VCD waveform
        $dumpfile("elevator.vcd");
        $dumpvars(0, elevator_controller_tb);

        //====================================================
        // Reset
        //====================================================

        reset = 1'b1;
        request_floor = 2'b00;

        #20;

        reset = 1'b0;

        //====================================================
        // Test 1: Floor 1 -> Floor 4
        //====================================================

        $display("---------------------------------------");
        $display("TEST 1: Floor 1 -> Floor 4");
        $display("---------------------------------------");

        request_floor = 2'b11;

        #100;

        //====================================================
        // Test 2: Floor 4 -> Floor 2
        //====================================================

        $display("---------------------------------------");
        $display("TEST 2: Floor 4 -> Floor 2");
        $display("---------------------------------------");

        request_floor = 2'b01;

        #100;

        //====================================================
        // Test 3: Floor 2 -> Floor 1
        //====================================================

        $display("---------------------------------------");
        $display("TEST 3: Floor 2 -> Floor 1");
        $display("---------------------------------------");

        request_floor = 2'b00;

        #100;

        //====================================================
        // Test 4: Floor 1 -> Floor 3
        //====================================================

        $display("---------------------------------------");
        $display("TEST 4: Floor 1 -> Floor 3");
        $display("---------------------------------------");

        request_floor = 2'b10;

        #100;

        //====================================================
        // Test 5: Request Current Floor
        //====================================================

        $display("---------------------------------------");
        $display("TEST 5: Request Current Floor");
        $display("---------------------------------------");

        request_floor = 2'b10;

        #50;

        //====================================================
        // End Simulation
        //====================================================

        $display("---------------------------------------");
        $display(" Elevator Controller Simulation Complete");
        $display("---------------------------------------");

        $finish;

    end

    //========================================================
    // Monitor
    //========================================================

    initial begin

        $monitor(
            "Time=%0t ns | Reset=%b | Request=%0d | Current=%0d | UP=%b | DOWN=%b | DOOR=%b",
            $time,
            reset,
            request_floor + 1,
            current_floor + 1,
            move_up,
            move_down,
            door_open
        );

    end

endmodule
