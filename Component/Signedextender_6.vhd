library ieee;
use ieee.std_logic_1164.all;
library work;
entity Signedextender_6 is 
port (Imm:in std_logic_vector(5 downto 0);EE_6:in std_logic;SE:out std_logic_vector(15 downto 0));
end entity Signedextender_6;
architecture behav of Signedextender_6 is
begin 
Q:for i in 0 to 5 generate
SE(i)<=Imm(i) and EE_6;
end generate;
W:for i in 6 to 15 generate
SE(i)<=Imm(5) and EE_6;
end generate ;
end behav;