/************************************************************************************************************************************************************************
 * File Description:
 * Author      : Mahmoud Sherif Mahmoud
 * Module      : Control Unit
 * Level  	   : Low
 * Description : This file Contains the Control Unit for 32-bit RISC-V Micrprocessor
 * Project	   : 32-Bit RISC-V Microprocessor
 * Date        : 8/3/2023(March)
 ***********************************************************************************************************************************************************************/
module RISC_CTRL_UNIT (
    input [31:0]instr_32,
    input ZF,
    input SF,
    output reg PCSRC,
    output reg resultSRC,
    output reg memWrite,
    output reg  [2:0]ALUControl_3,
    output reg ALUSRC,
    output reg [1:0]immSRC_2,
    output reg regWrite
);

/**Instuction Fields Definition and Assignment**/
    wire [6:0]op_7;
    wire [2:0]funct3_3;
    wire funct7;
    assign op_7=instr_32[6:0];
    assign funct3_3[2:0]=instr_32[14:12];
    assign funct7=instr_32[30];
/***Temporary Wires used inside the modeule**/
    reg branch;
    reg [1:0]ALUOP_2;
    /**Defining the different tyes of instructions as Parameters**/
    localparam LOAD_WORD= 7'b000_0011;
    localparam STORE_WORD= 7'b010_0011;
    localparam R_TYPE= 7'b011_0011;
    localparam I_TYPE= 7'b001_0011;
    localparam BRANCH_INSTR= 7'b1100011;
/**Main Decoder Always block, here the main signals from the main deccoder are updated**/
always @(*)
begin
case(op_7)
LOAD_WORD:
/**In case of Load word type of instructions**/
begin
regWrite=1'b1;
immSRC_2=2'b00;
ALUSRC=1'b1;
memWrite=1'b0;
resultSRC=1'b1;
branch=1'b0;
ALUOP_2=2'b00;
end
STORE_WORD:
/**In case of store word type of instructions**/
begin
regWrite=1'b0;
immSRC_2=2'b01;
ALUSRC=1'b1;
memWrite=1'b1;
resultSRC=1'b0;
branch=1'b0;
ALUOP_2=2'b00;
end
R_TYPE:
/**In case of R-type of instructions**/
begin
regWrite=1'b1;
immSRC_2=2'b00;
ALUSRC=1'b0;
memWrite=1'b0;
resultSRC=1'b0;
branch=1'b0;
ALUOP_2=2'b10;
end
I_TYPE:
/**In case of I-type of instructions**/
begin
regWrite=1'b1;
immSRC_2=2'b00;
ALUSRC=1'b1;
memWrite=1'b0;
resultSRC=1'b0;
branch=1'b0;
ALUOP_2=2'b10;
end
BRANCH_INSTR:
/**In case of Branch type of instructions**/
begin
regWrite=1'b0;
immSRC_2=2'b10;
ALUSRC=1'b0;
memWrite=1'b0;
resultSRC=1'b0;
branch=1'b1;
ALUOP_2=2'b01;
end
default:
begin
regWrite=1'b0;
immSRC_2=2'b00;
ALUSRC=1'b0;
memWrite=1'b0;
resultSRC=1'b0;
branch=1'b0;
ALUOP_2=2'b00;
end
endcase
end
/**The ALU Decoder Always block here the ALU control signals are updated**/
always@(*)
begin
case(ALUOP_2)
2'b00:/**LW and SW instructions**/
ALUControl_3=3'b000;

2'b01:/**BEQ BNQ BLT instructions**/
ALUControl_3=3'b010;


2'b10:/**R-Type and I-type instructions**/
case(funct3_3)
3'b000:
if(~({op_7[5],funct7}==2'b11))
ALUControl_3=3'b000;/**ADD instruction**/
else
ALUControl_3=3'b010;/**SUB instruction**/

3'b001:
ALUControl_3=3'b001;/**SHL instruction**/

3'b100:
ALUControl_3=3'b100;/**XOR instruction**/

3'b101:
ALUControl_3=3'b101;/**SHR instruction**/

3'b110:
ALUControl_3=3'b110;/**OR instruction**/

3'b111:/**AND instruction**/
ALUControl_3=3'b111;
default:
ALUControl_3=3'b000;

endcase

default:
ALUControl_3=3'b000;

endcase

end
/**This Always Block calculates The PCSRC signal which depends on the type of the branch instruction**/
always @(*)
begin
    if(branch==1'b1)
    case(funct3_3)
    3'b000:/**BEQ instruction**/
    PCSRC=ZF&branch;

    3'b001:/**BNQ instruction**/
    PCSRC=(~ZF)&branch;
    
    3'b100:/**BLT instruction**/
    PCSRC=SF&branch;
    default 
    PCSRC=0;
    endcase
    else
    PCSRC=0;
end

endmodule
