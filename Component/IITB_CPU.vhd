library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;

entity IITB_CPU is
    port(Clk : in std_logic;
	 output_dummy: out std_logic;
	 R0:out std_logic

	 );
end IITB_CPU;

architecture main of IITB_CPU is

component DATAPATH IS
	PORT (
		R1,R2,WR_EN,Clk : IN STD_LOGIC;
		Sa3,Sd3 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		ALU_m1,ALU_m2 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		L,M : IN STD_LOGIC_vector(0 downto 0);
		S,d: In std_logic_vector(3 downto 0); 
		Sm:in std_logic_vector(0 downto 0);
		WE_i:in std_logic;
		M_SEL:in std_logic_vector(0 downto 0);
		M_PC:in std_logic_vector(1 downto 0);
		WE,RE:in std_logic;
		IR:out std_logic_vector(15 downto 0);
				M_S:in std_logic_vector(0 downto 0));
		
end component DATAPATH;

component controller is
 port(IR: in std_logic_vector(15 downto 0);
     Clk:in std_logic;
		R1,R2,WR_EN : out STD_LOGIC;
		Sa3,Sd3 : out STD_LOGIC_VECTOR(1 DOWNTO 0);
		ALU_m1,ALU_m2 : out STD_LOGIC_VECTOR(1 DOWNTO 0);
		L,M : out STD_LOGIC_vector(0 downto 0);
		S,d: out std_logic_vector(3 downto 0); 
		Sm:out std_logic_vector(0 downto 0);
		WE_i:out std_logic;
		M_SEL:out std_logic_vector(0 downto 0);
		M_PC:out std_logic_vector(1 downto 0);
		WE,RE:out std_logic;
		M_S:out std_logic_vector(0 downto 0));
		 
		 
		 
end component controller;


	
	
	signal IR:std_logic_vector(15 downto 0);
	signal	R1,R2,WR_EN :  STD_LOGIC;
	signal	Sa3,Sd3 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal	ALU_m1,ALU_m2 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal	L,M :  STD_LOGIC_vector(0 downto 0);
	signal	S,d:  std_logic_vector(3 downto 0); 
	signal	Sm: std_logic_vector(0 downto 0);
	signal	WE_i: std_logic;
	signal	M_SEL,M_S: std_logic_vector(0 downto 0);
	signal	M_PC: std_logic_vector(1 downto 0);
	signal	WE,RE:std_logic;
begin

--Controller



def:controller port map(IR,Clk,
		R1,R2,WR_EN,
		Sa3,Sd3,
		ALU_m1,ALU_m2,
		L,M,
		S,d, 
		Sm,
		WE_i,
		M_SEL,
		M_PC,
		WE,RE,M_S);


--Datapath
DP: Datapath port map (R1,R2,WR_EN,Clk,
		Sa3,Sd3,
		ALU_m1,ALU_m2,
		L,M,
		S,d, 
		Sm,
		WE_i,
		M_SEL,
		M_PC,
		WE,RE,IR,M_S
							);
	R0<=R1;
							
							output_dummy<='1';
							
end main;