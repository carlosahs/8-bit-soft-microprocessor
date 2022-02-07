----------------------------------------------------------------------------------|
-- Company: 					ITESM - Campus Querétaro										 | 
----------------------------------------------------------------------------------|
-- Engineers:			   A00517153 Johann Palomino Galván 								 |
--								A01700885 Carlos Alberto Hurtado Sánchez						 |
--								A01366815 Jesús Dassaef López Barrios							 |
----------------------------------------------------------------------------------|
-- Create Date:    		18:35:37 03/08/2021 													 |
-- Design Name: 			None																		 |
-- Module Name:    		CtrlUnit - Behavioral 												 |
-- Project Name: 			RISC_CPU - Academic Project										 |
-- Target Devices: 		MAX LITE-10 FPGA Board												 |
-- Tool versions: 		Quartus Prime Lite 18.1												 |
-- Description: 			Control Unit for RISC CPU									 		 |
--																											 |
-- Dependencies: 			None																		 |
--																											 |
-- Revision: 				v1.0																		 |
-- Revision 0.01 - File Created																	 |
-- Additional Comments: None 																		 |
----------------------------------------------------------------------------------|

library ieee;
use ieee.std_logic_1164.all;

entity CtrlUnit is
	port(
		Oper         : in  std_logic_vector(3 downto 0);
		RegSrc_Op    : out std_logic_vector(1 downto 0);
		ALUOp_Op     : out std_logic_vector(2 downto 0);
		RegWrite_Op  : out std_logic;
		Write7Seg_Op : out std_logic;
		WriteLEDs_Op : out std_logic;
		Beq_Op       : out std_logic;
		JiJr_Op      : out std_logic_vector(1 downto 0));
end CtrlUnit;		 

architecture Behavioral of CtrlUnit is

begin
	process(Oper)
	begin
		case Oper is
			when "0000" => -- add rs rt rd
				RegSrc_Op    <= "10";
				ALUOp_Op     <= "000";
				RegWrite_Op  <= '1';
				Write7Seg_Op <= '0';
				WriteLEDs_Op <= '0';
				Beq_Op       <= '0';
				JiJr_Op      <= "00";
			when "0001" => -- sub rs rt rd
				RegSrc_Op    <= "10";
				ALUOp_Op     <= "001";
				RegWrite_Op  <= '1';
				Write7Seg_Op <= '0';
				WriteLEDs_Op <= '0';
				Beq_Op       <= '0';
				JiJr_Op      <= "00";
			when "0010" => -- and rs rt rd
				RegSrc_Op    <= "10";
				ALUOp_Op     <= "010";
				RegWrite_Op  <= '1';
				Write7Seg_Op <= '0';
				WriteLEDs_Op <= '0';
				Beq_Op       <= '0';
				JiJr_Op      <= "00";
			when "0011" => -- or rs rt rd
				RegSrc_Op    <= "10";
				ALUOp_Op     <= "011";
				RegWrite_Op  <= '1';
				Write7Seg_Op <= '0';
				WriteLEDs_Op <= '0';
				Beq_Op       <= '0';
				JiJr_Op      <= "00";
			when "0100" => -- xor rs rt rd
				RegSrc_Op    <= "10";
				ALUOp_Op     <= "100";
				RegWrite_Op  <= '1';
				Write7Seg_Op <= '0';
				WriteLEDs_Op <= '0';
				Beq_Op       <= '0';
				JiJr_Op      <= "00";
			when "0101" => -- not rs rd
				RegSrc_Op    <= "10";
				ALUOp_Op     <= "101";
				RegWrite_Op  <= '1';
				Write7Seg_Op <= '0';
				WriteLEDs_Op <= '0';
				Beq_Op       <= '0';
				JiJr_Op      <= "00";
			when "0110" => -- shl rs rd
				RegSrc_Op    <= "10";
				ALUOp_Op     <= "110";
				RegWrite_Op  <= '1';
				Write7Seg_Op <= '0';
				WriteLEDs_Op <= '0';
				Beq_Op       <= '0';
				JiJr_Op      <= "00";
			when "0111" => -- shr rs rd
				RegSrc_Op    <= "10";
				ALUOp_Op     <= "111";
				RegWrite_Op  <= '1';
				Write7Seg_Op <= '0';
				WriteLEDs_Op <= '0';
				Beq_Op       <= '0';
				JiJr_Op      <= "00";
			when "1000" => -- ld rd i
				RegSrc_Op    <= "00";
				ALUOp_Op     <= "000"; -- xxx but writen as 000
				RegWrite_Op  <= '1';
				Write7Seg_Op <= '0';
				WriteLEDs_Op <= '0';
				Beq_Op       <= '0';
				JiJr_Op      <= "00";
			when "1001" => -- spc rd
				RegSrc_Op    <= "01";
				ALUOp_Op     <= "000"; -- xxx but writen as 000
				RegWrite_Op  <= '1';
				Write7Seg_Op <= '0';
				WriteLEDs_Op <= '0';
				Beq_Op       <= '0';
				JiJr_Op      <= "00";
			when "1010" => -- beq rs rt i
				RegSrc_Op    <= "00"; -- xx but writen as 00
				ALUOp_Op     <= "001"; -- 100 (xor rs rt rd) can also be used; 001 is sub rs rt rd
				RegWrite_Op  <= '0';
				Write7Seg_Op <= '0';
				WriteLEDs_Op <= '0';
				Beq_Op       <= '1';
				JiJr_Op      <= "00";
			when "1011" => -- ji i
				RegSrc_Op    <= "00";
				ALUOp_Op     <= "000"; -- xxx but writen as 000
				RegWrite_Op  <= '0';
				Write7Seg_Op <= '0';
				WriteLEDs_Op <= '0';
				Beq_Op       <= '0';
				JiJr_Op      <= "10";
			when "1100" => -- jr rs
				RegSrc_Op    <= "00"; -- xx but writen as 00
				ALUOp_Op     <= "000"; -- xxx but writen as 000
				RegWrite_Op  <= '0';
				Write7Seg_Op <= '0';
				WriteLEDs_Op <= '0';
				Beq_Op       <= '0';
				JiJr_Op      <= "01";
			when "1101" => -- w7seg rs
				RegSrc_Op    <= "00"; -- xx but writen as 00
				ALUOp_Op     <= "000"; -- xxx but writen as 000
				RegWrite_Op  <= '0';
				Write7Seg_Op <= '1';
				WriteLEDs_Op <= '0';
				Beq_Op       <= '0';
				JiJr_Op      <= "00";
			when "1110" => -- wleds rs
				RegSrc_Op    <= "00"; -- xx but writen as 00
				ALUOp_Op     <= "000"; -- xxx but writen as 000
				RegWrite_Op  <= '0';
				Write7Seg_Op <= '0';
				WriteLEDs_Op <= '1';
				Beq_Op       <= '0';
				JiJr_Op      <= "00";
			when "1111" => -- rsw rd
				RegSrc_Op    <= "11";
				ALUOp_Op     <= "000"; -- xxx but writen as 000
				RegWrite_Op  <= '1';
				Write7Seg_Op <= '0';
				WriteLEDs_Op <= '0';
				Beq_Op       <= '0';
				JiJr_Op      <= "00";
			when others => -- safety precaution
				RegSrc_Op    <= "00";
				ALUOp_Op     <= "000";
				RegWrite_Op  <= '0';
				Write7Seg_Op <= '0';
				WriteLEDs_Op <= '0';
				Beq_Op       <= '0';
				JiJr_Op      <= "00";
		end case;
	end process;
end Behavioral;