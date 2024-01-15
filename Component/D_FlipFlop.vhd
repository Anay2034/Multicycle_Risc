library ieee;
use ieee.std_logic_1164.all;

entity D_FlipFlop is
	port (D : in std_logic;
			Clock : in std_logic;
			Enable : in std_logic;
			Reset, Preset : in std_logic;
			Q, NotQ : out std_logic);
end entity D_FlipFlop;

architecture Struct of D_FlipFlop is

component JKFF1 is
	port (J, K : in std_logic;
			clk : in std_logic;
			En : in std_logic;
			preset, reset : in std_logic;
			Q, Qn : out std_logic);
end component JKFF1;

signal Output, NotOutput, NotD : std_logic;

begin
NotD <= not D;
JKFF_Instance : JKFF1 port map (J => D, K => NotD, 
												  clk => Clock,
												  En => Enable,
												  preset => Preset, 
												  reset => Reset,
												  Q => Output,
												  Qn => NotOutput);
												 
Q <= Output;
NotQ <= NotOutput;
end Struct;