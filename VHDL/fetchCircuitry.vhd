LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_unsigned.all;

ENTITY fetchCirc IS
	PORT(
		i_clkC	:	IN	std_logic;	--Input clock for control
		i_clkM	:	IN	std_logic;	--Input clock for memory
		i_rst	:	IN	std_logic;	--Reset signal for chip
		i_hzrd	:	IN	std_logic;	--A hazard is detected
		i_brnch	:	IN	std_logic;	--A branch is performed, to enable load
		i_adrs	:	IN	std_logic_vector(31 downto 0);	--Input address to PC, used with load
		o_inst	:	OUT	std_logic_vector(31 downto 0)	--Output instruction package
	);
END ENTITY;

ARCHITECTURE struct OF fetchCirc iS

COMPONENT fetchControl IS
	PORT(
		i_clk	:	IN	std_logic;	--Input clock
		i_rst	:	IN	std_logic;	--Reset signal for chip
		i_hzrd	:	IN	std_logic;	--A hazard is detected
		i_brnch	:	IN	std_logic;	--A branch is performed, to enable load
		o_stall	:	OUT	std_logic;	--Stall signal to PC circuitry
		o_dir	:	OUT	std_logic;	--direction signal for PC, 0 => increment, 1 => decrement
		o_step	:	OUT	std_logic;	--step for PC from curent address, 0 => 1, 1 => 2
		o_sel	:	OUT	std_logic	--slection for PC, 0 => load, 1 => Increment/Decrement
	);
END COMPONENT;

COMPONENT circuitPC IS
	PORT(
		i_clk	:	IN	std_logic;	--Input clock
		i_rst	:	IN	std_logic;	--Reset signal for circuitry
		i_stall	:	IN	std_logic;	--Stall signal, keeps same value
		i_dir	:	IN	std_logic;	--0 => increment, 1 => decrement
		i_step	:	IN	std_logic;	--Step from current address, 0 => 1, 1 => 2
		i_sel	:	IN	std_logic;	--Selection line for PC input 0 => load, 1 => Increment/Decrement
		i_adrs	:	IN	std_logic_vector(31 downto 0);	--Input address to load in PC
		o_adrs	:	OUT	std_logic_vector(31 downto 0)	--Output address from PC
	);
END COMPONENT;

COMPONENT ram IS
	PORT(
		clk	: IN std_logic;
		word 	: IN std_logic;
		RW 	: IN std_logic;
		address	: IN  std_logic_vector(19 DOWNTO 0);
		datain 	: IN  std_logic_vector(15 DOWNTO 0);
		data32	: OUT std_logic_vector(31 DOWNTO 0));
		--data16 : OUT std_logic_vector(15 DOWNTO 0));
END COMPONENT;

SIGNAL stall	:	std_logic;
SIGNAL dir	:	std_logic;
SIGNAL step	:	std_logic;
SIGNAL sel	:	std_logic;
SIGNAL adrsPCI	:	std_logic_vector(31 downto 0);
SIGNAL adrsPCO	:	std_logic_vector(31 downto 0);
SIGNAL adrsMem	:	std_logic_vector(31 downto 0);

BEGIN

	adrsMem <= adrsPCO	WHEN i_brnch = '0'
	ELSE i_adrs		WHEN i_brnch = '1';

	adrsPCI <= i_adrs + 2	WHEN i_brnch = '1'
	ELSE i_adrs		WHEN i_brnch = '0';

	ftchCntrl:	fetchControl PORT MAP(i_clkC, i_rst, i_hzrd, i_brnch, stall, dir, step, sel);

	PC:		circuitPC PORT MAP(i_clkC, '0', stall, dir, step, sel, adrsPCI, adrsPCO);

	mem:		ram PORT MAP(i_clkM, step, '0', adrsMem(19 downto 0), x"0000", o_inst);

END ARCHITECTURE;