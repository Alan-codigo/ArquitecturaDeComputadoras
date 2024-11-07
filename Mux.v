`timescale 1ns/1ns

module Mux(

    //inputs
    input sel,
    input [31:0] A,
    input [31:0] B,

    //outputs
    output reg[31:0] C

);

always @*
begin
    if(sel)
    begin 
        C=B;
    end
    else
    begin
        C=A;
    end
end

endmodule