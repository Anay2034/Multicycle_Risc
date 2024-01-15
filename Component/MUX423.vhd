library ieee;
use ieee.std_logic_1164.all;

entity MUX423 is
     port(A0,A1,A2,A3:in std_logic_vector(2 downto 0);
	       S:in std_logic_vector(1 downto 0);
			 Q:out std_logic_vector(2 downto 0));
end entity ;

architecture Struct of MUX423 is 
  
begin 
PROCESS (A0, A1, A2, A3, S)
	BEGIN
		IF S = "00" THEN
			Q <= A0;
		ELSIF S = "01" THEN
			Q <= A1;
		ELSIF S = "10" THEN
			Q <= A2;
		ELSE
			Q <= A3;
		END IF;
	END PROCESS;
end Struct;