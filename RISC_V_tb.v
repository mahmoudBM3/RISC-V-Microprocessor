`timescale 1 ns/10 ps
module RISC_V_tb();

reg clk,areset;
integer i;

RISC_V_MP RV(.clk(clk),.areset(areset));

/*Geenerating the clock*/
always
begin
#1; clk=~clk;
end
/*Display the contents of the instruction memory*/
initial
begin
for(i=0;i<21;i=i+1)
	$display("%h",RV.INSTR_MEM_32.memoryArray[i]);
clk=0;

/*Give a reset pulse to reset the program counter to zero at Beginning of operation*/
areset=0;
#5;
areset=1;
#2000;
$stop;
end
endmodule