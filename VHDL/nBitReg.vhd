LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY n_reg IS
GENERIC(n : INTEGER:=16);
	PORT(
		d		:	IN	std_logic_vector(n-1 downto 0);
		en, clk, rst	:	IN	std_logic;
		q		:	OUT	std_logic_vector(n-1 downto 0)
	);
END ENTITY;


Architecture myReg of n_reg is

Begin

Process(clk,rst,en)

	Begin
		if(rst = '1') then 
			q <= (others => '0');
		elsif (rising_edge(clk) and en = '1') then 
			q <= d;
		end if;
End process;

End myReg;
