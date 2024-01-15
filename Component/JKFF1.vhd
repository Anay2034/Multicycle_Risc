library ieee;
use ieee.std_logic_1164.all;

entity JKFF1 is
port (J,K,En,preset,reset,clk: in std_logic;
      Q,Qn: out std_logic);
end entity JKFF1;

architecture behav of JKFF1 is
signal a: std_logic;
begin 
flip:process(J,K,En,preset,reset,clk,a)
begin 
if(preset='1' and reset='0') then
  a<='1';
elsif(preset ='0' and reset='1') then
  a<='0';
elsif(preset='0' and reset='0') then
  if(clk'event and clk='1') then
  if(En='1') then
  if(J='0' and K='0') then
  a<=a;
  elsif(J='1' and K='0') then
  a<='1';
    elsif(J='0' and K='1') then
  a<='0';
    elsif(J='1' and K='1') then
  a<= not a;
  end if;
  end if;
  else
  a<=a;
  end if;
  elsif(preset='1' and reset='1') then
  null;
  end if;
 end process flip;
 
 Q<=a;
 Qn<= not a;
 end architecture behav;