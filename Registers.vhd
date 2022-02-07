----------------------------------------------------------------------------------|
-- Company: 					ITESM - Campus Querétaro										 | 
----------------------------------------------------------------------------------|
-- Engineers:			   A00517153 Johann Palomino Galván 								 |
--								A01700885 Carlos Alberto Hurtado Sánchez						 |
--								A01366815 Jesús Dassaef López Barrios							 |
----------------------------------------------------------------------------------|
-- Create Date:    		18:35:37 03/08/2021 													 |
-- Design Name: 			None																		 |
-- Module Name:    		Registers - Behavioral 		  										 |
-- Project Name: 			RISC_CPU - Academic Project										 |
-- Target Devices: 		MAX LITE-10 FPGA Board												 |
-- Tool versions: 		Quartus Prime Lite 18.1												 |
-- Description: 			Registers for RISC CPU												 |
--																											 |
-- Dependencies: 			None																		 |
--																											 |
-- Revision: 				v1.0																		 |
-- Revision 0.01 - File Created																	 |
-- Additional Comments: None 																		 |
----------------------------------------------------------------------------------|

Library IEEE;
USE  IEEE.STD_LOGIC_1164.ALL;

ENTITY Registers IS
	PORT(	
		SelA		: in	std_logic_vector(2 downto 0);
		SelB		: in	std_logic_vector(2 downto 0);
		SelWR		: in	std_logic_vector(2 downto 0);
		Data		: in	std_logic_vector(7 downto 0);
		Clk		: in 	std_logic;
		CEn 		: in 	std_logic;
		Rst		: in 	std_logic;
		WE			: in 	std_logic;
		OutA 		: out	std_logic_vector(7 downto 0);
		OutB		: out std_logic_vector(7 downto 0)
	);
END Registers;

ARCHITECTURE Registers_Arc OF Registers IS
	
	signal R0, R1, R2, R3, R4, R5, R6, R7	: std_logic_vector(7 downto 0);
	signal OutA_Emb, OutB_Emb 					: std_logic_vector(7 downto 0);
	
	signal auxiliary_emb                   : std_logic_vector(7 downto 0);
	signal auxiliary_emb_2                 : std_logic_vector(7 downto 0);
	
BEGIN

	process(Rst, Clk, CEn,SelWR,SelA,SelB)
	
	begin
		if (Rst = '0') then 
			R0	<= (others => '0');
			R1	<= (others => '0');
			R2	<= (others => '0');
			R3	<= (others => '0');
			R4	<= (others => '0');
			R5	<= (others => '0');
			R6	<= (others => '0');
			R7	<= (others => '0');
		elsif (falling_edge(Clk)) then
			if (CEn = '1') then
				if (WE = '1') then
					case SelWR is
						when "000" => R0 <= Data;
						when "001" => R1 <= Data;
						when "010" => R2 <= Data;
						when "011" => R3 <= Data;
						when "100" => R4 <= Data;
						when "101" => R5 <= Data;
						when "110" => R6 <= Data;
						when "111" => R7 <= Data;
					end case;
				end if;
			end if;
		end if;
		
		case SelA is
				when "000" => auxiliary_emb <= R0;
				when "001" => auxiliary_emb <= R1;
				when "010" => auxiliary_emb <= R2;
				when "011" => auxiliary_emb <= R3;
				when "100" => auxiliary_emb <= R4;
				when "101" => auxiliary_emb <= R5;
				when "110" => auxiliary_emb <= R6;
				when "111" => auxiliary_emb <= R7;
		end case;
			
			OutA_Emb <= auxiliary_emb;
			
			
		case SelB is
				when "000" => auxiliary_emb_2 <= R0;
				when "001" => auxiliary_emb_2 <= R1;
				when "010" => auxiliary_emb_2 <= R2;
				when "011" => auxiliary_emb_2 <= R3;
				when "100" => auxiliary_emb_2 <= R4;
				when "101" => auxiliary_emb_2 <= R5;
				when "110" => auxiliary_emb_2 <= R6;
				when "111" => auxiliary_emb_2 <= R7;
		end case;
			
			OutB_Emb <= auxiliary_emb_2;
			
	end process;
	
	OutA <= OutA_Emb;
	OutB <= OutB_Emb;
			
END Registers_Arc;	