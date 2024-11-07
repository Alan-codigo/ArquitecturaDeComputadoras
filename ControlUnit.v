`timescale 1ns/1ns

module ControlUnit(

    //inputs
    input [5:0] OpCode,
    output reg BR_En,
    output reg [2:0] AluC,
    output reg EnW,
    output reg EnR,
    output reg Mux1

);

always @*
begin 
    case (OpCode)
        6'b000000: //type R
            begin 

                BR_En = 1'b1;
                AluC = 3'b000;
                EnW = 1'b0;
                EnR = 1'b0;
                Mux1 = 1'b1;

            end
    endcase
end

endmodule