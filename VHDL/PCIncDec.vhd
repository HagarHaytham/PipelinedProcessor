LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY circuitPC IS
	PORT(
		i_clk	:	IN	std_logic;	--Input clock
		i_rst	:	IN	std_logic;	--Reset signal for circuitry
		i_stall	:	IN	std_logic;	--Stall signal, keeps same value
		i_dir	:	IN	std_logic;	--0 => increment, 1 => decrement
		i_step	:	IN	std_logic;	--Step from current address
		i_sel	:	IN	std_logic;	--Selection line for PC input 0 => load, 1 => Increment/Decrement
		i_adrs	:	IN	std_logic_vector(19 downto 0);	--Input address to load in PC
		o_adrs	:	OUT	std_logic_vector(19 downto 0)	--Output address from PC
	);
END ENTITY;

ARCHITECTURE behavioral OF circuitPC IS

COMPONENT upDwnCntr IS
GENERIC(n	:	INTEGER	:=	16);
	PORT(
		i_clk	:	IN	std_logic;
		i_rst	:	IN	std_logic;
		i_en	:	IN	std_logic;
		i_dir	:	IN	std_logic;	--0 => increment, 1 => decrement
		i_step	:	IN	std_logic;	--0 => 1, 1 => 2
		i_load	:	IN	std_logic;	--0 => load, 1 => Increment/Decrement
		i_cnt	:	IN	std_logic_vector(n-1 downto 0);
		o_cnt	:	OUT	std_logic_vector(n-1 downto 0)
	);
END COMPONENT;

--SIGNAL enCntr	:	std_logic;
--SIGNAL dirCntr	:	std_logic;

BEGIN

	regCntrPC:	upDwnCntr GENERIC MAP(32) PORT MAP(i_clk, i_rst, not i_stall, i_dir, i_step, i_sel
--	PROCESS(i_clk, i_rst)
--	BEGIN
--		IF(i_rst = '0' and i_stall = '0')	THEN
--			IF rising_edge(i_clk)	THEN
--				IF(i_sel = '0')	THEN
END ARCHITECTUTRE;