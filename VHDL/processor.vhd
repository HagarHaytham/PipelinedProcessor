LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY processor IS
	PORT(
		i_clkC	:	IN	std_logic;	--Input clock for processor control circuitry
		i_clkM	:	IN	std_logic;	--Input clock for memories
		i_rst	:	IN	std_logic;	--Reset signal for chip
		i_input	:	IN	std_logic_vector(15 downto 0);	--input port to be used with devices
		o_output:	OUT	std_logic_vector(15 downto 0)	--output port to be used with devices
	);
END ENTITY;

ARCHITECTURE struct OF processor IS

COMPONENT fetchCirc IS
	PORT(
		i_clkC	:	IN	std_logic;	--Input clock for control
		i_clkM	:	IN	std_logic;	--Input clock for memory
		i_rst	:	IN	std_logic;	--Reset signal for chip
		i_hzrd	:	IN	std_logic;	--A hazard is detected
		i_brnch	:	IN	std_logic;	--A branch is performed, to enable load
		i_adrs	:	IN	std_logic_vector(31 downto 0);	--Input address to PC, used with load
		o_inst	:	OUT	std_logic_vector(31 downto 0)	--Output instruction package
	);
END COMPONENT;

COMPONENT  decode IS
	PORT(
		inst	:	IN	std_logic_vector (31 downto 0);
		clk	:	IN	std_logic;
		rst	:	IN	std_logic;
		wMem	:	IN	std_logic;
		wAlu	:	IN	std_logic;
		wMAdd	:	IN	std_logic_vector(3 downto 0);
		wAAdd	:	IN	std_logic_vector(3 downto 0);
		fData	:	IN	std_logic_vector(2 downto 0);
		mData	:	IN	std_logic_vector(15 downto 0);
		aData	:	IN	std_logic_vector(15 downto 0);
		wM	:	OUT	std_logic;
		wA	:	OUT	std_logic;
		s1	:	OUT	std_logic_vector(15 downto 0);
		d1	:	OUT	std_logic_vector(15 downto 0);
		s2	:	OUT	std_logic_vector(15 downto 0);
		d2	:	OUT	std_logic_vector(15 downto 0);
		opcode1	:	OUT	std_logic_vector(4 downto 0);
		opcode2	:	OUT	std_logic_vector(4 downto 0);
		src1	:	OUT	std_logic_vector(3 downto 0);
		src2	:	OUT	std_logic_vector(3 downto 0);
		dst1	:	OUT	std_logic_vector(3 downto 0);
		dst2	:	OUT	std_logic_vector(3 downto 0);
		fRegOut	:	OUT	std_logic_vector(2 downto 0)
	);	
END COMPONENT;

COMPONENT ALU IS
GENERIC (m:integer:=16);
	PORT(
		a,b	:	IN	STD_LOGIC_VECTOR(m-1 DOWNTO 0);  -- a (Rsrc) , b (Rdst or Imm)
        	s	:	IN	STD_LOGIC_VECTOR(4 DOWNTO 0); -- Opcode of the instruction
		flagsIn	:	IN	STD_LOGIC_VECTOR(2 DOWNTO 0);
        	c	:	OUT	STD_LOGIC_VECTOR(m-1 DOWNTO 0);
        	flagsOut:	OUT	STD_LOGIC_VECTOR(2 DOWNTO 0)); -- C - N - Z
END COMPONENT;

COMPONENT dataMemCirc IS
	PORT(
		i_clkC	:	IN	std_logic;	--Input clock for control
		i_clkM	:	IN	std_logic;	--Input clock for memory
		i_rst	:	IN	std_logic;	--Reset signal
		i_opcd	:	IN	std_logic_vector(4 downto 0);	--instruction opcode
		i_dst	:	IN	std_logic_vector(3 downto 0);	--destination register, as PC/SP are 32-bit regs
		i_adrs	:	IN 	std_logic_vector(19 DOWNTO 0);	--address lines
		i_data	:	IN	std_logic_vector(31 DOWNTO 0);	--data to write
		o_data	:	OUT	std_logic_vector(31 DOWNTO 0)	--data read
	);
END COMPONENT;

COMPONENT nReg IS
GENERIC (n:integer:=16);
	PORT (
		input		:	IN	std_logic_vector(n-1 downto 0);
		en,rst,clk	:	IN	std_logic;
		output		:	OUT	std_logic_vector(n-1 downto 0)
	);
END COMPONENT;

SIGNAL hzrd	:	std_logic;	--signal to detect hazard
SIGNAL brnch	:	std_logic;	--signal to indicate branch
SIGNAL instAdd	:	std_logic_vector(31 downto 0);	--Address lines for instruction memory

--Buffers signals
SIGNAL inFDBuf	:	std_logic_vector(31 downto 0);	--Input of fetch decode buffer, Instruction words fetched from instruction memory
SIGNAL outFDBuf	:	std_logic_vector(31 downto 0);	--Output of fetch decode buffer
SIGNAL inDABuf	:	std_logic_vector(41 downto 0);	
SIGNAL outDABuf	:	std_logic_vector(41 downto 0);
SIGNAL inDMBuf	:	std_logic_vector(41 downto 0);
SIGNAL outDMBuf	:	std_logic_vector(41 downto 0);
SIGNAL inAWBuf	:	std_logic_vector(20 downto 0);
SIGNAL outAWBuf	:	std_logic_vector(20 downto 0);
SIGNAL inMWBuf	:	std_logic_vector(36 downto 0);
SIGNAL outMWBuf	:	std_logic_vector(36 downto 0);
SIGNAL outDDBuf	:	std_logic_vector(31 downto 0);

--data dependency signals
SIGNAL instDD	:	std_logic_vector(31 downto 0);

--dummy
SIGNAL src1Dec	:	std_logic_vector(3 downto 0);
SIGNAL src2Dec	:	std_logic_vector(3 downto 0);

--Control signals
SIGNAL clkBuf	:	std_logic;	--Inverted clock for buffers
SIGNAL bufEn	:	std_logic;	--enable of buffers

SIGNAL flagAD	:	std_logic_vector(2 downto 0);	--Input value for flag register from ALU
SIGNAL flagDA	:	std_logic_vector(2 downto 0);	--Output flag register data from decode

SIGNAL adrsDtaM	:	std_logic_vector(19 downto 0);	--Address for data memory, is connected to decode output, or stack pointer when pushing/poping
SIGNAL dataM	:	std_logic_vector(31 downto 0);

BEGIN

	--connect PC input to out of data memory and input address of '0' to memory when i_rst = 1
	instAdd <= outMWBuf(31 downto 0)	WHEN i_rst = '1'
	ELSE x"00000000"	WHEN i_rst = '0';

	ftch:	fetchCirc PORT MAP(i_clkC, i_clkM, i_rst, hzrd, brnch, instAdd, inFDBuf);

	--this buffer connects fetch with decode, it's 32-bit
	--16 bits for each instruction
	bufFD:	nReg GENERIC MAP(32) PORT MAP(inFDBuf, bufEn, i_rst, clkBuf, outFDBuf);

	--Decode Module
	dcd:	decode PORT MAP(outFDBuf, i_clkC, i_rst, outMWBuf(36), outAWBuf(20),
				outMWBuf(35 downto 32), outAWBuf(19 downto 16), flagAD, outMWBuf(15 downto 0), outAWBuf(15 downto 0),
				inDMBuf(41), inDABuf(41), inDABuf(31 downto 16), inDABuf(15 downto 0), inDMBuf(31 downto 16),
				inDMBuf(15 downto 0), inDABuf(40 downto 36), inDMBuf(40 downto 36), src1Dec, src2Dec,
				inDABuf(35 downto 32), inDMBuf(35 downto 32), flagDA);

	--this buffer has instructions for data dependency circuit 
	bufDD:	nReg GENERIC MAP(32) PORT MAP(outFDBuf, '1', i_rst, clkBuf, outDDBuf);

	--this buffer conneccts decode with ALU execution, it's 38-bit
	--1 bit travels all the way to writeback buffer to indicate if a writeback is required
	--5 bits for instruction opcode
	--4 bits for destination register
	--32 bits for data, 16 bits for src and 16 for dst
	bufDE:	nReg GENERIC MAP(42) PORT MAP(inDABuf, bufEn, i_rst, clkBuf, outDABuf);

	--this buffer connects decode with data memory execution, it's 38-bit
	--1 bit travels all the way to writeback buffer to indicate if a writeback is required
	--5 bits for instruction opcode
	--4 bits for destination register
	--32 bits for data, 16 bits for address and 16 bits for src
	bufDM:	nReg GENERIC MAP(42) PORT MAP(inDMBuf, bufEn, i_rst, clkBuf, outDMBuf);

	--ALU Module
	aluU:	ALU GENERIC MAP(16) PORT MAP(outDABuf(31 downto 16), outDABuf(15 downto 0), outDABuf(40 downto 36), flagDA, inAWBuf(15 downto 0), flagAD);

	--this buffer conneccts ALU with writeback, it's 21-bit
	--1 bit for writeback
	--4 bits for address
	--16 bits for data
	bufAW:	nReg GENERIC MAP(21) PORT MAP(inAWBuf, bufEn, i_rst, clkBuf, outAWBuf);
	--its connections
	inAWBuf(20) <= outDABuf(41);
	inAWBuf(19 downto 16) <= outDABuf(35 downto 32);

	--Memory Module
	--Rsrc is memory address (default, except in STD)
	--Rdst is register address
	mem:	dataMemCirc PORT MAP(i_clkC, i_clkM, i_rst, outDMBuf(40 downto 36), outDMBuf(35 downto 32), adrsDtaM, dataM, inMWBuf(31 downto 0));
	--its connections
	adrsDtaM <= "00000000000000000000"	WHEN i_rst = '1'
	ELSE "0000" & outDMBuf(15 downto 0)	WHEN i_rst = '0'; --and outDMBuf(40 downto 36) = "10100"
--	ELSE "0000" & outDMBuf(15 downto 0);
	dataM <= x"0000" & outDMBuf(31 downto 16);

	--this buffer conneccts memory with writeback, it's 21-bit
	--1 bit for writeback
	--4 bits for address
	--32 bits for data
	bufMW:	nReg GENERIC MAP(37) PORT MAP(inMWBuf, bufEn, i_rst, clkBuf, outMWBuf);
	--its connections
	inMWBuf(36) <= outDMBuf(41);
	inMWBuf(35 downto 32) <= outDMBuf(35 downto 32);
	
	clkBuf <= not i_clkC;
	bufEn <= not hzrd;
	hzrd <= '0';
	brnch <= '0';

END ARCHITECTURE;
