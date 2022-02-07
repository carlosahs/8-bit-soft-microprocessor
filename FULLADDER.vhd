----------------------------------------------------------------------------------|
-- Company: 					ITESM - Campus Querétaro										 | 
----------------------------------------------------------------------------------|
-- Engineers:			   A00517153 Johann Palomino Galván 								 |
--								A01700885 Carlos Alberto Hurtado Sánchez						 |
--								A01366815 Jesús Dassaef López Barrios							 |
----------------------------------------------------------------------------------|
-- Create Date:    		18:35:37 03/08/2021 													 |
-- Design Name: 			None																		 |
-- Module Name:    		FULLADDER - Behavioral 		  										 |
-- Project Name: 			RISC_CPU - Academic Project										 |
-- Target Devices: 		MAX LITE-10 FPGA Board												 |
-- Tool versions: 		Quartus Prime Lite 18.1												 |
-- Description: 			Full Adder for RISC CPU												 |
--																											 |
-- Dependencies: 			None																		 |
--																											 |
-- Revision: 				v1.0																		 |
-- Revision 0.01 - File Created																	 |
-- Additional Comments: None 																		 |
----------------------------------------------------------------------------------|

Library IEEE;

Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use IEEE.std_logic_unsigned.all;

ENTITY FULLADDER IS
PORT(	
	InA	: IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
	InB	: IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);	
	S		: OUT	STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END FULLADDER;

ARCHITECTURE FULLADDER_ARC OF FULLADDER IS

	signal SUM      : std_logic_vector(7 downto 0);
	signal result_s : std_logic_vector(8 downto 0);

BEGIN
	
	-- Suma
	
	result_s <= ('0' & InA) + ('0' & InB);
	SUM      <= result_s(7 downto 0);
	
	S <= SUM;
	
END FULLADDER_ARC;	