`timescale 1ns/1ns

module tb_dp;

reg [31:0] instruciontb;

Datapath dataPathIntance(
    .instruction(instruciontb)
);

integer i;
reg [31:0] setIntruction [0:20];

initial 
    begin
        $readmemb("32instructions.txt", setIntruction);

        for(i = 0; i < 20; i = i + 1)
            begin
                instruciontb = setIntruction[i];
                #10;

            end
        
        $finish;
        
    end

endmodule