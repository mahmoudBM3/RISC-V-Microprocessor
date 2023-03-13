/************************************************************************************************************************************************************************
 * File Description:
 * Author      : Mahmoud Sherif Mahmoud
 * Module      : RISC-V Processor Top Module
 * Level  	   : Medium
 * Description : This file Contains the Top Module for 32-bit RISC-V Micrprocessor
 * Project	   : 32-Bit RISC-V Microprocessor
 * Date        : 9/3/2023(March)
 ***********************************************************************************************************************************************************************/

module RISC_V_MP (
    input clk,
    input areset
);
/**ALU Ports**/
wire [2:0] ALU_selLines_3;
wire [31:0] ALU_inPort1_32;
wire [31:0] ALU_inPort2_32;
wire ALU_ZF;
wire ALU_SF;
wire [31:0] ALU_outPort_32;
/**CTRL_UNIT Ports**/
wire [2:0]CTRL_ALUControl_3;
wire CTRL_regWrite;
wire [1:0] CTRL_immSrc;
wire CTRL_memWrite;
wire CTRL_PCSRC;
wire CTRL_resultSRC;
wire CTRL_ALUSRC;
/**INSTR_MEM**/
wire [31:0]instr_32;
/**PC Ports**/
wire [31:0] PC;
wire PC_load;
/**Sign Extend Ports**/
wire [31:0]immExt_32;
/**DATA_MEM Ports**/
wire[31:0]DATA_readPort_32;
/**REG_FILE Ports**/
wire[31:0]REGF_readPort2_32;
wire[31:0]result;
/**Main modules Instantiation**/
RISC_ALU_32 ALU(ALU_selLines_3,ALU_inPort1_32,ALU_inPort2_32,ALU_ZF,ALU_SF,ALU_outPort_32);
/**CTRL**/
RISC_CTRL_UNIT CTRL_UNIT(instr_32,ALU_ZF,ALU_SF,CTRL_PCSRC,CTRL_resultSRC,CTRL_memWrite,ALU_selLines_3,CTRL_ALUSRC,CTRL_immSrc,CTRL_regWrite);
/**DATA_MEM Ports**/
RISC_DATA_MEM_32 DATA_MEM(clk,areset,ALU_outPort_32,CTRL_memWrite,REGF_readPort2_32,DATA_readPort_32);
/**Instruction Memory Module**/
RISC_INSTR_MEM_32 INSTR_MEM_32(PC,instr_32);
/**Program Counter Module**/
RISC_PC_32 PC_32(areset,PC_load,clk,CTRL_PCSRC,immExt_32,PC);
/**Register File Module**/
RISC_REGF_32 REGF_32(clk,areset,CTRL_regWrite,instr_32[19:15],instr_32[24:20],instr_32[11:7],result,ALU_inPort1_32,REGF_readPort2_32);
/**Sign Extend Module**/
RISC_SGN_XTND SGN_XTND(instr_32,CTRL_immSrc,immExt_32);
/**Assignments**/
assign PC_load=1'b1;
assign ALU_inPort2_32=CTRL_ALUSRC? immExt_32:REGF_readPort2_32;
assign result = CTRL_resultSRC?DATA_readPort_32:ALU_outPort_32;
endmodule