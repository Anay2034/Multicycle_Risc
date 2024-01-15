LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY multi IS
	PORT (
		A,B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		
		Q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY;

ARCHITECTURE behav OF multi IS
begin 
process(A,B)
begin 
Q(7 downto 0) <= STD_LOGIC_VECTOR((unsigned(A(3 downto 0))) * (unsigned (B(3 downto 0))));
Q(15 downto 8) <= "00000000";
end process;
end architecture;