`timescale 1ns/1ns

module RecordBank(

    //inputs

    input EnW,
    input [4:0] AR1,
    input [4:0] AR2,
    input [4:0] AW,
    input [31:0] DW,

    //outputs
    output reg [31:0] DR1,
    output reg [31:0] DR2
);

    reg [31:0] RecordBank [0:31];

    initial 
        begin
            $readmemb("rbdata.txt", RecordBank);  // Cargar datos desde el archivo
        end

    always @* 
    begin
        if (EnW) 
        begin 
            RecordBank[AW] = DW; 
        end

        // Leer valores de los registros
        DR1 = RecordBank[AR1];
        DR2 = RecordBank[AR2];
    end

endmodule
