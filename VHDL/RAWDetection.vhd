LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY RAWDetection IS
    port(instr0,instr1 : in STD_LOGIC_VECTOR(15 DOWNTO 0); 
    -- instr0 is the instruction from D/E buffer (the upper part)
    -- instr1 is the instruction from F/D buffer (the lower part)
        ETE : out STD_LOGIC);
END ENTITY RAWDetection;

Architecture RAWDetectionArch OF RAWDetection IS
SIGNAL Rdst0,Rdst1,Rsrc1: STD_LOGIC_VECTOR(3 DOWNTO 0);

begin
    Rdst0<= instr0(6 DOWNTO 3);
    Rdst1<= instr1(6 DOWNTO 3);
    Rsrc1<= instr1(10 DOWNTO 7);
    process (instr0,instr1)
        begin
            -- instr0and instr1 are 2 ALU instructions and instr0 has WB 
            
    end process;
END Architecture;