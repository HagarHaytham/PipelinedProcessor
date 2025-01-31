LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY ALU IS
	GENERIC (m:integer:=16);
	PORT(a,b: IN STD_LOGIC_VECTOR(m-1 DOWNTO 0);  -- a (Rsrc) , b (Rdst or Imm)
        s : IN STD_LOGIC_VECTOR(4 DOWNTO 0); -- Opcode of the instruction
        flagsIn : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        c : OUT STD_LOGIC_VECTOR(m-1 DOWNTO 0);
        flagsOut: OUT STD_LOGIC_VECTOR(2 DOWNTO 0)); -- C - N - Z
END ENTITY ALU;

ARCHITECTURE ALUArch OF ALU IS
COMPONENT MUX2x1 IS
	GENERIC (n:INTEGER:=16);
	PORT(a,b: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		s : IN STD_LOGIC;
		c : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END COMPONENT MUX2x1;
COMPONENT TwoOperandALU IS
	GENERIC (m:integer:=16);
	PORT(a,b: IN STD_LOGIC_VECTOR(m-1 DOWNTO 0); --a-> Rsrc , b-> Rdst (put imm in it in shift operations)
        s : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        flagsIn : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        c : OUT STD_LOGIC_VECTOR(m-1 DOWNTO 0);
        flagsOut: OUT STD_LOGIC_VECTOR(2 DOWNTO 0)); -- C - N - Z
END COMPONENT TwoOperandALU;
COMPONENT OneOperandALU IS
	GENERIC (m:integer:=16);
	PORT(a: IN STD_LOGIC_VECTOR(m-1 DOWNTO 0);
        s : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        flagsIn : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        c : OUT STD_LOGIC_VECTOR(m-1 DOWNTO 0);
        flagsOut: OUT STD_LOGIC_VECTOR(2 DOWNTO 0)); -- C - N - Z
END COMPONENT OneOperandALU;
SIGNAL oneout,twoout,notaluout,c1 :STD_LOGIC_VECTOR(m-1 DOWNTO 0);
SIGNAL ccr1,ccr2,flagsOut1 :STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN

top: TwoOperandALU GENERIC MAP (m) PORT MAP (a,b,s(2 DOWNTO 0),flagsIn,twoout,ccr2);
oop: OneOperandALU GENERIC MAP (m) PORT MAP (a,s(2 DOWNTO 0),flagsIn,oneout,ccr1);
Mout: MUX2x1 GENERIC MAP (m) PORT MAP (oneout,twoout,s(3),c1);
Mccr: MUX2x1 GENERIC MAP (3) PORT MAP (ccr1,ccr2,s(3),flagsOut1);
notaluout<="0000000000000000";
Moutfinal : MUX2x1 GENERIC MAP (m) PORT MAP (c1,notaluout,s(4),c);
Mccrfinal : MUX2x1 GENERIC MAP (3) PORT MAP (flagsOut1,flagsIn,s(4),flagsOut);
END ARCHITECTURE;

