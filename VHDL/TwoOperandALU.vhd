LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
ENTITY TwoOperandALU IS
	GENERIC (m:integer:=16);
	PORT(a,b: IN STD_LOGIC_VECTOR(m-1 DOWNTO 0); --a-> Rsrc , b-> Rdst (put imm in it in shift operations)
        s : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        flagsIn : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        c : OUT STD_LOGIC_VECTOR(m-1 DOWNTO 0);
        flagsOut: OUT STD_LOGIC_VECTOR(2 DOWNTO 0)); -- C - N - Z
END ENTITY TwoOperandALU;

ARCHITECTURE TwoOperandALUArch OF TwoOperandALU IS

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
SIGNAL adderin2,bbar,ad,an,o,sl1,sr1,myout : STD_LOGIC_VECTOR(m-1 DOWNTO 0);
Signal ccrAdd,ccrAnd,ccrShl,ccrShr : STD_LOGIC_VECTOR (2 downto 0);
SIGNAL carrin : STD_LOGIC_VECTOR(0 DOWNTO 0);
SIGNAL carrout,z : STD_LOGIC;
BEGIN
bbar <= NOT b;
an <= a AND b;
o<= a OR b;
sl1 <=std_logic_vector(unsigned(a) sll to_integer(unsigned(b(3 DOWNTO 0))));
sr1 <=std_logic_vector(unsigned(a) srl to_integer(unsigned(b(3 DOWNTO 0))));
--sl1<= (m-1 DOWNTO to_integer(unsigned(b(3 DOWNTO 0)))=>a(m-1-to_integer(unsigned(b(3 DOWNTO 0))) DOWNTO 0), others =>'0');
--sr1<= (m-1 DOWNTO to_integer(unsigned(b(3 DOWNTO 0)))=>a(m-1-to_integer(unsigned(b(3 DOWNTO 0))) DOWNTO 0), others =>'0');

z <= '1' when myout=x"0000"
else '0';
ccrAdd <= carrout & myout(15) &z;
ccrAnd <= flagsIn(2) & myout(15) &z;
--ccrShl <= a(16-to_integer(unsigned(b)))& myout(15) &z;  -- need to adjust carry
--ccrShr <= a(to_integer(unsigned(b)))& myout(15) &z;  -- need to adjust carry
Mb : MUX2x1 GENERIC MAP (m) PORT MAP (b,bbar,s(1),adderin2);
Mc : MUX2x1 GENERIC MAP (1) PORT MAP ("0","1",s(1),carrin);
FA : FullAdder GENERIC MAP (m) PORT MAP (a,adderin2,carrin(0),ad,carrout);
M1 : MUX8x1 GENERIC MAP (m)  PORT MAP (a,ad,ad,an,o,sl1,sr1,x"0000",s,myout);
M2 : MUX8x1 GENERIC MAP (3) PORT MAP (flagsIn,ccrAdd,ccrAdd,ccrAnd,ccrAnd,ccrAnd,ccrAnd,flagsIn,s,flagsOut);
c<= myout;

-- flagsOut <="000";
END ARCHITECTURE;



