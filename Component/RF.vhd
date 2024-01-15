LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY RF IS
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
END RF;

ARCHITECTURE Behav OF RF IS
	TYPE regs IS ARRAY(0 TO 6) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL reg_file_q : regs;
BEGIN
	PROCESS (wr_en, rf_a1, rf_a2, rf_a3, rf_d3, R1, R2, clk)
	BEGIN

		IF rising_edge(clk) AND wr_en = '1' THEN
			reg_file_q(to_integer(unsigned(rf_a3))) <= rf_d3;
		END IF;
		IF rising_edge(clk) AND R1 = '1' THEN
		rf_d1 <= reg_file_q(to_integer(unsigned(rf_a1)));
		end if;
		IF rising_edge(clk) AND R2 = '1' THEN
		rf_d2 <= reg_file_q(to_integer(unsigned(rf_a2)));
		end if;

	END PROCESS;

END ARCHITECTURE;
			 
		  
		   
 
