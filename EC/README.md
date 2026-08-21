Elevator Controller Using Verilog HDL
Overview

This project implements a 4-Floor Elevator Controller using Verilog HDL.

The elevator controller is designed using a Finite State Machine (FSM) to control the movement of an elevator between different floors. It accepts floor requests, determines the required direction, moves the elevator to the requested floor, and controls the elevator door.

The project demonstrates the practical application of digital logic, FSM design, counters, sequential circuits, and Verilog HDL simulation.

Objectives
Design an elevator controller using Verilog HDL.
Control elevator movement between four floors.
Accept floor-selection requests.
Determine the direction of elevator movement.
Stop the elevator at the requested floor.
Control door opening and closing.
Implement reset functionality.
Verify the design using a Verilog testbench.
Analyze the simulation waveform.
Features
4-floor elevator system.
Up and down movement.
Floor request input.
Current-floor indication.
Door open control.
Door close control.
Idle state when there is no request.
FSM-based control.
Synthesizable Verilog design.
Simulation and waveform verification.
Block Diagram
                   Floor Request
                        │
                        ▼
              +---------------------+
              |                     |
              | Elevator Controller |
              |       FSM           |
              |                     |
              +----------+----------+
                         │
              +----------+----------+
              │          │          │
              ▼          ▼          ▼
           Move Up     Stop      Move Down
                         │
                         ▼
                   Door Control
                         │
                         ▼
                  Current Floor

Elevator Floors

The system contains four floors:

        +---------+
Floor 4 |         |
        +---------+
           ↑ ↓
        +---------+
Floor 3 |         |
        +---------+
           ↑ ↓
        +---------+
Floor 2 |         |
        +---------+
           ↑ ↓
        +---------+
Floor 1 |         |
        +---------+

Working Principle

The controller continuously monitors the current floor and the requested floor.

When a floor request is received, the controller compares the requested floor with the current floor.

If requested floor is higher

The elevator moves upward:

Current Floor < Requested Floor

        MOVE_UP
           ↓
     Requested Floor
           ↓
          STOP
           ↓
       DOOR OPEN
           ↓
      DOOR CLOSE
           ↓
          IDLE

If requested floor is lower

The elevator moves downward:

Current Floor > Requested Floor

        MOVE_DOWN
            ↓
      Requested Floor
            ↓
           STOP
            ↓
        DOOR OPEN
            ↓
       DOOR CLOSE
            ↓
           IDLE

If requested floor is the current floor

The elevator does not move and directly opens the door:

Current Floor = Requested Floor

        IDLE
          ↓
      DOOR OPEN
          ↓
     DOOR CLOSE
          ↓
        IDLE

FSM States

The elevator controller can be implemented using the following states:

State	Description
IDLE	Elevator is waiting for a request
MOVE_UP	Elevator is moving upward
MOVE_DOWN	Elevator is moving downward
DOOR_OPEN	Elevator door is open
DOOR_CLOSE	Elevator door is closing
Example Operation

Suppose the elevator starts at Floor 1 and the user requests Floor 4.

The sequence is:

Floor 1
   ↓
MOVE UP
   ↓
Floor 2
   ↓
MOVE UP
   ↓
Floor 3
   ↓
MOVE UP
   ↓
Floor 4
   ↓
STOP
   ↓
DOOR OPEN
   ↓
DOOR CLOSE
   ↓
IDLE


If the elevator is at Floor 4 and the user requests Floor 2:

Floor 4
   ↓
MOVE DOWN
   ↓
Floor 3
   ↓
MOVE DOWN
   ↓
Floor 2
   ↓
STOP
   ↓
DOOR OPEN
   ↓
DOOR CLOSE
   ↓
IDLE

Inputs
Signal	Width	Description
clk	1 bit	System clock
reset	1 bit	Resets elevator to initial state
request_floor	2 bits	Requested floor
Outputs
Signal	Width	Description
current_floor	2 bits	Current elevator floor
move_up	1 bit	Indicates upward movement
move_down	1 bit	Indicates downward movement
door_open	1 bit	Indicates door-open condition
Floor Encoding

The four floors can be represented using 2-bit values:

Floor	Binary
Floor 1	00
Floor 2	01
Floor 3	10
Floor 4	11
Project Structure
elevator-controller-verilog/
│
├── README.md
│
├── rtl/
│   └── elevator_controller.v
│
├── tb/
│   └── elevator_controller_tb.v
│
├── simulation/
│   └── elevator_waveform.png
│
└── docs/
    └── project_report.pdf

Simulation

The project can be simulated using Icarus Verilog and the output waveform can be viewed using GTKWave.

Compile
iverilog -o elevator_sim rtl/elevator_controller.v tb/elevator_controller_tb.v

Run
vvp elevator_sim


The testbench generates a VCD waveform file.

Open Waveform
gtkwave elevator.vcd


Add the following signals in GTKWave:

clk
reset
request_floor
current_floor
move_up
move_down
door_open

Expected Simulation

For example, when the elevator starts at Floor 1 and receives a request for Floor 4:

Request Floor = 4

Floor 1 → Floor 2 → Floor 3 → Floor 4
                              ↓
                         Door Open
                              ↓
                         Door Close


The expected output is:

move_up    = 1 while moving upward
move_down  = 0 while moving upward
door_open  = 0 while moving

At requested floor:

move_up    = 0
move_down  = 0
door_open  = 1


After the door closes, the controller returns to the IDLE state.

Verification

The testbench should verify:

Reset operation.
Request from Floor 1 to Floor 2.
Request from Floor 1 to Floor 4.
Request from Floor 4 to Floor 1.
Request to the current floor.
Upward movement.
Downward movement.
Door operation.
Return to the idle state.
Applications

Elevator control systems are used in:

Residential buildings
Office buildings
Shopping malls
Hospitals
Hotels
Parking structures
Industrial buildings
Advantages
Simple FSM-based architecture.
Easy to understand and simulate.
Synthesizable Verilog design.
Suitable for FPGA implementation.
Demonstrates real-world digital control concepts.
Can be expanded to support more floors.
Future Improvements

The project can be extended by adding:

8 or more floors.
Multiple simultaneous floor requests.
Request priority management.
Seven-segment display.
Door obstruction detection.
Emergency stop.
Overload detection.
Alarm system.
Multiple elevator cars.
Seven-segment current-floor display.
FPGA hardware implementation.
Technologies Used
Verilog HDL
Icarus Verilog
GTKWave
Git
GitHub
Conclusion

This project demonstrates the design and simulation of a 4-Floor Elevator Controller using Verilog HDL.

The controller uses a Finite State Machine to manage elevator movement, floor selection, stopping, and door operation. The design is verified using a Verilog testbench, and the resulting signals can be analyzed using GTKWave.

This project provides practical experience in RTL design, FSMs, sequential logic, digital control systems, simulation, and hardware design.

Author

Your Name

Digital Electronics / VLSI / FPGA Project

License

This project is intended for educational and learning purposes.