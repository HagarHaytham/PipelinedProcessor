LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY memCntrl IS
	PORT(
		i_clk	:	IN	std_logic;	--Input clock
		i_rst	:	IN	std_logic;	--Reset signal
		i_opcd	:	IN	std_logic_vector(4 downto 0);
		i_dst	:	IN	std_logic_vector(3 downto 0);
		o_RW	:	OUT	std_logic;	--Read/Write signal, 0 => read, 1 => write
		o_word	:	OUT	std_logic;	--word or 2 words, 0 => one, 1 => two
		o_spAdrs:	OUT	std_logic_vector(31 downto 0)
	);
END ENTITY;

ARCHITECTURE struct OF memCntrl IS

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

SIGNAL en	:	std_logic;
SIGNAL dir	:	std_logic;
SIGNAL step	:	std_logic;
SIGNAL load	:	std_logic;

BEGIN
	PROCESS(i_clk, i_rst)
	BEGIN
		IF(i_rst = '1')	THEN
			o_RW <= '0';
			o_word <= '0';
			en <= '0';
			dir <= '0';
			step <= '0';
			load <= '1';

		ELSIF rising_edge(i_clk)	THEN
			IF(i_opcd = "10000")	THEN
				o_RW <= '1';
				en <= '1';
				dir <= '1';
				step <= '0';
				load <= '1';
			ELSIF(i_opcd = "10001")	THEN
				en <= '1';
				dir <= '0';
				step <= '0';
				load <= '1';
			ELSIF(i_opcd = "10010")	THEN
				o_RW <= '0';
				en <= '0';
			ELSIF(i_opcd = "10011")	THEN
				o_RW <= '0';
				en <= '0';
			ELSIF(i_opcd = "10100")	THEN
				o_RW <= '0';
				en <= '0';
			ELSE
				o_RW <= '0';
				en <= '0';
			END IF;

			IF(i_dst = "1000" or i_dst = "1001")	THEN
				o_word <= '1';
			ELSE
				o_word <= '0';
			END IF;
		END IF;
	END PROCESS;

	sp:	upDwnCntr GENERIC MAP(32) PORT MAP(i_clk, i_rst, en, dir, step, load, x"00000000", o_spAdrs);

END ARCHITECTURE;