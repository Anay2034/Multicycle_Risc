LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity DATAPATH IS
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
		M_S:in std_logic_vector(0 downto 0)
	);
END entity DATAPATH;

architecture struct of DATAPATH is


component Signedextender_9 is 
     port (Imm:in std_logic_vector(8 downto 0);
	        EE_9:in std_logic;
			  SE:out std_logic_vector(15 downto 0));
end component Signedextender_9;

component Signedextender_6 is 
  port (Imm:in std_logic_vector(5 downto 0);
       EE_6:in std_logic;
		 SE:out std_logic_vector(15 downto 0));
end component Signedextender_6;

component ALU is 
   port(A,B:in std_logic_vector(15 downto 0);
	     S:in std_logic_vector(3 downto 0);
		  d:in std_logic_vector(3 downto 0);
		  L:in std_logic_vector(0 downto 0);
		  M:in std_logic_vector(0 downto 0);
	     C:out std_logic_vector(15 downto 0));
end component ALU;

component memory is
    port(
	   WE,RE,clk: in std_logic;
		address,Din: in std_logic_vector(15 downto 0);
		Dout: out std_logic_vector(15 downto 0)
		);
end component memory;

component Incrementer is 
    port(PC_in,Z,Imm:in std_logic_vector(15 downto 0);	
	      --IE:in std_logic;
         WE:in std_logic;    
			Din:in std_logic_vector(15 downto 0);
			PC_out:out std_logic_vector(15 downto 0));
end component Incrementer;


component RF IS
	PORT (
		CLK : IN STD_LOGIC;
		WR_EN,R1,R2 : IN STD_LOGIC;
		RF_A1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		RF_A2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		RF_A3 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		RF_D3 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		RF_D1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		RF_D2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)

	);
END component RF;

component Register16bit is
port(Clk        : in  std_logic;
	  Reset      : in  std_logic;
     data_in    : in  std_logic_vector(15 downto 0);
     data_out   : out std_logic_vector(15 downto 0));
end component Register16bit;


component MUX_42 is
     port(A0,A1,A2,A3:in std_logic_vector(15 downto 0);
	       S:in std_logic_vector(1 downto 0);
			 Q:out std_logic_vector(15 downto 0));
end component MUX_42;


component MUX2116 is
  port(A0,A1:in std_logic_vector(15 downto 0);
       S:in std_logic_vector(0 downto 0);
		 Q:out std_logic_vector(15 downto 0));
end component;

component MUX213 is
  port(A0,A1:in std_logic_vector(3 downto 0);
       S:in std_logic_vector(0 downto 0);
		 Q:out std_logic_vector(3 downto 0));
end component;

component MUX423 is
     port(A0,A1,A2,A3:in std_logic_vector(2 downto 0);
	       S:in std_logic_vector(1 downto 0);
			 Q:out std_logic_vector(2 downto 0));
end component ;
component DMUX2116 is
  port(A0,A1:out std_logic_vector(15 downto 0);
       S:in std_logic_vector(0 downto 0);
		 Q:in std_logic_vector(15 downto 0));
end component;


--signal :std_logic;
signal RF_A1,RF_A2,RF_A3:std_logic_vector(2 downto 0);
signal RF_D3,RF_D1,RF_D2,IR1,PC,ALU_C,MEM,MEM0,Inr,SE,SE6,SE9,A,B,addr:std_logic_vector(15 downto 0);
signal K6,K9,PC_IN:std_logic_vector(15 downto 0):="0000000000000000";


begin

--mux_A1: MUX213 port map (IR(11 downto 9),PC,Sa1,RF_A1);
mux_A1: MUX423 port map (IR1(5 downto 3),IR1(8 downto 6),IR1(11 downto 9),"000",Sa3,RF_A3);

mux_D3: MUX_42 port map (ALU_C,MEM,PC,"0000000000000000",Sd3,RF_D3);

Reg: RF port map(CLK,
		WR_EN,R1,R2,
		IR1(11 downto 9),--RF_A1 
		IR1(8 downto 6),---RF_A2
		RF_A3, 
		RF_D3,
		RF_D1, 
		RF_D2 );
		
MUX_a: MUX_42 port map(RF_D1,SE6,SE9,"0000000000000000",ALU_m1,A);	
MUX_b: MUX_42 port map(RF_D2,SE6,"0000000000000000","0000000000000000",ALU_m2,B);	
		
ALU_1:ALU port map(A,B,
                   S,d,
						 L,M,
						 ALU_C);
						 
SE_9:Signedextender_9 port map(IR1(8 downto 0),'1',SE9);
SE_6:Signedextender_6 port map(IR1(5 downto 0),'1',SE6);

MUX_mem: MUX2116 port map(PC,ALU_C,Sm,addr);

mem1:memory port map(WE,RE,Clk,
                    addr,RF_D1,
						  MEM0);
						  
dm:DMUX2116 port map(IR1,MEM,M_S,MEM0);				  
K6(5 downto 0)<=IR1(5 downto 0);
K9(8 downto 0)<=IR1(8 downto 0);						  
				  
Mux_sel:MUX2116 port map(K6,K9,M_SEL,SE);
						  
inci: incrementer port map(PC,ALU_C,SE,WE_i,RF_D2,Inr);--Z to replaced by ALU_C

MUC_PC: MUX_42 port map(Inr,RF_D2,ALU_C,"0000000000000000",M_PC,PC_IN);		------check RF_D2			  
						  
pc1:Register16bit port map(Clk,'0',PC_IN,PC);


IR<=IR1;

end struct;


