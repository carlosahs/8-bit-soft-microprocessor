----------------------------------------------------------------------------------|
-- Company: 					ITESM - Campus Querétaro										 | 
----------------------------------------------------------------------------------|
-- Engineers:			   A00517153 Johann Palomino Galván 								 |
--								A01700885 Carlos Alberto Hurtado Sánchez						 |
--								A01366815 Jesús Dassaef López Barrios							 |
----------------------------------------------------------------------------------|
-- Create Date:    		18:35:37 03/08/2021 													 |
-- Design Name: 			None																		 |
-- Module Name:    		Dec7Seg - Behavioral 		  										 |
-- Project Name: 			RISC_CPU - Academic Project										 |
-- Target Devices: 		MAX LITE-10 FPGA Board												 |
-- Tool versions: 		Quartus Prime Lite 18.1												 |
-- Description: 			7-segment decoder for RISC CPU									 |
--																											 |
-- Dependencies: 			None																		 |
--																											 |
-- Revision: 				v1.0																		 |
-- Revision 0.01 - File Created																	 |
-- Additional Comments: None 																		 |
----------------------------------------------------------------------------------|

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Dec7Seg is
	Port ( 
		InR	: in  STD_LOGIC_VECTOR (3 downto 0);
		Seg	: out STD_LOGIC_VECTOR (7 downto 0)
	);
end Dec7Seg;

architecture Dec7Seg_Arc of Dec7Seg is
begin
   process(InR)
	begin
		case InR is
			when "0000" => Seg <= "11000000";
			when "0001" => Seg <= "11111001";
			when "0010" => Seg <= "10100100";
			when "0011" => Seg <= "10110000";
			when "0100" => Seg <= "10011001";
			when "0101" => Seg <= "10010010";
			when "0110" => Seg <= "10000010";
			when "0111" => Seg <= "11111000";
			when "1000" => Seg <= "10000000";
			when "1001" => Seg <= "10010000";
			when "1010" => Seg <= "10001000";
			when "1011" => Seg <= "10000011";
			when "1100" => Seg <= "11000110";
			when "1101" => Seg <= "10100001";
			when "1110" => Seg <= "10000110";
			when "1111" => Seg <= "10001110";
			when others =>	Seg <= "11111111";
		end case;
	end process;
end Dec7Seg_Arc;