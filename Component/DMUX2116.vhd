library ieee;
use ieee.std_logic_1164.all;

entity DMUX2116 is
  port(A0,A1:out std_logic_vector(15 downto 0);
       S:in std_logic_vector(0 downto 0);
		 Q:in std_logic_vector(15 downto 0));
end entity;

architecture Struct of DMUX2116 is 
   
begin 
PROCESS (Q,S)
	BEGIN
		IF S = "0" THEN
			A0<=Q;
		ELSIF S = "1" THEN
			A1 <= Q;
			END IF;
	END PROCESS;
end Struct;