module RISC_DATA_MEM_32(
input clk,
input [31:0] addr_32,
input writeEnable,
input [31:0]writePort_32,
output reg [31:0]readPort_32
);
reg [31:0] memArray_32[63:0];
always @(posedge clk)
begin 
    if(writeEnable)
memArray_32[addr_32]<=writePort_32;
end
always @(*)
begin
if(~writeEnable)
readPort_32<=memArray_32[addr_32];
else 
readPort_32<=0;
end
endmodule
