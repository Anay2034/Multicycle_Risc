library ieee;
use ieee.std_logic_1164.all;

entity FA is 
   port(A:in std_logic_vector(0 downto 0);
	     B:in std_logic_vector(0 downto 0);
		  Cin:in std_logic_vector(0 downto 0);
		  S:out std_logic_vector(0 downto 0);
		  Cout:out std_logic_vector(0 downto 0));
end entity FA;

architecture Struct of FA is
    
begin
S<=A xor B xor Cin;
Cout<=((A and B) or (Cin and (A or B)));
end Struct;
