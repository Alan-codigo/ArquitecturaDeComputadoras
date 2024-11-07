`timescale 1ns/1ns

module Datapath(

    //inputs
    input [31:0] instruction
);

//wires to Control Unit
wire [5:0]instruction_to_Control_Unit;

//wires to RecordBank
wire [4:0] instruction_to_rb_ar1;
wire [4:0] instruction_to_rb_ar2;
wire [4:0] instruction_to_rb_aw;
wire ControlUnit_to_rb_enw;
wire [31:0] mux_to_rb_dw;

//wires to ALU
wire [31:0] rb_to_alu_dr1;
wire [31:0] rb_to_alu_dr2;
wire [2:0] alucontrol_to_alu_opalu;

//wires to ALU Control
wire [2:0] controlunit_to_alucontrol_type;
wire [5:0] instruction_to_alucontrol_funct;

//wires to DataMemory
wire [31:0] alu_to_datamemory_data;
wire controlunit_to_datamemory_enw;
wire controlunit_to_datamemory_enr;

//wires to Mux
wire controlunit_to_mux;
wire [31:0] datamemory_to_mux_datain;
wire [31:0] alu_to_mux_dataint;

//instances

ControlUnit controlUnitInstance(
    .OpCode(instruction[31:26]),
    
    .BR_En(ControlUnit_to_rb_enw),
    .AluC(controlunit_to_alucontrol_type),
    .EnW(controlunit_to_datamemory_enw),
    .EnR(controlunit_to_datamemory_enr),
    .Mux1(controlunit_to_mux)
);

ALUControl ALUContolInstance(
    .UnitControlRequest(controlunit_to_alucontrol_type),
    .funct(instruction[5:0]),
    
    .OpALU(alucontrol_to_alu_opalu)
);

RecordBank RecordBankInstance(
    .EnW(ControlUnit_to_rb_enw),
    .AR1(instruction[25:21]),
    .AR2(instruction[20:16]),
    .AW(instruction[15:11]),
    .DW(mux_to_rb_dw),

    .DR1(rb_to_alu_dr1),
    .DR2(rb_to_alu_dr2)
);

ALU ALUinstance(
    .DR1(rb_to_alu_dr1),
    .DR2(rb_to_alu_dr2),
    .ALUControl(alucontrol_to_alu_opalu),

    .ALUOutput(alu_to_datamemory_data)
);


DataMemory DataMemoryInstance(
    .DataIn(alu_to_datamemory_data),
    .EnW(controlunit_to_datamemory_enw),
    .EnR(controlunit_to_datamemory_enr),

    .DW(datamemory_to_mux_datain)
);

Mux muxInstance(
    .sel(controlunit_to_mux),
    .A(datamemory_to_mux_datain),
    .B(alu_to_datamemory_data),

    .C(mux_to_rb_dw)
);


endmodule