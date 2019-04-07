LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY OneOperandALU IS
	GENERIC (m:integer:=16);
	PORT(a: IN STD_LOGIC_VECTOR(m-1 DOWNTO 0);
        s : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        flagsIn : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        c : OUT STD_LOGIC_VECTOR(m-1 DOWNTO 0)
        flagsOut: OUT STD_LOGIC_VECTOR(2 DOWNTO 0)); -- C - N - Z
END ENTITY OneOperandALU;

ARCHITECTURE OneOperandALUArch OF OneOperandALU IS

BEGIN


END ARCHITECTURE


