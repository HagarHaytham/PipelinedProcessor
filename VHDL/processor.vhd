LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY processor IS
	PORT(
		i_clkC	:	IN	std_logic;	--Input clock for processor control circuitry
		i_clkM	:	IN	std_logic;	--Input clock for memories
		i_rst	:	IN	std_logic;	--Reset signal for chip
		i_input	:	IN	std_logic_vector(15 downto 0);	--input port to be used with devices
		o_output:	OUT	std_logic_vector(15 downto 0)	--output port to be used with devices
	);
END ENTITY;

ARCHITECTURE struct OF processor IS

COMPONENT fetchCirc IS
	PORT(
		i_clkC	:	IN	std_logic;	--Input clock for control
		i_clkM	:	IN	std_logic;	--Input clock for memory
		i_rst	:	IN	std_logic;	--Reset signal for chip
		i_hzrd	:	IN	std_logic;	--A hazard is detected
		i_brnch	:	IN	std_logic;	--A branch is performed, to enable load
		i_adrs	:	IN	std_logic_vector(31 downto 0);	--Input address to PC, used with load
		o_inst	:	OUT	std_logic_vector(31 downto 0)	--Output instruction package
	);
END COMPONENT;

COMPONENT nReg IS
GENERIC (n:integer:=16);
	PORT (
		input		:	IN	std_logic_vector(n-1 downto 0);
		en,rst,clk	:	IN	std_logic;
		output		:	OUT	std_logic_vector(n-1 downto 0)
	);
END COMPONENT;

SIGNAL hzrd	:	std_logic;	--signal to detect hazard
SIGNAL brnch	:	std_logic;	--signal to indicate branch
SIGNAL instAdd	:	std_logic_vector(31 downto 0);	--Address lines for instruction memory
SIGNAL inFDBuf	:	std_logic_vector(31 downto 0);	--Input of fetch decode buffer, Instruction words fetched from instruction memory
SIGNAL outFDBuf	:	std_logic_vector(31 downto 0);	--Output of fetch decode buffer

SIGNAL clkBuf	:	std_logic;	--Inverted clock for buffers
SIGNAL bufEn	:	std_logic;	--enable of buffers

BEGIN

	--connect PC input to out of data memory and input address of '0' to memory when i_rst = 1
	instAdd <= 
	ftch:	fetchCirc PORT MAP(i_clkC, i_clkM, i_rst, hzrd, brnch, instAdd, inFDBuf);
	bufFD:	nReg GENERIC MAP(32) PORT MAP(inFDBuf, bufEn, i_rst, clkBuf, outFDBuf);
	--Decode Module

	--this buffer conneccts decode with ALU execution, it is 38-bit
	--5 bits for instruction opcode
	--32 bits for data, 16 bits for src and 16 for dst
	--1 bit travels all the way to writeback buffer to indicate if a writeback is required
	bufDE:	nReg GENERIC MAP(38) PORT MAP();
	bufDM:	nReg GENERIC MAP(38)

	clkBuf <= not i_clkC;
	bufEn <= not hzrd;
	hzrd <= '0';
	brnch <= '0';

END ARCHITECTURE;
