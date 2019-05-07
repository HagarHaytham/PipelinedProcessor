LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY RAWDetection IS
    port(instr0,instr1 : in STD_LOGIC_VECTOR(15 DOWNTO 0); 
    -- instr0 is the instruction from D/E buffer (the upper part)
    -- instr1 is the instruction from F/D buffer (the lower part)
        ETE : out STD_LOGIC);
END ENTITY RAWDetection;

Architecture RAWDetectionArch OF RAWDetection IS
SIGNAL Rdst0,Rsrc1: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL Opcode0,Opcode1 : STD_LOGIC_VECTOR (4 DOWNTO 0);

begin
    Rdst0<= instr0(6 DOWNTO 3);
    Rsrc1<= instr1(10 DOWNTO 7);
    Opcode0<=instr0(15 DOWNTO 11);
    Opcode1<=instr1(15 DOWNTO 11);

    process (instr0,instr1)
        begin
            -- instr0and instr1 are 2 ALU instructions and instr0 has WB 
            -- instr0 is any ALU operation other than NOP,SETC,CLRC 
            -- NOP '00000'
            -- SETC '00001'
            -- CLRC '00010'
            if (Opcode0(4) ='0' and Opcode0 /= "00000" and Opcode0 /= "00001" and Opcode0 /= "00010" and Opcode1(4)='0') then
                if (Rdst0 =  Rsrc1) then
                    ETE <= '1';
                else
                    ETE <= '0';
                end if;
            else
                ETE <= '0';
            end if;
    end process;
END Architecture;