/************************************************************************************************************************************************************************
 * File Description:
 * Author      : Mahmoud Sherif Mahmoud
 * Module      : Register File
 * Level  	   : Low
 * Description : This file Contains the 32-bit 32 Register Register File for 32-bit RISC-V Micrprocessor
 * Project	   : 32-Bit RISC-V Microprocessor
 * Date        : 6/3/2023(March)
 ***********************************************************************************************************************************************************************/
module RISC_REGF_32(
    input clk,
    input areset,
    input writeEnable,
    input [4:0]readAddr1_5,
    input [4:0]readAddr2_5,
    input [4:0]writeAddr_5,
    input [31:0]writePort_32,
    output reg [31:0]readPort1_32,
    output reg [31:0]readPort2_32
);
/**Defining the Array of Registers of the register file**/
reg [31:0]regArray_32[31:0];
integer i;
initial
	begin
	for(i=0;i<32;i=i+1)
		regArray_32[i]=0;	
	end 	
/**The Writes are Synchronous and they are done in this Always block if writeEnable is asserted**/
always @(posedge clk or negedge areset)
begin 
    if (~areset)
    for(i=0;i<32;i=i+1)
    regArray_32[i]=0;
    else if(writeEnable)
    begin
        regArray_32[writeAddr_5]<=writePort_32;
    end
end
/**The reads are Asynchronous so thaey are done hear in this always block but since there is only one single address bus that the reads
and writes share, so the read is only is only done if write enable is not asserted**/
always @(*)
begin
    readPort1_32<=regArray_32[readAddr1_5];
    readPort2_32<=regArray_32[readAddr2_5];
end
endmodule
