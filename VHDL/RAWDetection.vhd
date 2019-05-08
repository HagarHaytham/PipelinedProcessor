LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY RAWDetection IS
    port(packet0,packet1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
    -- packet0 is the instruction from D/E buffer 
    -- packet1 is the instruction from F/D buffer 
        ETE : out STD_LOGIC); -- Execute To Execute Control Signal
        -- TO DO in Processor 
        -- Forward From M/W To D/M if ETE =1 
END ENTITY RAWDetection;

Architecture RAWDetectionArch OF RAWDetection IS
SIGNAL Rsrc0,Rdst0,Rsrc1,Rdst1: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL detect : STD_LOGIC ;


BEGIN 

    process (packet0,packet1,detect)
        begin
            -- instr0 and instr1 are 2 ALU instructions and instr0 has WB 
            -- instr0 is any ALU operation other than NOP,SETC,CLRC 
            -- NOP '00000'
            -- SETC '00001'
            -- CLRC '00010'
            

            if ((Packet0(15)='0' and packet0(15 DOWNTO 11) /="00000" and packet0(15 DOWNTO 11)/="00001" and packet0(15 DOWNTO 11) /= "00010")
             and (packet1(15)='0') )then -- first ALU without WB and first ALU
                detect<='1';
                Rsrc0 <= packet0(10 DOWNTO 7);--Rsrc00;
                Rdst0 <= packet0(6 DOWNTO 3);--Rdst00;
                Rsrc1 <= packet1(10 DOWNTO 7);--Rsrc10;
                Rdst1 <= packet1(6 DOWNTO 3);--Rdst10;

            elsif ((Packet0(15)='0' and packet0(15 DOWNTO 11) /="00000" and packet0(15 DOWNTO 11)/="00001" and packet0(15 DOWNTO 11) /= "00010")
            and packet1(15)='1' and packet1(31) = '0') then -- first ALU without WB and first L/s ,Second ALU
                detect<='1';
                Rsrc0 <=  packet0(10 DOWNTO 7);--Rsrc00;
                Rdst0 <= packet0(6 DOWNTO 3);--Rdst00;
                Rsrc1 <= packet1(26 DOWNTO 23);--Rsrc11;
                Rdst1 <= packet1(22 DOWNTO 19);--Rdst11;

            elsif (packet0(15) ='1' and packet0(31 DOWNTO 27) /= "00000"and packet0(31 DOWNTO 27)/="00001" and packet0(31 DOWNTO 27) /= "00010") then -- first L/s ,Second ALU without Wb
                if (packet1(15)='0') then -- first ALU
                    Rsrc0 <= packet0(26 DOWNTO 23);--Rsrc01;
                    Rdst0 <= packet0(22 DOWNTO 19);--Rdst01;
                    detect <='1';
                    Rsrc1 <= packet1(10 DOWNTO 7);--Rsrc10;
                    Rdst1 <=  packet1(6 DOWNTO 3);--Rdst10;
                elsif (packet1(15)='1' and packet1(31) = '0') then -- First L/S , Second ALU
                    Rsrc0 <= packet0(26 DOWNTO 23);--Rsrc01;
                    Rdst0 <= packet0(22 DOWNTO 19);--Rdst01;
                    detect <='1';
                    Rsrc1 <= packet1(26 DOWNTO 23);--Rsrc11;
                    Rdst1 <= packet1(26 DOWNTO 23);--Rdst11;
                else
                    detect<='0';
                end if;
            else
                detect <='0';
            end if;

            if (detect ='1') then -- first alu and first alu
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