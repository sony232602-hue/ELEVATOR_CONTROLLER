//============================================================
// Project    : 4-Floor Elevator Controller
// File       : elevator_controller.v
// Description: FSM-based elevator controller using Verilog HDL
//============================================================

`timescale 1ns/1ps

module elevator_controller (
    input  wire       clk,
    input  wire       reset,

    // Requested floor
    // 00 = Floor 1
    // 01 = Floor 2
    // 10 = Floor 3
    // 11 = Floor 4
    input  wire [1:0] request_floor,

    // Outputs
    output reg  [1:0] current_floor,
    output reg        move_up,
    output reg        move_down,
    output reg        door_open
);

    //========================================================
    // State Declaration
    //========================================================

    localparam IDLE      = 3'b000;
    localparam MOVE_UP   = 3'b001;
    localparam MOVE_DOWN = 3'b010;
    localparam DOOR_OPEN = 3'b011;
    localparam DOOR_CLOSE= 3'b100;

    reg [2:0] state;
    reg [2:0] next_state;

    //========================================================
    // State Register
    //========================================================

    always @(posedge clk) begin
        if (reset) begin
            state         <= IDLE;
            current_floor <= 2'b00;   // Start at Floor 1
        end
        else begin
            state <= next_state;
        end
    end

    //========================================================
    // Next-State Logic
    //========================================================

    always @(*) begin

        next_state = state;

        case (state)

            //================================================
            // IDLE STATE
            //================================================
            IDLE: begin

                if (request_floor > current_floor)
                    next_state = MOVE_UP;

                else if (request_floor < current_floor)
                    next_state = MOVE_DOWN;

                else
                    next_state = DOOR_OPEN;

            end

            //================================================
            // MOVE UP
            //================================================
            MOVE_UP: begin

                if (current_floor < request_floor)
                    next_state = MOVE_UP;
                else
                    next_state = DOOR_OPEN;

            end

            //================================================
            // MOVE DOWN
            //================================================
            MOVE_DOWN: begin

                if (current_floor > request_floor)
                    next_state = MOVE_DOWN;
                else
                    next_state = DOOR_OPEN;

            end

            //================================================
            // DOOR OPEN
            //================================================
            DOOR_OPEN: begin
                next_state = DOOR_CLOSE;
            end

            //================================================
            // DOOR CLOSE
            //================================================
            DOOR_CLOSE: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end

        endcase
    end

    //========================================================
    // Current Floor Logic
    //========================================================

    always @(posedge clk) begin

        if (reset) begin
            current_floor <= 2'b00;
        end

        else begin

            case (state)

                MOVE_UP: begin
                    if (current_floor < request_floor)
                        current_floor <= current_floor + 2'b01;
                end

                MOVE_DOWN: begin
                    if (current_floor > request_floor)
                        current_floor <= current_floor - 2'b01;
                end

                default: begin
                    current_floor <= current_floor;
                end

            endcase

        end
    end

    //========================================================
    // Output Logic
    //========================================================

    always @(*) begin

        // Default outputs
        move_up   = 1'b0;
        move_down = 1'b0;
        door_open = 1'b0;

        case (state)

            MOVE_UP: begin
                move_up = 1'b1;
            end

            MOVE_DOWN: begin
                move_down = 1'b1;
            end

            DOOR_OPEN: begin
                door_open = 1'b1;
            end

            default: begin
                move_up   = 1'b0;
                move_down = 1'b0;
                door_open = 1'b0;
            end

        endcase

    end

endmodule
