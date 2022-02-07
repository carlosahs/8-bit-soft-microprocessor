`timescale 1ns / 1ps
//--------------------------------------------------------------------------------
// Company: ITESM - Campus Qro.
// Engineer: RickWare
// 
// Create Date:    16:29:16 03/03/2021 
// Design Name: 
// Module Name:     
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Verilog - Memory Component Declaration
//----------------------------------------------------------------------------------

module Mem ( input  [7:0] Addr,
         	 output [3:0] DataOp,
				 output [2:0] Datars,
				 output [2:0] Datart,
				 output [2:0] Datard,
				 output [7:0] Datai);

  // Declaration of a Memory 256 locations, each 21-bits wide
  reg [20:0] IMem [0:255];
  
  // Memory Data bus
  wire [20:0] Data;

  // Fill the memory with the hexadecimal code found in file "romh.data" created
  // by Fabian's assembler program
  initial $readmemh("romh.data", IMem);
  
  // Read a Memory address
  assign Data = IMem[Addr];  
  
  // Split up Data into its indivudual signals to used by other components
  assign DataOp = Data [20:17];  // Opcode
  assign Datars = Data [16:14];  // Address of the rs register
  assign Datart = Data [13:11];  // Address of the rt register
  assign Datard = Data [10: 8];  // Address of the rd register
  assign Datai  = Data [ 7: 0];  // immediate value
  

endmodule
