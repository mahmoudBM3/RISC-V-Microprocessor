/************************************************************************************************************************************************************************
 * File Description:
 * Author      : Mahmoud Sherif Mahmoud
 * Module      : Instruction Memory
 * Level  	   : Low
 * Description : This file Contains the 32-bit 64 entry Instruction memory for 32-bit RISC-V Micrprocessor
 * Project	   : 32-Bit RISC-V Microprocessor
 * Date        : 3/3/2023(March)
 ***********************************************************************************************************************************************************************/
module RISC_INSTR_MEM_32(
    input [31:0] instrAddr_32,
    output reg [31:0] readData_32
);
/**Defining the Memory array**/
reg [31:0] memoryArray [63:0];
//integer i;
/**initializing all of the memory entries to 0**/
initial 
begin
/**for(i=0;i<64;i=i+1)
memoryArray[i]<=0;*/
$readmemh("code.txt",memoryArray,0,20);
end
/**This memory is asynchronous so depending on the address which comes from the PC the corresponding entry is put on the Output**/
always @(*)
begin 
readData_32=memoryArray[instrAddr_32/4];
end
endmodule
