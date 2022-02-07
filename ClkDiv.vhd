----------------------------------------------------------------------------------|
-- Company: 					ITESM - Campus Querétaro										 | 
----------------------------------------------------------------------------------|
-- Engineers:			   A00517153 Johann Palomino Galván 								 |
--								A01700885 Carlos Alberto Hurtado Sánchez						 |
--								A01366815 Jesús Dassaef López Barrios							 |
----------------------------------------------------------------------------------|
-- Create Date:    		18:35:37 03/08/2021 													 |
-- Design Name: 			None																		 |
-- Module Name:    		ClkDiv - Behavioral 		  											 |
-- Project Name: 			RISC_CPU - Academic Project										 |
-- Target Devices: 		MAX LITE-10 FPGA Board												 |
-- Tool versions: 		Quartus Prime Lite 18.1												 |
-- Description: 			Frequency divider for RISC CPU									 |
--																											 |
-- Dependencies: 			None																		 |
--																											 |
-- Revision: 				v1.0																		 |
-- Revision 0.01 - File Created																	 |
-- Additional Comments: None 																		 |
----------------------------------------------------------------------------------|

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity ClkDiv is
  port (
     Clkin   : in  STD_LOGIC;
	  Rst     : in  STD_LOGIC;
	  Clkout  : out STD_LOGIC);
end ClkDiv;

architecture tinac of ClkDiv is
  -- Signal and constants used by the Frequency Divider
  -- Embedded signals declaration
  -- Used by Frequency Divider (FreqDiv)

  -- Define a value that contains the desired Frequency
  constant DesiredFreq_66815 : natural := 10;  -- **___ per second changes in the FSM**
  -- Frequency for a DE10-Lite board is 50MHz
  constant BoardFreq_66815   : natural := 50_000_000;
  -- Calculate the value the counter should reach to obtain desired Freq.
  constant MaxOscCount_66815 : natural := BoardFreq_66815 / DesiredFreq_66815;
  -- Pulse counter for the oscillator
  signal OscCount_66815      : natural range 0 to MaxOscCount_66815;  

begin
	Freq_Div: process(Rst,Clkin)
	begin
		if (Rst = '0') then
			OscCount_66815 <= 0;
		elsif rising_edge(Clkin) then
			if (OscCount_66815 = 	MaxOscCount_66815) then
				Clkout    <= '1';
				OscCount_66815 <= 0;
			else
				Clkout    <= '0';
				OscCount_66815 <= OscCount_66815 + 1;
			end if;
		end if;
	end process Freq_Div;

end tinac;