LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY OneOperandALU IS
	GENERIC (m:integer:=16);
	PORT(a: IN STD_LOGIC_VECTOR(m-1 DOWNTO 0);
        s : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        flagsIn : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        c : OUT STD_LOGIC_VECTOR(m-1 DOWNTO 0);
        flagsOut: OUT STD_LOGIC_VECTOR(2 DOWNTO 0)); -- C - N - Z
END ENTITY OneOperandALU;

ARCHITECTURE OneOperandALUArch OF OneOperandALU IS

SIGNAL b,d,e,f,myout :  STD_LOGIC_VECTOR(m-1 DOWNTO 0);
SIGNAL ccrSetc,ccrClrc,ccrNot , ccrInc :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL carry1,z : STD_LOGIC ;
COMPONENT MUX8x1 IS
	GENERIC (m:integer:=16);
	PORT(in0,in1,in2,in3,in4,in5,in6,in7: IN STD_LOGIC_VECTOR(m-1 DOWNTO 0);
		sel : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		out1 : OUT STD_LOGIC_VECTOR(m-1 DOWNTO 0));
END COMPONENT MUX8x1;
COMPONENT MUX2x1 IS
	GENERIC (n:INTEGER:=16);
	PORT(a,b: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		s : IN STD_LOGIC;
		c : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END COMPONENT MUX2x1;
COMPONENT FullAdder IS
	GENERIC (n:INTEGER:=16);
	PORT (a,b: IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		cin : IN STD_LOGIC;
		f :OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		cout : OUT STD_LOGIC );
END COMPONENT FullAdder;

BEGIN
b <= x"0000";
d <= NOT a ;
z <= '1' when myout=x"0000"
else '0';
ccrSetc <= '1' & flagsIn(1 downto 0 );
ccrClrc <= '0' & flagsIn (1 downto 0);
ccrNot <=flagsIn(0)&myout(15)&z;
ccrInc <=carry1&myout(15)&z;
M1 : MUX8x1 GENERIC MAP(m) PORT MAP(b,b,b,d,f,f,b,b,s,myout);
M2 : MUX2x1 GENERIC MAP (m) PORT MAP (b,x"FFFE",s(0),e);
FA : FullAdder GENERIC MAP(m) PORT MAP(a,e,'1',f,carry1);
CCR : MUX8x1 GENERIC MAP(3) PORT MAP(flagsIn,ccrSetc,ccrClrc,ccrNot,ccrInc,ccrInc,flagsIn,flagsIn,s,flagsOut);
c<=myout;
END ARCHITECTURE;


