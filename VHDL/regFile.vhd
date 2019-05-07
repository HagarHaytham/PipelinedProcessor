LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

Entity reg_file is 

port(	clk,rst,wM,wA : in std_logic ;	
	RSrc1,RDst1,RSrc2,RDst2,WMem,WAlu : in std_logic_vector(3 downto 0);
	memData,aluData : in std_logic_vector(15 downto 0);
	flags : in std_logic_vector(2 downto 0);
	fROut : out std_logic_vector(2 downto 0);
	src1,dst1,src2,dst2 : out std_logic_vector(15 downto 0));	
	
End Entity;


Architecture rFile of reg_file is

Component n_reg IS
GENERIC(n : INTEGER:=16);
	PORT(
		d		:	IN	std_logic_vector(n-1 downto 0);
		en, clk, rst	:	IN	std_logic;
		q		:	OUT	std_logic_vector(n-1 downto 0)
	);
END Component;

Component dec4X16 IS
	PORT(
		bits	:	IN	std_logic_vector(3 downto 0);
		en	:	IN	std_logic;
		selc	:	OUT	std_logic_vector(15 downto 0)
	);
END Component;


Component n_tri_buffer IS
GENERIC(n : INTEGER:=8);
	PORT(
		a	:	IN	std_logic_vector(n-1 downto 0);
		en	:	IN	std_logic;
		f	:	OUT	std_logic_vector(n-1 downto 0)
	);
END Component;




signal selMem  : std_logic_vector(15 downto 0);
signal selalu  : std_logic_vector(15 downto 0);

signal regOut0 : std_logic_vector(15 downto 0);
signal regOut1 : std_logic_vector(15 downto 0);
signal regOut2 : std_logic_vector(15 downto 0);
signal regOut3 : std_logic_vector(15 downto 0);
signal regOut4 : std_logic_vector(15 downto 0);
signal regOut5 : std_logic_vector(15 downto 0);
signal regOut6 : std_logic_vector(15 downto 0);
signal regOut7 : std_logic_vector(15 downto 0);
signal fRegOut : std_logic_vector(2 downto 0);

signal regIn0 : std_logic_vector(15 downto 0);
signal regIn1 : std_logic_vector(15 downto 0);
signal regIn2 : std_logic_vector(15 downto 0);
signal regIn3 : std_logic_vector(15 downto 0);
signal regIn4 : std_logic_vector(15 downto 0);
signal regIn5 : std_logic_vector(15 downto 0);
signal regIn6 : std_logic_vector(15 downto 0);
signal regIn7 : std_logic_vector(15 downto 0);

signal regEn0,regEn1,regEn2,regEn3,regEn4,regEn5,regEn6,regEn7 : std_logic;

Begin



wMemDec : dec4X16 port map(WMem,wM,selMem);
wAluDec : dec4X16 port map(WAlu,wA,selAlu);

regIn0 <= memData when (WMem = "0000") else aluData when(WAlu = "0000");
regIn1 <= memData when (WMem = "0001") else aluData when(WAlu = "0001");
regIn2 <= memData when (WMem = "0010") else aluData when(WAlu = "0010");
regIn3 <= memData when (WMem = "0011") else aluData when(WAlu = "0011");
regIn4 <= memData when (WMem = "0100") else aluData when(WAlu = "0100");
regIn5 <= memData when (WMem = "0101") else aluData when(WAlu = "0101");
regIn6 <= memData when (WMem = "0110") else aluData when(WAlu = "0110");
regIn7 <= memData when (WMem = "0111") else aluData when(WAlu = "0111");


regEn0 <= selMem(0) or selAlu(0);
regEn1 <= selMem(1) or selAlu(1);
regEn2 <= selMem(2) or selAlu(2);
regEn3 <= selMem(3) or selAlu(3);
regEn4 <= selMem(4) or selAlu(4);
regEn5 <= selMem(5) or selAlu(5);
regEn6 <= selMem(6) or selAlu(6);
regEn7 <= selMem(7) or selAlu(7);
--fRegEn <= selMem(10) or selAlu(10);

reg0 : n_reg generic map(16) port map(regIn0,regEn0,clk,rst,regOut0);
reg1 : n_reg generic map(16) port map(regIn1,regEn1,clk,rst,regOut1);
reg2 : n_reg generic map(16) port map(regIn2,regEn2,clk,rst,regOut2);
reg3 : n_reg generic map(16) port map(regIn3,regEn3,clk,rst,regOut3);
reg4 : n_reg generic map(16) port map(regIn4,regEn4,clk,rst,regOut4);
reg5 : n_reg generic map(16) port map(regIn5,regEn5,clk,rst,regOut5);
reg6 : n_reg generic map(16) port map(regIn6,regEn6,clk,rst,regOut6);
reg7 : n_reg generic map(16) port map(regIn7,regEn7,clk,rst,regOut7);
flagReg : n_reg generic map(3) port map(flags,'1',clk,rst,fRegOut);


process (clk,RSrc1,RDst1,RSrc2,RDst2,WMem,WAlu)

begin
  if(rst = '1') then
	src1 <= (others => '0');
	dst1 <= (others => '0');
	src2 <= (others => '0');
	dst2 <= (others => '0');
  else
	if(Rsrc1 = WMem ) then
		src1 <= memData;
	elsif (Rsrc1 = WAlu ) then
		src1 <= aluData;
	elsif (RSrc1 = "0000") then
		src1 <= regOut0;
	elsif (RSrc1 = "0001") then
		src1 <= regOut1;
	elsif (RSrc1 = "0010") then
		src1 <= regOut2;
	elsif (RSrc1 = "0011") then
		src1 <= regOut3;
	elsif (RSrc1 = "0100") then
		src1 <= regOut4;
	elsif (RSrc1 = "0101") then
		src1 <= regOut5;
	elsif (RSrc1 = "0110") then
		src1 <= regOut6;
	elsif (Rsrc1 = "0111") then
		src1 <= regOut7;
	elsif (Rsrc1 = "1010") then
		src1 <= "0000000000000" & fRegOut;
	end if;


   
	if(RDst1 = WMem ) then
		dst1 <= memData;
	elsif (RDst1 = WAlu ) then
		dst1 <= aluData;
	elsif (RDst1 = "0000") then
		dst1 <= regOut0;
	elsif (RDst1 = "0001") then
		dst1 <= regOut1;
	elsif (RDst1 = "0010") then
		dst1 <= regOut2;
	elsif (RDst1 = "0011") then
		dst1 <= regOut3;
	elsif (RDst1 = "0100") then
		dst1 <= regOut4;
	elsif (RDst1 = "0101") then
		dst1 <= regOut5;
	elsif (RDst1 = "0110") then
		dst1 <= regOut6;
	elsif (RDst1 = "0111") then
		dst1 <= regOut7;
	end if;

	if(Rsrc2 = WMem ) then
		src2 <= memData;
	elsif (Rsrc2 = WAlu ) then
		src2 <= aluData;
	elsif (RSrc2 = "0000") then
		src2 <= regOut0;
	elsif (RSrc2 = "0001") then
		src2 <= regOut1;
	elsif (RSrc2 = "0010") then
		src2 <= regOut2;
	elsif (RSrc2 = "0011") then
		src2 <= regOut3;
	elsif (RSrc2 = "0100") then
		src2 <= regOut4;
	elsif (RSrc2 = "0101") then
		src2 <= regOut5;
	elsif (RSrc2 = "0110") then
		src2 <= regOut6;
	elsif (Rsrc2 = "0111") then
		src2 <= regOut7;
	elsif (Rsrc2 = "1010") then
		src2 <= "0000000000000" & fRegOut;
	end if;

	if(RDst2 = WMem ) then
		dst2 <= memData;
	elsif (RDst2 = WAlu ) then
		dst2 <= aluData;
	elsif (RDst2 = "0000") then
		dst2 <= regOut0;
	elsif (RDst2 = "0001") then
		dst2 <= regOut1;
	elsif (RDst2 = "0010") then
		dst2 <= regOut2;
	elsif (RDst2 = "0011") then
		dst2 <= regOut3;
	elsif (RDst2 = "0100") then
		dst2 <= regOut4;
	elsif (RDst2 = "0101") then
		dst2 <= regOut5;
	elsif (RDst2 = "0110") then
		dst2 <= regOut6;
	elsif (RDst2 = "0111") then
		dst2 <= regOut7;
	end if;


   end if;
end process;
fROut <= fRegOut;
end rFile;