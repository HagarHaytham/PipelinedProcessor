LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY MUX4x1 IS
	GENERIC (m:INTEGER:=16);
	PORT(in0,in1,in2,in3: IN STD_LOGIC_VECTOR(m-1 DOWNTO 0);
		sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		out1 : OUT STD_LOGIC_VECTOR(m-1 DOWNTO 0));
END ENTITY MUX4x1;

ARCHITECTURE MUX4x1Arch OF MUX4x1 IS
COMPONENT  MUX2x1 IS
GENERIC (n:INTEGER:=16);
PORT(a,b: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	s : IN STD_LOGIC;
	c : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END COMPONENT MUX2x1;

SIGNAL c1,c2 :  STD_LOGIC_VECTOR(m-1 DOWNTO 0);

BEGIN
M1 : MUX2x1 GENERIC MAP (m) PORT MAP(in0,in1,sel(0),c1);
M2 : MUX2x1 GENERIC MAP (m) PORT MAP(in2,in3,sel(0),c2);
M3 : MUX2x1 GENERIC MAP (m) PORT MAP(c1,c2,sel(1),out1);

END ARCHITECTURE;

