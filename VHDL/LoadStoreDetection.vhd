LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY LoadStoreDetection IS
    port(packet0,packet1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
    -- packet0 is the instruction from D/E buffer 
    -- packet1 is the instruction from F/D buffer 
        MTM : OUT STD_LOGIC; -- Memory to memory control signal
        srcdst : OUT STD_LOGIC); -- to dectect forwarding to dst or src
        -- TO DO in Processor 
        -- Forward From M/W To D/M if MTM =1 
        -- Forward src if srcdst =0
        -- Forward dst if srcdst =1
END ENTITY LoadStoreDetection;

ARCHITECTURE LoadStoreDetectionArch OF LoadStoreDetection IS

SIGNAL Rsrc0,Rdst0,Rsrc1,Rdst1: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL detect : STD_LOGIC ;

BEGIN
    
    PROCESS (packet0,packet1,detect)
        begin
            -- instr0 is load and instr1 is store
            if ((packet0(15 DOWNTO 11) ="10011") and (packet1(15 DOWNTO 11)="10100") )then -- first load and first std
                detect<='1';
                Rsrc0 <= packet0(10 DOWNTO 7);--Rsrc00;
                Rdst0 <= packet0(6 DOWNTO 3);--Rdst00;
                Rsrc1 <= packet1(10 DOWNTO 7);--Rsrc10;
                Rdst1 <= packet1(6 DOWNTO 3);--Rdst10;
            elsif (packet0(15 DOWNTO 11) ="10011" and packet1(15)='0' and packet1(31 DOWNTO 27) = "10100") then
                detect<='1';
                Rsrc0 <=  packet0(10 DOWNTO 7);--Rsrc00;
                Rdst0 <= packet0(6 DOWNTO 3);--Rdst00;
                Rsrc1 <= packet1(26 DOWNTO 23);--Rsrc11;
                Rdst1 <= packet1(22 DOWNTO 19);--Rdst11;
            elsif (packet0(15) ='0' and packet0(31 DOWNTO 27) = "10011") then
                if (packet1(15 DOWNTO 11)="10100") then
                    Rsrc0 <= packet0(26 DOWNTO 23);--Rsrc01;
                    Rdst0 <= packet0(22 DOWNTO 19);--Rdst01;
                    detect <='1';
                    Rsrc1 <= packet1(10 DOWNTO 7);--Rsrc10;
                    Rdst1 <=  packet1(6 DOWNTO 3);--Rdst10;
                elsif (packet1(15)='0' and packet1(31 DOWNTO 27) = "10100") then
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

            if (detect ='1')then
                if (Rdst0 = Rsrc1)  then
                    MTM <='1';
                    srcdst <= '0';-- forward src
                elsif (Rdst0 = Rdst1) then
                    MTM <='1';
                    srcdst <= '1'; -- forward dst
                else
                    MTM <='0';
                    srcdst <= '0'; --dummy
                end if;
            else
                MTM <='0';
                srcdst <= '0'; -- dummy
            end if;

    END PROCESS;
END ARCHITECTURE;