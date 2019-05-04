LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY dataMemCirc IS
	PORT(
		i_clkC	:	IN	std_logic;	--Input clock for control
		i_clkM	:	IN	std_logic;	--Input clock for memory
		i_rst	:	IN	std_logic;	--Reset signal
		i_opcd	:	IN	std_logic_vector(4 downto 0);	--instruction opcode
		i_dst	:	IN	std_logic_vector(3 downto 0);	--destination register, as PC/SP are 32-bit regs
		i_adrs	:	IN 	std_logic_vector(19 DOWNTO 0);	--address lines
		i_data	:	IN	std_logic_vector(31 DOWNTO 0);	--data to write
		o_data	:	OUT	std_logic_vector(31 DOWNTO 0)	--data read
	);
END ENTITY;

ARCHITECTURE struct OF dataMemCirc IS

COMPONENT memCntrl IS
	PORT(
		i_clk	:	IN	std_logic;	--Input clock
		i_rst	:	IN	std_logic;	--Reset signal
		i_opcd	:	IN	std_logic_vector(4 downto 0);
		i_dst	:	IN	std_logic_vector(3 downto 0);
		o_RW	:	OUT	std_logic;	--Read/Write signal, 0 => read, 1 => write
		o_word	:	OUT	std_logic	--word or 2 words, 0 => one, 1 => two
	);
END COMPONENT;

COMPONENT ram IS
	PORT(
		clk	: IN std_logic;
		word 	: IN std_logic;
		RW 	: IN std_logic;
		address	: IN  std_logic_vector(19 DOWNTO 0);
		datain 	: IN  std_logic_vector(31 DOWNTO 0);
		data32	: OUT std_logic_vector(31 DOWNTO 0));
END COMPONENT;

SIGNAL sRW	:	std_logic;
SIGNAL word	:	std_logic;

BEGIN
	
	cntrl:	memCntrl PORT MAP(i_clkC, i_rst, i_opcd, i_dst, sRW, word);

	mem:	ram PORT MAP(i_clkM, word, sRW, i_adrs, i_data, o_data);

END ARCHITECTURE; 