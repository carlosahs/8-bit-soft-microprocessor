----------------------------------------------------------------------------------|
-- Company: 					ITESM - Campus Querétaro										 | 
----------------------------------------------------------------------------------|
-- Engineers:			   A00517153 Johann Palomino Galván 								 |
--								A01700885 Carlos Alberto Hurtado Sánchez						 |
--								A01366815 Jesús Dassaef López Barrios							 |
----------------------------------------------------------------------------------|
-- Create Date:    		18:35:37 03/08/2021 													 |
-- Design Name: 			None																		 |
-- Module Name:    		TOP - Behavioral 														 |
-- Project Name: 			RISC_CPU - Academic Project										 |
-- Target Devices: 		MAX LITE-10 FPGA Board												 |
-- Tool versions: 		Quartus Prime Lite 18.1												 |
-- Description: 			RISC CPU project														 |
--																											 |
-- Dependencies: 			None																		 |
--																											 |
-- Revision: 				v1.0																		 |
-- Revision 0.01 - File Created																	 |
-- Additional Comments: None 																		 |
----------------------------------------------------------------------------------|

-- Libraries and Packages declaration

Library IEEE;

Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use IEEE.std_logic_unsigned.all;

-- Entity and Port

entity TOP is
	Port ( 
		-- C09: Mux4to1
			Switches		: in	std_logic_vector(7 downto 0);
			
		-- C12: Reg8
			LEDs			: out	std_logic_vector(7 downto 0);
		
		-- C13 and C14: Dec7Seg
			SegH			: out	std_logic_vector(7 downto 0);
			SegL			: out	std_logic_vector(7 downto 0);

		-- C15: ClkDiv
			Clk50MHz		: in	std_logic;
			Clr			: in	std_logic;
		
		-- Turn off the 4 extra 7-segment displays or C16
			S7_5			: out	std_logic_vector(7 downto 0);
			S7_4			: out	std_logic_vector(7 downto 0);
			S7_3			: out	std_logic_vector(7 downto 0);
			S7_2			: out	std_logic_vector(7 downto 0);
		
		-- Turn off the 2 extra LEDs or C17
			LEDs_Off_9	: out	std_logic;
			LEDs_Off_8	: out	std_logic);
End TOP;

Architecture main of TOP is

	Component ProgCounter	-- C01
		port (
			PCIn	: in	std_logic_vector(7 downto 0);
			Clk	: in	std_logic;
			Cen	: in	std_logic;
			Rst	: in	std_logic;
			PCOut	: out	std_logic_vector(7 downto 0));
	End Component;

	Component Mem	-- C02
		port (
			Addr		: in	std_logic_vector(7 downto 0);
			Datars	: out	std_logic_vector(2 downto 0);
			Datart	: out	std_logic_vector(2 downto 0);
			Datard	: out	std_logic_vector(2 downto 0);
			DataOp	: out	std_logic_vector(3 downto 0);
			Datai		: out	std_logic_vector(7 downto 0));
	End Component;

	Component CtrlUnit	-- C03
		Port (
			Oper				: in	std_logic_vector(3 downto 0);
			RegSrc_Op		: out	std_logic_vector(1 downto 0);
			ALUOp_Op			: out	std_logic_vector(2 downto 0);
			RegWrite_Op		: out	std_logic;
			Write7Seg_Op	: out	std_logic;
			WriteLEDs_Op	: out	std_logic;
			Beq_Op			: out	std_logic;
			JiJr_Op			: out	std_logic_vector(1 downto 0));
	End Component;

	Component Registers	-- C04
		port (
			SelA	: in	std_logic_vector(2 downto 0);
			SelB	: in	std_logic_vector(2 downto 0);
			SelWR	: in	std_logic_vector(2 downto 0);
			Data	: in	std_logic_vector(7 downto 0);
			Clk	: in	std_logic;
			Cen 	: in	std_logic;
			Rst	: in	std_logic;
			WE		: in	std_logic;
			OutA	: out	std_logic_vector(7 downto 0);
			OutB	: out	std_logic_vector(7 downto 0));
	End Component;

	Component ALU	-- C05
		port (
			InA	: in	std_logic_vector(7 downto 0);
			InB	: in	std_logic_vector(7 downto 0);
			Sel	: in	std_logic_vector(2 downto 0);
			Zero	: out	std_logic;
			Oper	: out	std_logic_vector(7 downto 0));
	End Component;

	Component FullAdder	-- C06
		port (
			InA	: in	std_logic_vector(7 downto 0);
			InB	: in	std_logic_vector(7 downto 0);
			S		: out	std_logic_vector(7 downto 0));
	End Component;

	Component Increm	-- C07
		port (
			InA	: in	std_logic_vector(7 downto 0);
			InB	: in	std_logic_vector(7 downto 0);
			Sel	: in	std_logic;
			M		: out	std_logic_vector(7 downto 0));
	End Component;

	Component Mux4to1	-- C09 y C10
		port (
			InA	: in	std_logic_vector(7 downto 0);
			InB	: in	std_logic_vector(7 downto 0);
			InC	: in	std_logic_vector(7 downto 0);
			InD	: in	std_logic_vector(7 downto 0);
			Sel	: in	std_logic_vector(1 downto 0);
			M		: out	std_logic_vector(7 downto 0));
	End Component;

	Component Reg8	-- C11 y C12
		port (
			Inrs	: in	std_logic_vector(7 downto 0);
			Clk	: in	std_logic;
			Cen	: in	std_logic;
			Rst	: in	std_logic;
			En		: in	std_logic;
			OutD	: out	std_logic_vector(7 downto 0));
	End Component;

	Component Dec7Seg   -- C13 y C14
		port (
			InR	: in  std_logic_vector(3 downto 0);
			Seg	: out std_logic_vector(7 downto 0));
	End Component;

	Component ClkDiv    -- C15
		port (
			Clkin       : in  std_logic;
			Rst         : in  std_logic;
			Clkout      : out std_logic);
	End Component;
	
	-- Embedded signals declaration
		
	-- For C01: ProgCounter
	signal PC			: std_logic_vector(7 downto 0);	
	
	-- For C02: Mem
	signal opcode		: std_logic_vector(3 downto 0);
	signal rs			: std_logic_vector(2 downto 0);
	signal rt			: std_logic_vector(2 downto 0);
	signal rd			: std_logic_vector(2 downto 0);
	signal imm			: std_logic_vector(7 downto 0);

	--	For C03: CtrlUnit
	signal RegSrc		: std_logic_vector(1 downto 0);
	signal ALUOp		: std_logic_vector(2 downto 0);
	signal RegWrite	: std_logic;
	signal Write7Seg	: std_logic;
	signal WriteLEDs	: std_logic;
	signal Beq			: std_logic;
	signal JiJr			: std_logic_vector(1 downto 0);
	
	--	For C04: Registers
	signal rsd        : std_logic_vector(7 downto 0);
	signal rtd        : std_logic_vector(7 downto 0);

	--	For C05: ALU
	signal ALUOper    : std_logic_vector(7 downto 0);
	signal ALUZero		: std_logic;

	--	For C06: FullAdder
	signal AdderS     : std_logic_vector(7 downto 0);

	--	For C07: Increm
	signal IncremM    : std_logic_vector(7 downto 0);
	
	-- For C08: BrEq
	signal BrEqM		: std_logic;
	
	-- For C09: Mux4 to 1
	signal DataM      : std_logic_vector(7 downto 0);
	
	--	For C10: Mux4 to 1
	signal BrJiJrM		: std_logic_vector(7 downto 0);
	
	-- For C11: Reg8
	signal D          : std_logic_vector(7 downto 0);
	
	--	For C15: ClkDiv
	signal ClkEn		: std_logic;

Begin

	-- Instantiate Components
	C01: ProgCounter
		port map(
			PCIn	=> BrJiJrM,
			Clk	=> Clk50MHz,
			Cen	=> ClkEn,
			Rst	=> Clr,
			PCOut	=> PC);

	C02: Mem
		port map(
			Addr		=> PC,
			Datars	=> rs,
			Datart	=> rt,
			Datard	=> rd,
			DataOp	=> opcode,
			Datai		=> imm);

	C03: CtrlUnit
		port map(
			Oper				=> opcode,
			RegSrc_Op		=> RegSrc,
			ALUOp_Op			=> ALUOp,
			RegWrite_Op		=> RegWrite,
			Write7Seg_Op	=> Write7Seg,
			WriteLEDs_Op	=> WriteLEDs,
			Beq_Op			=> Beq,
			JiJr_Op			=> JiJr);

	C04: Registers
		port map(
			SelA      => rs,
			SelB      => rt,
			SelWR     => rd,
			Data      => DataM,
			Clk       => Clk50MHz,
			Cen       => ClkEn,
			Rst       => Clr,
			WE        => RegWrite,
			OutA      => rsd,
			OutB      => rtd);

	C05: ALU
		port map(
			InA    => rsd,
			InB    => rtd,
			Sel    => ALUOp,
			Zero   => ALUZero,
			Oper   => ALUOper);

	C06: FullAdder
		port map(
			InA	=> PC,
			InB	=> IncremM,
			S		=> AdderS);

	C07: Increm
		port map(
			InA	=> "00000001",
			InB	=> imm,
			Sel	=> BrEqM,
			M		=> IncremM);

	-- For C08 BrEq
	BrEqM <= Beq AND ALUZero;
			
	C09: Mux4to1 
		port map(
			InA	=> imm,
			InB	=> PC,
			InC	=> ALUOper,
			InD	=> Switches,
			Sel	=> RegSrc,
			M		=> DataM);

	C10: Mux4to1 
		port map(
			InA    => AdderS,
			InB    => rsd,
			InC    => imm,
			InD    => "00000000",
			Sel    => JiJr,
			M      => BrJiJrM);

	C11: Reg8
		port map(
			Inrs	=> rsd,
			Clk	=> Clk50MHz,
			Cen	=> ClkEn,
			Rst	=> Clr,
			En		=> Write7Seg,
			OutD	=> D);

	C12: Reg8
		port map(
			Inrs	=> rsd,
			Clk	=> Clk50MHz,
			Cen	=> ClkEn,
			Rst	=> Clr,
			En		=> WriteLEDs,
			OutD	=> LEDs);

	C13: Dec7Seg
		port map(
			InR	=> D(7 downto 4),
			Seg	=> SegH);

	C14: Dec7Seg
		port map(
			InR	=> D(3 downto 0),
			Seg	=> SegL);

	C15: ClkDiv
		port map(
			Clkin		=> Clk50MHz,
			Rst		=> Clr,
			Clkout	=> ClkEn);
			
	-- Turn off the 4 extra 7-segment displays or C16
	S7_5	<= (others => '1');
	S7_4	<= (others => '1');
	S7_3	<= (others => '1');
	S7_2	<= (others => '1');
	
	-- Turn off the 2 extra LEDs or C17
	LEDs_Off_9	<= '0';
	LEDs_Off_8	<= '0';

End main;
