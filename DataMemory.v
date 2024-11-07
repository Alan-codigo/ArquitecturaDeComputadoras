`timescale 1ns/1ns

module DataMemory(
    
    //inputs
    input [31:0] DataIn,
    input EnW,
    input EnR,

    //outputs
    output reg [31:0] DW

);

reg [31:0] DataMemory [0:3];

always @*
begin
    if(EnW)
    begin
        DataMemory[1] = DataIn;
    end
    else if(EnR)
    begin
        DW = DataMemory[1];
    end
end

endmodule