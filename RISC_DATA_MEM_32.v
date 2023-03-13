/************************************************************************************************************************************************************************
 * File Description:
 * Author      : Mahmoud Sherif Mahmoud
 * Module      : Data Memory
 * Level  	   : Low
 * Description : This file Contains the 32-bit 64 Entry Data memory for 32-bit RISC-V Micrprocessor
 * Project	   : 32-Bit RISC-V Microprocessor
 * Date        : 6/3/2023(March)
 ***********************************************************************************************************************************************************************/
module RISC_DATA_MEM_32(
input clk,
input areset,
input [31:0] addr_32,
input writeEnable,
input [31:0]writePort_32,
output reg [31:0]readPort_32
);
/**Defning the Memory Array**/
reg [31:0] memArray_32[63:0];
integer i;
/**Since writes are Synchronous this always block is triggered by the positive edge of the clock and writes on the memory entry
that corresponds to the address put on the address lines only if writeEnable is asserted**/
always @(posedge clk or negedge areset )
begin 
    if(~areset)
    for(i=0;i<63;i=i+1)
    memArray_32[i]=0;
   else if(writeEnable)
memArray_32[addr_32[31:2]]<=writePort_32;
end
/**Since reads are Asynchronous this always block updates the readPort upon any change with the entry corresponding to the address put
on the address lines if writeEnable is not asserted**/
always @(*)
begin
if(~writeEnable)
readPort_32<=memArray_32[addr_32];
else 
readPort_32<=0;
end
endmodule
