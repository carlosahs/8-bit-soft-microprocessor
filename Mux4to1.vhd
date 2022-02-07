----------------------------------------------------------------------------------|
-- Company: 					ITESM - Campus Querétaro										 | 
----------------------------------------------------------------------------------|
-- Engineers:			   A00517153 Johann Palomino Galván 								 |
--								A01700885 Carlos Alberto Hurtado Sánchez						 |
--								A01366815 Jesús Dassaef López Barrios							 |
----------------------------------------------------------------------------------|
-- Create Date:    		18:35:37 03/08/2021 													 |
-- Design Name: 			None																		 |
-- Module Name:    		Mux4to1 - Behavioral 		  										 |
-- Project Name: 			RISC_CPU - Academic Project										 |
-- Target Devices: 		MAX LITE-10 FPGA Board												 |
-- Tool versions: 		Quartus Prime Lite 18.1												 |
-- Description: 			Mux 4 to 1 8-bit for RISC CPU										 |
--																											 |
-- Dependencies: 			None																		 |
--																											 |
-- Revision: 				v1.0																		 |
-- Revision 0.01 - File Created																	 |
-- Additional Comments: None 																		 |
----------------------------------------------------------------------------------|

library ieee;
use ieee.std_logic_1164.all;

entity Mux4to1 is
	port(
		InA : in  std_logic_vector(7 downto 0);
		InB : in  std_logic_vector(7 downto 0);
		InC : in  std_logic_vector(7 downto 0);
		InD : in  std_logic_vector(7 downto 0);
		Sel : in  std_logic_vector(1 downto 0);
		M   : out std_logic_vector(7 downto 0));
end Mux4to1;

architecture Behavioral of Mux4to1 is

--constant InD : std_logic_vector(7 downto 0) := "00000000"; -- 0 constant signal to fill 2^2 inputs

begin
	process(Sel)
	begin
		case Sel is
			when "00"   => M <= InA; -- read program counter increment
			when "01"   => M <= InB; -- read rs
			when "10"   => M <= InC; -- read immediate 8 bits
			when "11"   => M <= InD; -- read 0
			when others => M <= InA; -- OTHERS -> normal
		end case;
	end process;

end Behavioral;