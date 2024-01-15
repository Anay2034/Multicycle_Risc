library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
    port(
	   WE,RE,clk: in std_logic;
		address,Din: in std_logic_vector(15 downto 0);
		Dout: out std_logic_vector(15 downto 0)
		);
end memory;

architecture mem_arch of memory is
	type mem_index is array(31 downto 0) of std_logic_vector(15 downto 0);
	signal mem: mem_index := (
	0 => "0000001010011000",--00_00
	1 => "0001010011100100",--00_00,010 ,010 
	2 => "0010001010011000",--00_10
	3 => "0011001010011000",--00_11
	4 => "0100001010011000",--0100
	5 => "0101001010011000",--0101
	6 => "0110001010011000",--0110
	7 => "1000011010100100",--1100
	8 => "1001011010100100",--1101
   9 => "1010010011100100",--1010
  10 => "1011010011100100",--1011
  11 => "1100010011100100",--1100
  12 => "1101011100100100",--1101
  13 => "1111010011000000",--1111

	OTHERS => x"0000");
begin

  
writing : process(WE, clk, address, Din)
begin
  if rising_edge(clk) then
    if WE='1' then
	   mem(to_integer(unsigned(address)))<=Din;
	 else
	   null;
	 end if;
  --else
  --  null;
  end if;
end process;

reading:process(RE,clk,mem,address)
begin
  if rising_edge(clk) then
    if RE='1' then 
	Dout<=mem(to_integer(unsigned(address)));
 else
	   null;
	 end if;
 -- else
   -- null;
 end if;
end process;
	
end mem_arch;