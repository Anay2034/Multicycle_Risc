library ieee;
use ieee.std_logic_1164.all;
library work;
entity Signedextender_9 is 
port (Imm:in std_logic_vector(8 downto 0);EE_9:in std_logic;SE:out std_logic_vector(15 downto 0));
end entity Signedextender_9;
architecture behav of Signedextender_9 is
begin 
Q:for i in 0 to 8 generate
SE(i)<=Imm(i) and EE_9;
end generate;
W:for i in 9 to 15 generate
SE(i)<=Imm(8) and EE_9 ;
end generate ;
end behav;