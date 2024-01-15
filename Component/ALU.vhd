library ieee;
use ieee.std_logic_1164.all;

entity ALU is 
   port(A,B:in std_logic_vector(15 downto 0);
	     S:in std_logic_vector(3 downto 0);
		  d:in std_logic_vector(3 downto 0);
		  L:in std_logic_vector(0 downto 0);
		  M:in std_logic_vector(0 downto 0);
	     C:out std_logic_vector(15 downto 0));
end entity ALU;

architecture struct of ALU is 
   signal R1,R2,R3,R4,R5,R6,R7,R8:std_logic_vector(15 downto 0);
	
component MUX_42 is
     port(A0,A1,A2,A3:in std_logic_vector(15 downto 0);
	       S:in std_logic_vector(1 downto 0);
			 Q:out std_logic_vector(15 downto 0));
end component MUX_42;

COMPONENT FAS is 
    port(A:in std_logic_vector(15 downto 0);
	      B:in std_logic_vector(15 downto 0);
			M:in std_logic_vector(0 downto 0);
			Q:out std_logic_vector(15 downto 0));
end component FAS;

COMPONENT Shifter is
    port(A:in std_logic_vector(15 downto 0);
	      L:in std_logic_vector(0 downto 0);
			B:in std_logic_vector(3 downto 0);
			Q:out std_logic_vector(15 downto 0));
end COMPONENT Shifter;

component multi IS
	PORT (
		A,B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		
		Q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END component;

begin
R1<=A and B;
R2<=A or B;
R3<=A Xor B;
R4<=not A;

Mux1:MUX_42 port map(A0=>R1,A1=>R2,A2=>R3,A3=>R4,S(0)=>S(0),S(1)=>S(1),Q=>R6);
Shifter_1:Shifter port map (A=>A,L=>L,B=>d,Q=>R5);
FAS1:FAS port map(A=>A,B=>B,M=>M,Q=>R7);
mul_1:multi port map(A=>A,B=>B,Q=>R8);
Mux2:MUX_42 port map(A0=>R5,A1=>R6,A2=>R7,A3=>R8,S(0)=>S(2),S(1)=>S(3),Q=>C);

end Struct;

 



