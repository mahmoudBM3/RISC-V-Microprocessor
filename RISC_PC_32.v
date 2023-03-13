/************************************************************************************************************************************************************************
 * File Description:
 * Author      : Mahmoud Sherif Mahmoud
 * Module      : PC Block
 * Level  	   : Low
 * Description : This file Contains the 32-bit PC Counter and logic for 32-bit RISC-V Micrprocessor
 * Project	   : 32-Bit RISC-V Microprocessor
 * Date 	   : 1/3/2023(March)
 ***********************************************************************************************************************************************************************/
module RISC_PC_32 (
    input reset,
    input load,
    input clk,
    input pcSrc,
    input [31:0]immExt_32,
    output reg [31:0] pc_32
    );
    /**
    This module is the Program Counter for the RISC-V Microprocessor Project, it consists of two always blocks, the first is synchronous and has an asynchronous reset,
    the first block Updates the PC Register Synchronpusly and the second Asynchronous block Calculates the next Address.
    **/
    reg [31:0] next_addr_32;
    /**The first block that is triggered with the Active Low Reset signal, and Poitive edge of the Clock, if the load signal is active then PC is updated if not then it
    stays the same 
    */
    always @(negedge reset or posedge clk)
    begin 
        if(~reset)
        pc_32<=0;
        else if(load)
        pc_32<=next_addr_32;
        else 
        pc_32<=pc_32;
    end 
    /**The combinational Always block that calculates the Next address depending on the value of the PC Source Signal
    **/
    always @(*)
    begin
        if(pcSrc)
        next_addr_32<=pc_32+immExt_32;
        else
        next_addr_32<=pc_32+3'd4;
    end 
endmodule