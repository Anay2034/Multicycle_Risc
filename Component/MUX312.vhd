library ieee;
use ieee.std_logic_1164.all;

entity MUX213 is
  port(A0,A1:in std_logic_vector(3 downto 0);
       S:in std_logic_vector(0 downto 0);
		 Q:out std_logic_vector(3 downto 0));
end entity;

architecture Struct of MUX213 is 
   
begin 
PROCESS (A0, A1,S)
	BEGIN
		IF S = "0" THEN
			Q <= A0;
		ELSIF S = "1" THEN
			Q <= A1;
			END IF;
	END PROCESS;
end Struct;