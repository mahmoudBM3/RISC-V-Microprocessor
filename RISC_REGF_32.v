module RISC_REGF_32(
    input clk,
    input writeEnable,
    input [4:0]readAddr1_5,
    input [4:0]readAddr2_5,
    input [4:0]writeAddr_5,
    input [31:0]writePort_32,
    output reg [31:0]readPort1_32,
    output reg [31:0]readPort2_32
);
reg [31:0]regArray_32[31:0];
always @(posedge clk)
begin 
if(writeEnable)
    begin
        regArray_32[writeAddr_5]<=writePort_32;
    end
end
always @(*)
begin
    readPort1_32<=regArray_32[readAddr1_5];
    readPort2_32<=regArray_32[readAddr2_5];
end
endmodule
