LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY dec4X16 IS
	PORT(
		bits	:	IN	std_logic_vector(3 downto 0);
		en	:	IN	std_logic;
		selc	:	OUT	std_logic_vector(15 downto 0)
	);
END ENTITY;

ARCHITECTURE dataflow OF dec4X16 IS
BEGIN
	selc <= "0000000000000001" WHEN en = '1' AND bits = "0000"
	ELSE "0000000000000010" WHEN en = '1' AND bits = "0001"
	ELSE "0000000000000100" WHEN en = '1' AND bits = "0010"
	ELSE "0000000000001000" WHEN en = '1' AND bits = "0011"
	ELSE "0000000000010000" WHEN en = '1' AND bits = "0100"
	ELSE "0000000000100000" WHEN en = '1' AND bits = "0101"
	ELSE "0000000001000000" WHEN en = '1' AND bits = "0110"
	ELSE "0000000010000000" WHEN en = '1' AND bits = "0111"
	ELSE "0000000100000000" WHEN en = '1' AND bits = "1000"
	ELSE "0000001000000000" WHEN en = '1' AND bits = "1001"
	ELSE "0000010000000000" WHEN en = '1' AND bits = "1010"
	ELSE "0000100000000000" WHEN en = '1' AND bits = "1011"
	ELSE "0001000000000000" WHEN en = '1' AND bits = "1100"
	ELSE "0010000000000000" WHEN en = '1' AND bits = "1101"
	ELSE "0100000000000000" WHEN en = '1' AND bits = "1110"
	ELSE "1000000000000000" WHEN en = '1' AND bits = "1111"
	ELSE "0000000000000000" WHEN en = '0';
END dataflow;