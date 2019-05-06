LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_unsigned.ALL;
USE IEEE.numeric_std.all;

ENTITY ram IS
	PORT(
		clk : IN std_logic;
		word  : IN std_logic; 				-- 0-> OneWord, 1-> TwoWords
		RW  : IN std_logic; 				-- 0->read, 1->write
		address : IN  std_logic_vector(19 DOWNTO 0);	-- 20bits addr
		datain  : IN  std_logic_vector(31 DOWNTO 0);	-- if write needed
		data32 : OUT std_logic_vector(31 DOWNTO 0));	-- data Out 32bit if word=0, 16bit if word=1
		
END ENTITY ram;

ARCHITECTURE syncram OF ram IS

	TYPE ram_type IS ARRAY(0 TO 1048576) OF std_logic_vector(15 DOWNTO 0);
	
	SIGNAL ram : ram_type :=(
	0 => X"0000",1 => X"0101",2 => X"0102",16#38# => X"0103",16#39# => X"0104",16#3A# => X"0105",OTHERS => X"00FF"
	);
	
	BEGIN
		PROCESS(clk) IS
			BEGIN
				IF rising_edge(clk) THEN  
					IF RW = '1' THEN
					     ram(to_integer(unsigned(address))) <= datain(15 downto 0);
					     IF word = '1' THEN
						ram(to_integer(unsigned(address + '1'))) <= datain(31 downto 16);
					     END IF;
						
					ELSE IF word = '0' THEN
						data32(15 downto 0) <= ram(to_integer(unsigned(address)));
						data32(31 downto 16) <= X"0000";
					     ELSE 
						data32(15 downto 0) <= ram(to_integer(unsigned(address)));
						data32(31 downto 16) <= ram(to_integer(unsigned(address + '1')));
					     END IF;
					END IF;
				END IF;
		END PROCESS;

		
END syncram;