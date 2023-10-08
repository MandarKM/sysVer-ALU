/* Write a verification plan for an Arithmetic Logic Unit (ALU) with:
• Asynchronous active high input reset 
• Input clock 
• 4-bit signed inputs, A and B 
• 5-bit signed output C that is registered on the positive edge of input clock. 
• 4 opcodes
– Add: A + B 
– Sub: A − B 
– Bit-wise invert: A */



module tb;

  // Testbench signals
  reg [3:0] A, B;              // 4-bit signed inputs, A and B
  reg [1:0] opcode;            // 2-bit opcode for operations
  reg reset, clock;            // Asynchronous active high reset and input clock
  wire [4:0] C_expected;       // Expected output for comparison
  wire [4:0] C_actual;         // Actual ALU output

  // Instantiate the ALU module
  ALU uut (
    .A(A),
    .B(B),
    .opcode(opcode),
    .reset(reset),
    .clock(clock),
    .C(C_actual)
  );

  // Define test parameters
  initial begin
    $display("ALU Verification Plan");

    // Test cases
    test_case("Addition", 4'b0110, 4'b1011, 2'b00, 4'b10001);
    test_case("Subtraction", 4'b0110, 4'b1011, 2'b01, 4'b1101);
    test_case("Bit-wise Invert", 4'b0110, 4'b0000, 2'b10, 4'b1001);
    test_case("Reduction OR", 4'b0000, 4'b1011, 2'b11, 4'b1011);

    // Add more test cases as needed

    // Finish simulation
    $finish;
  end

  // Task to perform a test case
  task test_case(string operation, reg [3:0] inputA, reg [3:0] inputB, reg [1:0] op, wire [4:0] expected);
    A = inputA;
    B = inputB;
    opcode = op;
    reset = 1;
    clock = 0;
    #10 reset = 0; clock = 1;
    C_expected = expected;
    check_output(operation);
  endtask

  // Check ALU output against expected result
  task check_output(string operation);
    #20;
    if (C_actual !== C_expected) begin
      $display("Test failed: %s operation", operation);
      $display("Expected result: %b, Actual result: %b", C_expected, C_actual);
    end else begin
      $display("Test passed: %s operation", operation);
    end
  endtask

endmodule
