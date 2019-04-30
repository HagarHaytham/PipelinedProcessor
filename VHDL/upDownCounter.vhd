LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_unsigned.all;

ENTITY upDwnCntr IS
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
END ENTITY;

ARCHITECTURE behavioral OF upDwnCntr IS

SIGNAL cnt	:	std_logic_vector(n-1 downto 0);

BEGIN
	PROCESS(i_clk, i_rst)
	BEGIN
		IF(i_rst = '1')	THEN
			cnt <= x"0000";

		ELSIF rising_edge(i_clk)	THEN
			IF(i_en = '1')	THEN
				IF(i_load = '1')	THEN
					IF(i_dir = '0' and i_step = '1')	THEN
						cnt <= cnt + 2;	--add two, bec. we fetch two instructions at a time
					ELSIF(i_dir = '0' and i_step = '0')	THEN
						cnt <= cnt + 1;
					ELSIF(i_dir ='1' and i_step = '1')	THEN
						cnt <= cnt - 2; 
					ELSIF(i_dir = '1' and i_step = '0')	THEN
						cnt <= cnt - 1;
					END IF;

				ELSIF(i_load = '0')	THEN
					cnt <= i_cnt;
				END IF;
			END IF;
		ELSE
			cnt <= cnt;
		END IF;
	END PROCESS;
	
	o_cnt <= cnt;

END ARCHITECTURE;