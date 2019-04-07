LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Adder IS
	PORT (a,b,cin : IN  STD_LOGIC;
		  s, cout : OUT STD_LOGIC);
END ENTITY Adder;

ARCHITECTURE AdderArch OF Adder IS
	BEGIN
		PROCESS ( a ,b , cin)
			BEGIN 
				s <= a XOR b XOR cin;
				cout <= (a AND b) OR (cin AND (a XOR b));
		END PROCESS;
END ARCHITECTURE;
