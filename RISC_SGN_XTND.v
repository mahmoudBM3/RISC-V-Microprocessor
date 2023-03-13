/************************************************************************************************************************************************************************
 * File Description:
 * Author      : Mahmoud Sherif Mahmoud
 * Module      : Control Unit
 * Level  	   : Low
 * Description : This file Contains the Sign Extend Unit for 32-bit RISC-V Micrprocessor
 * Project	   : 32-Bit RISC-V Microprocessor
 * Date        : 8/3/2023(March)
 ***********************************************************************************************************************************************************************/
module RISC_SGN_XTND (
    input [31:0]instr_32,
    input [1:0]immSRC_2,
    output reg [31:0]immExt_32
);
    always@(*)
    begin 
        case(immSRC_2)
        2'b00:/**I-type Instruction**/
        immExt_32={{20{instr_32[31]}},instr_32[31:20]};
        2'b01:/**S-type Instruction**/
        immExt_32={{20{instr_32[31]}},instr_32[31:25],instr_32[11:7]};
        2'b10:/**B-type Instruction**/
        immExt_32={{20{instr_32[31]}},instr_32[7],instr_32[30:25],instr_32[11:8],1'b0};
        default:
        immExt_32=0;

        endcase
    end
endmodule
