library ieee;
USE ieee.numeric_std.ALL;
use ieee.std_logic_1164.all;

entity Incrementer is 
    port(PC_in,Z,Imm:in std_logic_vector(15 downto 0);
         WE:in std_logic;    
			Din:in std_logic_vector(15 downto 0);
			PC_out:out std_logic_vector(15 downto 0));
end entity Incrementer;

architecture Struct of Incrementer is
	 signal PC:std_logic_vector(31 downto 0);

begin
PC_updation:process(PC_in,Z,WE,Imm,Din)
begin
     
      if(WE='1') then------------Special increment
         if(Z="0000000000000000") then --------PC=PC+2*IMM
		    PC<=(STD_LOGIC_VECTOR((unsigned(PC_in)) +2*(unsigned(Imm))));
			 PC_out<=PC(15 downto 0);
        	else--------PC=DATA IN RF FILE DETERMINED BY THE IR ADDRESS
			PC_out<=Din;
			end if;
		else --------------normal increment PC+=1
		PC_out<=STD_LOGIC_VECTOR((unsigned(PC_in)) +1);

	end if;

end process;
		  
end Struct;
		  
		  
		  
       