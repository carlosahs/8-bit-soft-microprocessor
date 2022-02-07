----------------------------------------------------------------------------------|
-- Company: 					ITESM - Campus Querétaro										 | 
----------------------------------------------------------------------------------|
-- Engineers:			   A00517153 Johann Palomino Galván 								 |
--								A01700885 Carlos Alberto Hurtado Sánchez						 |
--								A01366815 Jesús Dassaef López Barrios							 |
----------------------------------------------------------------------------------|
-- Create Date:    		18:35:37 03/08/2021 													 |
-- Design Name: 			None																		 |
-- Module Name:    		ALU - Behavioral 		  												 |
-- Project Name: 			RISC_CPU - Academic Project										 |
-- Target Devices: 		MAX LITE-10 FPGA Board												 |
-- Tool versions: 		Quartus Prime Lite 18.1												 |
-- Description: 			Arithmetic Logic Unit (ALU) for RISC CPU						 |
--																											 |
-- Dependencies: 			None																		 |
--																											 |
-- Revision: 				v1.0																		 |
-- Revision 0.01 - File Created																	 |
-- Additional Comments: None 																		 |
----------------------------------------------------------------------------------|

library ieee;
use ieee.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use IEEE.std_logic_unsigned.all;

ENTITY ALU IS
	PORT(	
		InA 		: in 	std_logic_vector(7 downto 0);
		InB 		: in 	std_logic_vector(7 downto 0);
		Sel		: in 	std_logic_vector(2 downto 0);
		Oper		: out	std_logic_vector(7 downto 0);
		Zero		: out	std_logic
	);
END ALU;

ARCHITECTURE ALU_ARC OF ALU IS
	
	signal SUM, REST, Oper_Emb : std_logic_vector(7 downto 0);
	signal Zero_Emb	         : std_logic; 
	signal result_s,result_r   : std_logic_vector(8 downto 0);
	
BEGIN

	-- Suma
	
	result_s <= ('0' & InA) + ('0' & InB);
	SUM      <= result_s(7 downto 0);
	
	-- Resta
	
	result_r <= ('0' & InA) - ('0' & InB);
	REST     <= result_r(7 downto 0);
	
	process(Sel)
	begin
	--	Determines which operation is passed down to the Emb
		case Sel is
			when "000" =>	Oper_Emb <= SUM;
			when "001" =>	Oper_Emb <= REST;
			when "010" =>	Oper_Emb <= (InA AND InB);
			when "011" => 	Oper_Emb <= (InA OR  InB);
			when "100" =>	Oper_Emb <= (InA XOR InB);
			when "101" => 	Oper_Emb <= not InA;
			when "110" => 	Oper_Emb <= (InA(6 downto 0) & '0');
			when "111" => 	Oper_Emb <= ('0' & InA(7 downto 1));
		end case;
	
		--	Determines the flag Zero if Oper is Zero
		if (Oper_Emb = "00000000") then
			Zero_Emb <= '1';
		else
			Zero_Emb <= '0';
		end if;
	
	end process;
	--	Passes the data from the Emb to it's output
	Oper <= Oper_Emb;
	Zero <= Zero_Emb;							
	
END ALU_ARC;	