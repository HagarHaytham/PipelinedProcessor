LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY LoadUseDetection IS
    port(packet0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
    -- packet0 is the instruction from D/E buffer 
        Stall : out STD_LOGIC; 
        Pipe : OUT STD_LOGIC); -- Pipe 0 -> ALU(E) , Pipe 1 -> MEM
END ENTITY LoadUseDetection;

ARCHITECTURE LoadUseDetectionArch OF LoadUseDetection IS

BEGIN 
PROCESS(packet0)
    BEGIN
        if (packet0(15 DOWNTO 11)="10011" and packet0(31)='0') then -- Load first then ALU
            if (packet0(6 DOWNTO 3)= packet0(22 DOWNTO 19))then-- Rdst of load = Rdst of ALU
                Stall<='1';
                Pipe<='0'; --ALU
            elsif (packet0(6 DOWNTO 3)=packet0(26 DOWNTO 23))then -- Rdst of Load = Rsrc of ALU
                Stall<='1';
                Pipe<='0'; --ALU
            else
                Stall<='0';
                Pipe<='0'; -- dummy
            end if;
        elsif (packet0(15)='0' and packet0(15 DOWNTO 11) /="00000" and packet0(15 DOWNTO 11)/="00001" and packet0(15 DOWNTO 11) /= "00010") then -- ALU 
            if (packet0(31 DOWNTO 27) ="10011") then-- Load
            -- Rdst of Alu = Rsrc of load only
                if (packet0(10 DOWNTO 7)=packet0(26 DOWNTO 23))then
                    Stall<='1';
                    Pipe<='1';-- MEM
                else
                    Stall<='0';
                    Pipe<='0'; -- dummy 
                end if;
            elsif(packet0(31 DOWNTO 27) ="10100")then -- Store
            -- Rdst of ALU is Rsrc of store or Rdstof store
                if (packet0(10 DOWNTO 7)=packet0(26 DOWNTO 23) or packet0(10 DOWNTO 7) = packet0(22 DOWNTO 19) )then
                    Stall<='1';
                    Pipe<='1';-- MEM
                else
                    Stall<='0';
                    Pipe<='0'; -- dummy 
                end if;
            else
                Stall<='0';
                Pipe <='0';--dummy

            end if;
        else
            Stall<='0';
            Pipe <='0';--dummy
        end if;
    END PROCESS;
END ARCHITECTURE;