LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY FullAdder IS
	GENERIC (n:INTEGER:=16);
	PORT (a,b: IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		cin : IN STD_LOGIC;
		f :OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		cout : OUT STD_LOGIC );
END ENTITY FullAdder;

ARCHITECTURE FullAdderArch OF FullAdder IS

COMPONENT  Adder IS
PORT (a,b,cin : IN  STD_LOGIC;
      s, cout : OUT STD_LOGIC);
END COMPONENT Adder;
SIGNAL temp: STD_LOGIC_VECTOR(n DOWNTO 0);

BEGIN

temp(0)<=cin;

loop1 : FOR i IN 0 TO n-1 GENERATE 
fx: Adder PORT MAP (a(i),b(i),temp(i),f(i),temp(i+1));
END GENERATE;

cout<= temp(n);

END ARCHITECTURE;

