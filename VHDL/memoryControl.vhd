LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY memCntrl IS
	PORT(
		i_clk	:	IN	std_logic;	--Input clock
		i_rst	:	IN	std_logic;	--Reset signal
		i_opcd	:	IN	std_logic_vector(4 downto 0);
		i_dst	:	IN	std_logic_vector(3 downto 0);
		o_RW	:	OUT	std_logic;	--Read/Write signal, 0 => read, 1 => write
		o_word	:	OUT	std_logic	--word or 2 words, 0 => one, 1 => two
	);
END ENTITY;

ARCHITECTURE struct OF memCntrl IS

BEGIN
	PROCESS(i_clk, i_rst)
	BEGIN
		IF(i_rst = '1')	THEN
			o_RW <= '0';
			o_word <= '0';

		ELSIF rising_edge(i_clk)	THEN
			IF(i_opcd = "10000" or i_opcd = "10100")	THEN
				o_RW <= '1';

			ELSE
				o_RW <= '0';
			END IF;

			IF(i_dst = "1000" or i_dst = "1001")	THEN
				o_word <= '1';

			ELSE
				o_word <= '0';
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;