library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Register16bit is
port(Clk        : in  std_logic;
	  Reset      : in  std_logic;
     data_in    : in  std_logic_vector(15 downto 0);
     data_out   : out std_logic_vector(15 downto 0));
end entity Register16bit;

architecture struct of Register16bit is
component D_FlipFlop is
	port (D : in std_logic;
			Clock : in std_logic;
			Enable : in std_logic;
			Reset, Preset : in std_logic;
			Q, NotQ : out std_logic);
end component D_FlipFlop;
signal notdata_out,S : std_logic_vector(15 downto 0);
signal Enable: std_logic := '1';
signal Preset: std_logic:='0';
signal i       : integer;
begin
regb16 :for i in 0 to 15 generate
notdata_out(i)<= not S(i);
DFF_Inst : D_FlipFlop port map (D => data_in(i), Clock => Clk,
													  Enable => Enable, Reset => Reset,
													  Preset => Preset,
													  Q => S(i), NotQ => notdata_out(i));
data_out(i)<=S(i);
end generate;
end struct;