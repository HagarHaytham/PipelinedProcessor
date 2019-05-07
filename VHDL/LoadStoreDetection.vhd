LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY LoadStoreDetection IS
    port(instr0,instr1 : in STD_LOGIC_VECTOR(15 DOWNTO 0); 
    -- instr0 is the instruction from D/E buffer (the upper part)
    -- instr1 is the instruction from F/D buffer (the lower part)
        MTM : out STD_LOGIC);
END ENTITY LoadStoreDetection;

Architecture LoadStoreDetectionArch OF LoadStoreDetection IS
SIGNAL Rdst0,Rdst1,Rsrc1: STD_LOGIC_VECTOR(3 DOWNTO 0);

begin
    Rdst0<= instr0(6 DOWNTO 3);
    Rdst1<= instr1(6 DOWNTO 3);
    Rsrc1<= instr1(10 DOWNTO 7);
    process (instr0,instr1)
        begin
            -- instr0 is load and instr1 is store
            if (instr0(15 DOWNTO 11)= "10011" and instr1(15 DOWNTO 11)="10100")then
                if (Rdst0 = Rsrc1 or Rdst0 = Rdst1) then
                    MTM<='1';
                else
                    MTM<='0';
                end  if;
            else
                MTM<='0';
            end if;
    end process;
END Architecture;