LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY RAWDetection IS
    port(packet0,packet1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
    -- instr0 is the instruction from D/E buffer (the upper part)
    -- instr1 is the instruction from F/D buffer (the lower part)
        ETE : out STD_LOGIC);
END ENTITY RAWDetection;

Architecture RAWDetectionArch OF RAWDetection IS
SIGNAL instr00,instr01, instr10, instr11 : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL Rdst00,Rdst01,Rdst10,Rdst11,Rsrc00,Rsrc01,Rsrc10,Rsrc11 : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL Opcode00,Opcode01,Opcode10,Opcode11: STD_LOGIC_VECTOR (4 DOWNTO 0);

SIGNAL Rsrc0,Rdst0,Rsrc1,Rdst1: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL detect : STD_LOGIC ;


BEGIN 
    instr00 <= packet0(15 DOWNTO 0);
    instr01 <= packet0(31 DOWNTO 16);
    instr10 <= packet1(15 DOWNTO 0);
    instr11 <= packet1(31 DOWNTO 16);

    Rdst00  <= instr00(6 DOWNTO 3);
    Rdst01  <= instr01(6 DOWNTO 3);  
    Rdst10  <= instr10(6 DOWNTO 3);
    Rdst11  <= instr11(6 DOWNTO 3);

    Rsrc00  <= instr00(10 DOWNTO 7);
    Rsrc01  <= instr01(10 DOWNTO 7);  
    Rsrc10  <= instr10(10 DOWNTO 7);
    Rsrc11  <= instr11(10 DOWNTO 7);

    Opcode00 <= instr00(15 DOWNTO 11);
    Opcode01 <= instr01(15 DOWNTO 11);
    Opcode10 <= instr10(15 DOWNTO 11);
    Opcode11 <= instr11(15 DOWNTO 11);

    process (instr0,instr1)
        begin
            -- instr0 and instr1 are 2 ALU instructions and instr0 has WB 
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

            if (((Opcode00(4) ='0' and Opcode00 /= "00000" and Opcode00 /= "00001" and Opcode00 /= "00010" )and (Opcode1(4)='0') )or 
                ((Opcode10(4)='0') and (Opcode11 = StoreOpcode)) )then
                detect<='1';
                Rsrc0 <= Rsrc00;
                Rdst0 <= Rdst00;
                if (Opcode10=StoreOpcode) then
                    Rsrc1 <= Rsrc10;
                    Rdst1 <= Rdst10;
                else
                    Rsrc1 <= Rsrc11;
                    Rdst1 <= Rdst11;
                end if;
            elsif (Opcode00(4) ='0' and Opcode01 = LoadOpcode) then
                if (Opcode10=StoreOpcode) then
                    Rsrc0 <= Rsrc01;
                    Rdst0 <= Rdst01;
                    detect <='1';
                    Rsrc1 <= Rsrc10;
                    Rdst1 <= Rdst10;
                elsif (Opcode10(4)='0' and Opcode11 = StoreOpcode) then
                    Rsrc0 <= Rsrc01;
                    Rdst0 <= Rdst01;
                    detect <='1';
                    Rsrc1 <= Rsrc11;
                    Rdst1 <= Rdst11;
                else
                    detect<='0';
                end if;
            else
                detect <='0';
            end if;

            if (detect ='1')then
                if ((Rdst0 = Rsrc1) or (Rdst0 = Rdst1)) then
                    MTM <='1';
                else
                    MTM <='0';
                end if;
            else
                MTM <='0';
            end if;
    end process;
END Architecture;