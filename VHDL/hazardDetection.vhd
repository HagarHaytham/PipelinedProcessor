LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY HazardDetection IS
    port(packet0,packet1 : in STD_LOGIC_VECTOR(31 DOWNTO 0);-- packet 0 is the first packet to enter the pipes,packet 1 is the second
        clk: in STD_LOGIC;
        )
END ENTITY HazardDetection;

Architecture HazardDetectionArch of HazardDetection is

begin

end Architecture;