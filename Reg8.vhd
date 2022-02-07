----------------------------------------------------------------------------------|
-- Company: 					ITESM - Campus Querétaro										 | 
----------------------------------------------------------------------------------|
-- Engineers:			   A00517153 Johann Palomino Galván 								 |
--								A01700885 Carlos Alberto Hurtado Sánchez						 |
--								A01366815 Jesús Dassaef López Barrios							 |
----------------------------------------------------------------------------------|
-- Create Date:    		18:35:37 03/08/2021 													 |
-- Design Name: 			None																		 |
-- Module Name:    		Reg8 - Behavioral 		  					   					 |
-- Project Name: 			RISC_CPU - Academic Project										 |
-- Target Devices: 		MAX LITE-10 FPGA Board												 |
-- Tool versions: 		Quartus Prime Lite 18.1												 |
-- Description: 			8-bit register P.I.P.O. for RISC CPU							 |
--																											 |
-- Dependencies: 			None																		 |
--																											 |
-- Revision: 				v1.0																		 |
-- Revision 0.01 - File Created																	 |
-- Additional Comments: None 																		 |
----------------------------------------------------------------------------------|

Library IEEE;
USE  IEEE.STD_LOGIC_1164.ALL;

ENTITY Reg8 IS
	PORT(	
		Inrs	: in 	std_logic_vector(7 downto 0);
		Clk	: in 	std_logic;
		CEn	: in 	std_logic;
		Rst	: in 	std_logic;
		En		: in 	std_logic;
		OutD	: out	std_logic_vector(7 downto 0)
	);
END Reg8;

ARCHITECTURE Reg8_Arc OF Reg8 IS
	signal data : std_logic_vector(7 downto 0);
	
BEGIN
	process(Rst, Clk)
	begin
		if (Rst = '0') then
			data <= (others => '0');
		elsif (falling_edge(Clk)) then
			if (CEn = '1') then
				if (En = '1') then
					data <= Inrs;
				end if;
			end if;
		end if;
	end process;

	OutD <= data;
	
END Reg8_Arc;	