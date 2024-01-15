library ieee;
use ieee.std_logic_1164.all;

entity MUX_21 is
  port(A:in std_logic_vector(1 downto 0);
       S:in std_logic_vector(0 downto 0);
		 Q:out std_logic_vector(0 downto 0));
end entity MUX_21;

architecture Struct of MUX_21 is 
   
begin 
Q(0)<=(not S(0) and A(0)) or (S(0) and A(1));
end Struct;