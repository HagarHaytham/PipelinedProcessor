LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY MUX8x1 IS
	GENERIC (m:integer:=16);
	PORT(in0,in1,in2,in3,in4,in5,in6,in7: IN STD_LOGIC_VECTOR(m-1 DOWNTO 0);
		sel : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		out1 : OUT STD_LOGIC_VECTOR(m-1 DOWNTO 0));
END ENTITY MUX8x1;

ARCHITECTURE MUX8x1Arch OF MUX8x1 IS
COMPONENT MUX4x1 IS
GENERIC (m:INTEGER:=16);
PORT(in0,in1,in2,in3: IN STD_LOGIC_VECTOR(m-1 DOWNTO 0);
    sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    out1 : OUT STD_LOGIC_VECTOR(m-1 DOWNTO 0));
END COMPONENT MUX4x1;

COMPONENT  MUX2x1 IS
GENERIC (n:INTEGER:=16);
PORT(a,b: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    s : IN STD_LOGIC;
    c : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END COMPONENT MUX2x1;

SIGNAL a,b :  STD_LOGIC_VECTOR(m-1 DOWNTO 0);

BEGIN
M1 : MUX4x1 GENERIC MAP (m) PORT MAP(in0,in1,in2,in3,sel(1 downto 0),a);
M2 : MUX4x1 GENERIC MAP (m) PORT MAP(in4,in5,in6,in7,sel(1 downto 0),b);
M3 : MUX2x1 GENERIC MAP (m) PORT MAP(a,b,sel(2),out1);

END ARCHITECTURE;

