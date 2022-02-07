----------------------------------------------------------------------------------|
-- Company: 					ITESM - Campus Querétaro										 | 
----------------------------------------------------------------------------------|
-- Engineers:			   A00517153 Johann Palomino Galván 								 |
--								A01700885 Carlos Alberto Hurtado Sánchez						 |
--								A01366815 Jesús Dassaef López Barrios							 |
----------------------------------------------------------------------------------|
-- Create Date:    		18:35:37 03/08/2021 													 |
-- Design Name: 			None																		 |
-- Module Name:    		ProgCounter - Behavioral 		  									 |
-- Project Name: 			RISC_CPU - Academic Project										 |
-- Target Devices: 		MAX LITE-10 FPGA Board												 |
-- Tool versions: 		Quartus Prime Lite 18.1												 |
-- Description: 			Program Counter for RISC CPU										 |
--																											 |
-- Dependencies: 			None																		 |
--																											 |
-- Revision: 				v1.0																		 |
-- Revision 0.01 - File Created																	 |
-- Additional Comments: None 																		 |
----------------------------------------------------------------------------------|

library ieee;
use ieee.std_logic_1164.all;
--Use IEEE.numeric_std.all;
--Use IEEE.std_logic_unsigned.all;

entity ProgCounter is
	port(
		PCIn  : in  std_logic_vector(7 downto 0);
		Clk   : in  std_logic;
		Cen   : in  std_logic;
		Rst   : in  std_logic;
		PCOut : out std_logic_vector(7 downto 0));
end ProgCounter;

architecture Behavioral of ProgCounter is

signal count_emb : std_logic_vector(7 downto 0);

begin
	process(Clk, Rst)
	begin
		if (Rst = '0') then
			count_emb <= "00000000"; -- reset program counter to 0
		elsif (rising_edge(Clk)) then
			if (Cen = '1') then
				count_emb <= PCIn;
			end if;
		end if;
	end process;

	PCOut <= count_emb;
  
end Behavioral;