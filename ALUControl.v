`timescale 1ns/1ns

module ALUControl(
    
    //inputs
    input [2:0] UnitControlRequest,
    input [5:0] funct,
    
    //outputs
    output reg[2:0] OpALU
);

always @*
begin
    case (UnitControlRequest)
        //type r
        3'b000:
        begin
            case(funct)
                6'b100000:
                begin
                    //ADD
                    OpALU = 3'b001;

                end

                6'b100010:
                begin
                    //SUB
                    OpALU = 3'b010;
                end

                6'b101010:
                begin
                    //SLT
                    OpALU = 3'b011;
                end

                6'b100100:
                begin
                    //AND
                    OpALU = 3'b100;
                end

                6'b100101:
                begin
                    //OR
                    OpALU = 3'b101;

                end

                6'b100110:
                begin
                    //XOR
                    OpALU = 3'b110;
                end

                6'b100111:
                begin
                    //NOR
                    OpALU = 3'b111;

                end

            endcase
        end  
    endcase 
end

endmodule