LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY fetchControl IS
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
END ENTITY;

ARCHITECTURE behavioral OF fetchControl IS
BEGIN
	PROCESS(i_clk, i_rst)
	BEGIN
		IF(i_rst = '1')	THEN
			o_stall <= '0';
			o_dir <= '0';
			o_step <= '0';
			o_sel <= '0';

		ELSIF rising_edge(i_clk)	THEN
			IF(i_hzrd = '0' and i_brnch = '0')	THEN
				o_stall <= '0';
				o_dir <= '0';
				o_step <= '1';
				o_sel <= '1';
			ELSIF(i_hzrd = '0' and i_brnch = '1')	THEN
				o_stall <= '0';
				o_dir <= '0';
				o_step <= '0';
				o_sel <= '0';
			ELSIF(i_hzrd = '1')	THEN
				o_stall <= '1';
				o_dir <= '0';
				o_step <= '0';
				o_sel <= '0';
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;

