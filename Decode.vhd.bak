LIBRARY IEEE;
USE IEEE.std_logic_1164.all;


Entity decode is
port(
	inst : in std_logic_vector (31 downto 0);
	clk,rst,wMem,wAlu : in std_logic; 
	wMAdd,wAAdd : in std_logic_vector(3 downto 0);
	mData,aData : in std_logic_vector(15 downto 0);
	wM1,wA1,wM2,wA2 : out std_logic;
	s1,d1,s2,d2 : out std_logic_vector(15 downto 0));	

End Entity;


Architecture Dec of decode is

Component reg_file is 

port(	clk,rst,wM,wA : in std_logic ;	
	RSrc1,RDst1,RSrc2,RDst2,WMem,WAlu : in std_logic_vector(3 downto 0);
	memData,aluData : in std_logic_vector(15 downto 0);
	src1,dst1,src2,dst2 : out std_logic_vector(15 downto 0));	
	
End Component;

signal sAdd1,dAdd1,sAdd2,dAdd2 : std_logic_vector (3 downto 0);

begin 


process(inst)

begin
if ((inst(31 downto 27) = "00011") or (inst(31 downto 27) = "00100") or (inst(31 downto 27) = "00101") or (inst(31 downto 30) = "01") or (inst(31 downto 30) = "11")) then

	sAdd1 <= inst(26 downto 23);
elsif ((inst(15 downto 11) = "00011") or (inst(15 downto 11) = "00100") or (inst(15 downto 11) = "00101") or (inst(15 downto 14) = "01")    or (inst(15 downto 14) = "11")) then   -- if it ret or rti hytl3 address brdo
	
	sAdd1 <= inst(10 downto 7);
	
end if;
	
if ((inst(31 downto 27) = "01000") or (inst(31 downto 27) = "01001") or (inst(31 downto 27) = "01010") or (inst(31 downto 27) = "01011") or (inst(31 downto 27) = "01100")) then 

	dAdd1 <= inst(22 downto 19);

elsif ((inst(15 downto 11) = "01000") or (inst(15 downto 11) = "01001") or (inst(15 downto 11) = "01010") or (inst(15 downto 11) = "01011") or (inst(15 downto 11) = "01100")) then

	dAdd1 <= inst(6 downto 3);
end if;

if ((inst(31 downto 30) = "10")  ) then
	sAdd2 <= inst(26 downto 23);
elsif ((inst(15 downto 14) = "10")  ) then
	sAdd2 <= inst(10 downto 7);
end if;


if ((inst(31 downto 27) = "10011") or (inst(31 downto 27) = "10100")) then
	dAdd2 <= inst(22 downto 19);
elsif ((inst(15 downto 11) = "10011") or (inst(15 downto 11) = "10100")) then
	dAdd2 <= inst(6 downto 3);
end if;

--if (inst(31 downto 30) = "01" or inst

end process;

rf : reg_file port map(clk,rst,wMem,wAlu,sAdd1,dAdd1,sAdd2,dAdd2,wMAdd,wAAdd,mData,aData,s1,d1,s2,d2);
wM <= '1'; 
wA <= '1';
end Dec;
