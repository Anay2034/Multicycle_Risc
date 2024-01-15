library ieee;
use ieee.std_logic_1164.all;

entity FAS is 
    port(A:in std_logic_vector(15 downto 0);
	      B:in std_logic_vector(15 downto 0);
			M:in std_logic_vector(0 downto 0);
			Q:out std_logic_vector(15 downto 0));
end entity FAS;

architecture Struct of FAS is 
			signal B1:std_logic_vector(15 downto 0);
			signal B2:std_logic_vector(15 downto 0);
			
component FA is 
   port(A:in std_logic_vector(0 downto 0);
	     B:in std_logic_vector(0 downto 0);
		  Cin:in std_logic_vector(0 downto 0);
		  S:out std_logic_vector(0 downto 0);
		  Cout:out std_logic_vector(0 downto 0));
end component FA;
  
 begin 
 EXOR:for i in 0 to 15 generate 
       B1(i)<=B(i) xor M(0);
end generate;
AS:   for i in 0 to 15 generate 
lsb:     if(i<1) generate 
         FA1:FA port map(A(0)=>A(i),B(0)=>B1(i),Cin=>M,S(0)=>Q(i),Cout(0)=>B2(i));
end generate lsb;
msb:     if(i>0) generate 
         FA2:FA port map(A(0)=>A(i),B(0)=>B1(i),Cin(0)=>B2(i-1),S(0)=>Q(i),Cout(0)=>B2(i));
end generate msb;
end generate;
------------------------------------------------------------------
end Struct;
			
 