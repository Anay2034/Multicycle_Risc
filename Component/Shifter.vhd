library ieee;
use ieee.std_logic_1164.all;

entity Shifter is
    port(A:in std_logic_vector(15 downto 0);
	      L:in std_logic_vector(0 downto 0);
			B:in std_logic_vector(3 downto 0);
			Q:out std_logic_vector(15 downto 0));
end entity Shifter;

architecture Struct of Shifter is 
    signal A1:std_logic_vector(15 downto 0);
	 signal A2:std_logic_vector(15 downto 0);
	 signal A3:std_logic_vector(15 downto 0);
	 signal A4:std_logic_vector(15 downto 0);
	 signal A5:std_logic_vector(15 downto 0);
component MUX_21 is
  port(A:in std_logic_vector(1 downto 0);
       S:in std_logic_vector(0 downto 0);
		 Q:out std_logic_vector(0 downto 0));
end component MUX_21;

begin
---------------------------------------bit reversal
              mux1:MUX_21 PORT MAP(A(0)=>a(15),A(1)=>a(0),S=>L,Q(0)=>A1(15));
				   mux2:MUX_21 PORT MAP(A(0)=>a(14),A(1)=>a(1),S=>L,Q(0)=>A1(14));
					 mux3:MUX_21 PORT MAP(A(0)=>a(13),A(1)=>a(2),S=>L,Q(0)=>A1(13));
					 mux4:MUX_21 PORT MAP(A(0)=>a(12),A(1)=>a(3),S=>L,Q(0)=>A1(12));
					 mux5:MUX_21 PORT MAP(A(0)=>a(11),A(1)=>a(4),S=>L,Q(0)=>A1(11));
					 mux6:MUX_21 PORT MAP(A(0)=>a(10),A(1)=>a(5),S=>L,Q(0)=>A1(10));
					 mux7:MUX_21 PORT MAP(A(0)=>a(9),A(1)=>a(6),S=>L,Q(0)=>A1(9));
					 mux8:MUX_21 PORT MAP(A(0)=>a(8),A(1)=>a(7),S=>L,Q(0)=>A1(8));
					 mux9:MUX_21 PORT MAP(A(0)=>a(7),A(1)=>a(8),S=>L,Q(0)=>A1(7));
					 mux10:MUX_21 port map(A(0)=>a(6),A(1)=>a(9),S=>L,Q(0)=>A1(6));
					 mux11:MUX_21 port map(A(0)=>a(5),A(1)=>a(10),S=>L,Q(0)=>A1(5));
					 mux12:MUX_21 port map(A(0)=>a(4),A(1)=>a(11),S=>L,Q(0)=>A1(4));
					 mux13:MUX_21 port map(A(0)=>a(3),A(1)=>a(12),S=>L,Q(0)=>A1(3));
					 mux14:MUX_21 port map(A(0)=>a(2),A(1)=>a(13),S=>L,Q(0)=>A1(2));
					 mux15:MUX_21 port map(A(0)=>a(1),A(1)=>a(14),S=>L,Q(0)=>A1(1));
					 mux16:MUX_21 port map(A(0)=>a(0),A(1)=>a(15),S=>L,Q(0)=>A1(0));
					 				 
---------------------------------------Shift by 8
n8_bit:for i in 0 to 15 generate

lsb:      if(i<8) generate
          mux17:MUX_21 port map(A(0)=>A1(0),A(1)=>A1(8+i),S(0)=>B(3),Q(0)=>A2(i));
end generate lsb;

msb:     if(i>8) generate
         mux18:MUX_21 port map(A(0)=>A1(i),A(1)=>'0',S(0)=>B(3),Q(0)=>A2(i));
end generate msb;

end generate;
-------------------------------------Shift by 4
n4_bit:for i in 0 to 15 generate

lsb:      if(i<12) generate
          mux19:MUX_21 port map(A(0)=>A1(i),A(1)=>A(4+i),S(0)=>B(2),Q(0)=>A3(i));
end generate lsb;

msb:      if(i>11) generate
          mux20:MUX_21 port map(A(0)=>A1(i),A(1)=>'0',S(0)=>B(2),Q(0)=>A3(i));
end generate msb;
end generate;
------------------------------------Shift by 2 
n2_bit:for i in 0 to 15 generate

lsb:      if(i<14) generate
          mux21:MUX_21 port map(A(0)=>A1(i),A(1)=>A1(i+2),S(0)=>B(1),Q(0)=>A4(i));
end generate lsb;
msb:      if(i>13) generate
          mux22:MUX_21 port map(A(0)=>A1(i),A(1)=>'0',S(0)=>B(1),Q(0)=>A4(i));
end generate msb;
end generate;
------------------------------------Shift by 1
n1_bit: for i in 0 to 15 gENERATE

lsb:     if(i<15) generate
         mux23:MUX_21 port map(A(0)=>A1(i),A(1)=>A1(i+1),S(0)=>B(0),Q(0)=>A5(i));
end generate lsb;
msb:     if(i>14) generate 
         mux24:MUX_21 port map(A(0)=>A1(i),A(1)=>'0',S(0)=>B(0),Q(0)=>A5(i));
end generate msb;
end generate;
-----------------------------------Bit Reversal
rev:for i in 0 to 15 generate 
lsb:    if(i<8) generate 
        mux25:MUX_21 port map(A(0)=>A5(i),A(1)=>A5(15-i),S=>L,Q(0)=>Q(i));
end generate lsb;
msb:    if(i>7) generate 
        mux26:MUX_21 port map(A(0)=>A5(i),A(1)=>A5(15-i),S=>L,Q(0)=>Q(i));
end generate msb;
end generate;
------------------------------------------------------------

end Struct;
		 