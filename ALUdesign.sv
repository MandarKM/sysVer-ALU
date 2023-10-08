/*Design for Write a verifi cation plan for an Arithmetic Logic Unit (ALU) with:
• Asynchronous active high input reset 
• Input clock 
• 4-bit signed inputs, A and B 
• 5-bit signed output C that is registered on the positive edge of input clock. 
• 4 opcodes
– Add: A + B 
– Sub: A − B 
– Bit-wise invert: A 
– Reduction Or: B */
module ALU (
    input wire [3:0] A, // 4-bit input A
    input wire [3:0] B, // 4-bit input B
    input wire [1:0] opcode, // 2-bit opcode for operations
    input wire reset, // Asynchronous active high reset
    input wire clock, // Input clock
    output reg [4:0] C // 5-bit signed output C (registered on positive edge of clock)
);

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            // Reset condition
            C <= 0;
        end else begin
            // ALU operations based on opcode
            case(opcode)
                2'b00: // Add
                    C <= A + B;
                2'b01: // Subtract
                    C <= A - B;
                2'b10: // Bit-wise Invert (A)
                    C <= ~A;
                2'b11: // Reduction OR (B)
                    C <= |B;
                default:
                    C <= 0; // Default to 0 for invalid opcodes
            endcase
        end
    end

endmodule

