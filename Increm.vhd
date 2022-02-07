----------------------------------------------------------------------------------|
-- Company: 					ITESM - Campus Querétaro										 | 
----------------------------------------------------------------------------------|
-- Engineers:			   A00517153 Johann Palomino Galván 								 |
--								A01700885 Carlos Alberto Hurtado Sánchez						 |
--								A01366815 Jesús Dassaef López Barrios							 |
----------------------------------------------------------------------------------|
-- Create Date:    		18:35:37 03/08/2021 													 |
-- Design Name: 			None																		 |
-- Module Name:    		Increm - Behavioral 		  											 |
-- Project Name: 			RISC_CPU - Academic Project										 |
-- Target Devices: 		MAX LITE-10 FPGA Board												 |
-- Tool versions: 		Quartus Prime Lite 18.1												 |
-- Description: 			MUX 2 to 1 8-bit for RISC CPU 									 |
--																											 |
-- Dependencies: 			None																		 |
--																											 |
-- Revision: 				v1.0																		 |
-- Revision 0.01 - File Created																	 |
-- Additional Comments: None 																		 |
----------------------------------------------------------------------------------|

library ieee;
use ieee.std_logic_1164.all;

entity Increm is
	port(InA  : in  std_logic_vector(7 downto 0);
		InB  : in  std_logic_vector(7 downto 0);
		Sel  : in  std_logic;
		M    : out std_logic_vector(7 downto 0));
end Increm;

architecture Behavioral of Increm is

begin
	process(Sel)
	begin
		--	Determines which operation is passed down to the Emb
		case Sel is
			when '1' =>	M <= InB; -- read 1
			when '0' =>	M <= InA; -- read immediate 8 bits
		end case;
	end process;
end Behavioral;
