LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY StructuralHazard IS
    port(opcode1,opcode0 : in STD_LOGIC_VECTOR(4 DOWNTO 0);
        hazard: out STD_LOGIC ;
        inst : out STD_LOGIC;
        pipe : out STD_LOGIC;
        Stall : out STD_LOGIC); -- stall fetching 
END ENTITY StructuralHazard;

Architecture StructuralHazardArch OF StructuralHazard IS

begin
process(opcode1,opcode0)
begin
    if (opcode1(4)= opcode0(4)) then
        hazard <= '1';
        inst <= '0';
        pipe <= opcode1(4);
        stall <='1';
    else
        hazard <= '0';
        inst <= '0';
        stall <='0';
    end if;
    end process;
END Architecture;