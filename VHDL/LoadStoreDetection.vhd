LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY LoadStoreDetection IS
    port(packet0,packet1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
    -- packet0 is the instruction from D/E buffer 
    -- packet1 is the instruction from F/D buffer 
        MTM : OUT STD_LOGIC;
        srcdst : OUT STD_LOGIC); -- to dectect forwarding to dst or src
        -- if 0 forward to src , and if 1 forward to dst
END ENTITY LoadStoreDetection;

ARCHITECTURE LoadStoreDetectionArch OF LoadStoreDetection IS
-- SIGNAL instr00,instr01, instr10, instr11 : STD_LOGIC_VECTOR(15 DOWNTO 0);
-- SIGNAL Rdst00,Rdst01,Rdst10,Rdst11,Rsrc00,Rsrc01,Rsrc10,Rsrc11 : STD_LOGIC_VECTOR(3 DOWNTO 0);
-- SIGNAL Opcode00,Opcode01,Opcode10,Opcode11,LoadOpcode,StoreOpcode  : STD_LOGIC_VECTOR (4 DOWNTO 0);

SIGNAL Rsrc0,Rdst0,Rsrc1,Rdst1: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL detect : STD_LOGIC ;

-- SIGNAL debug : STD_LOGIC_VECTOR (2 DOWNTO 0) ;
BEGIN
    
    -- instr00 <= packet0(15 DOWNTO 0);
    -- instr01 <= packet0(31 DOWNTO 16);
    -- instr10 <= packet1(15 DOWNTO 0);
    -- instr11 <= packet1(31 DOWNTO 16);

    -- Rdst00  <= instr00(6 DOWNTO 3);
    -- Rdst01  <= instr01(6 DOWNTO 3);  
    -- Rdst10  <= instr10(6 DOWNTO 3);
    -- Rdst11  <= instr11(6 DOWNTO 3);

    -- Rsrc00  <= instr00(10 DOWNTO 7);
    -- Rsrc01  <= instr01(10 DOWNTO 7);  
    -- Rsrc10  <= instr10(10 DOWNTO 7);
    -- Rsrc11  <= instr11(10 DOWNTO 7);

    -- Opcode00 <= instr00(15 DOWNTO 11);
    -- Opcode01 <= instr01(15 DOWNTO 11);
    -- Opcode10 <= instr10(15 DOWNTO 11);
    -- Opcode11 <= instr11(15 DOWNTO 11);
    
    -- LoadOpcode  <= "10011";
    -- StoreOpcode <= "10100";

    PROCESS (packet0,packet1,detect)
        begin
            -- instr0 is load and instr1 is store
            if ((packet0(15 DOWNTO 11) ="10011") and (packet1(15 DOWNTO 11)="10100") )then
                detect<='1';
                Rsrc0 <= packet0(10 DOWNTO 7);--Rsrc00;
                Rdst0 <= packet0(6 DOWNTO 3);--Rdst00;
                Rsrc1 <= packet1(10 DOWNTO 7);--Rsrc10;
                Rdst1 <= packet1(6 DOWNTO 3);--Rdst10;
                -- debug <="000";
            elsif (packet0(15 DOWNTO 11) ="10011" and packet1(15)='0' and packet1(31 DOWNTO 27) = "10100") then
                detect<='1';
                Rsrc0 <=  packet0(10 DOWNTO 7);--Rsrc00;
                Rdst0 <= packet0(6 DOWNTO 3);--Rdst00;
                Rsrc1 <= packet1(26 DOWNTO 23);--Rsrc11;
                Rdst1 <= packet1(22 DOWNTO 19);--Rdst11;
                -- debug <="001";
            elsif (packet0(15) ='0' and packet0(31 DOWNTO 27) = "10011") then
                if (packet1(15 DOWNTO 11)="10100") then
                    Rsrc0 <= packet0(26 DOWNTO 23);--Rsrc01;
                    Rdst0 <= packet0(22 DOWNTO 19);--Rdst01;
                    detect <='1';
                    Rsrc1 <= packet1(10 DOWNTO 7);--Rsrc10;
                    Rdst1 <=  packet1(6 DOWNTO 3);--Rdst10;
                    -- debug <="010";
                elsif (packet1(15)='0' and packet1(31 DOWNTO 27) = "10100") then
                    Rsrc0 <= packet0(26 DOWNTO 23);--Rsrc01;
                    Rdst0 <= packet0(22 DOWNTO 19);--Rdst01;
                    detect <='1';
                    Rsrc1 <= packet1(26 DOWNTO 23);--Rsrc11;
                    Rdst1 <= packet1(26 DOWNTO 23);--Rdst11;
                    -- debug <="011";
                else
                    detect<='0';
                    -- debug <="100";
                end if;
            else
                detect <='0';
                -- debug <="101";
            end if;

            if (detect ='1')then
                if (Rdst0 = Rsrc1)  then
                    MTM <='1';
                    srcdst <= '0';
                elsif (Rdst0 = Rdst1) then
                    MTM <='1';
                    srcdst <= '1';
                else
                    MTM <='0';
                    srcdst <= '0';
                end if;
            else
                MTM <='0';
                srcdst <= '0';
            end if;

    END PROCESS;
END ARCHITECTURE;