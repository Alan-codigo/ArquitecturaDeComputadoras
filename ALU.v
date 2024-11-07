`timescale 1ns/1ns

module ALU(
    
    //inputs
    input [31:0] DR1,
    input [31:0] DR2,
    input [2:0] ALUControl,

    //outputs
    output reg[31:0] ALUOutput
);
// add, sub, slt, and, or, xor, nor
always @*
begin
    case (ALUControl)

        //ADD
        3'b001:
        begin
            ALUOutput = DR1 + DR2;
        end  

        //SUB
        3'b010:
        begin
            ALUOutput = DR1 - DR2;
        end

        //SLT
        3'b011:
        begin
            ALUOutput = DR1 > DR2 ? 1 : 0;
        end

        //AND
        3'b100:
        begin
            ALUOutput = DR1 & DR2;
        end

        //OR
        3'b101:
        begin
            ALUOutput = DR1 | DR2;
        end

        //XOR
        3'b110:
        begin
            ALUOutput = DR1 ^ DR2;
        end

        //NOR
        3'b111:
        begin
            ALUOutput = ~(DR1 | DR2);
        end

    endcase 
end


endmodule
