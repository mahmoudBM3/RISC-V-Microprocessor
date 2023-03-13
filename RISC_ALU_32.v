/************************************************************************************************************************************************************************
 * File Description:
 * Author      : Mahmoud Sherif Mahmoud
 * Module      : Arithmetic Logic Unit
 * Level  	   : Low
 * Description : This file Contains the 32-bit ALU for 32-bit RISC-V Micrprocessor
 * Project	   : 32-Bit RISC-V Microprocessor
 * Date 	   : 1/3/2023(March)
 ***********************************************************************************************************************************************************************/
module RISC_ALU_32 (
    input [2:0] selLines_3,
    input [31:0] inport1_32,
    input [31:0] inport2_32,
    output reg outZF,
    output reg  outSF,
    output reg [31:0] outport_32
);
/*
*Defining the operations as local parameters
*/
localparam ADD =3'b000;
localparam SHL =3'b001;
localparam SUB =3'b010;
localparam XOR =3'b100;
localparam SHR =3'b101;
localparam OR  =3'b110;
localparam AND =3'b111;
/*
*Defining a temporary 33-bit wire to store the result of the operation 
before outputting the actual result and calculating the flags4
*/
reg [32:0]tempout_33;
always @(*)
begin 
    /*
    Multiplexing the select lines and depending on its value the corresponding
    result is put on the temporary wires to calculate the final output and 
    flags
    */
    case(selLines_3)
    ADD:    tempout_33<=inport1_32+inport2_32;
    SHL:    tempout_33<=inport1_32<<inport2_32;
    SUB:    tempout_33<=inport1_32-inport2_32;
    XOR:    tempout_33<=inport1_32^inport2_32;
    SHR:    tempout_33<=inport1_32>>inport2_32;
    OR:     tempout_33<=inport1_32||inport2_32;
    AND:    tempout_33<=inport1_32&&inport2_32;
    default:tempout_33<=0;
    endcase
    outport_32<=tempout_33[31:0];
    outZF<=~(|outport_32);
    outSF<=tempout_33[32];
end 
endmodule