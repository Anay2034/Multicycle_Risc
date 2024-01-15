library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--library work;

entity controller is
 port(IR: in std_logic_vector(15 downto 0);--IR
      Clk:in std_logic;--CLK
		R1,R2,WR_EN : out STD_LOGIC;---Register File signals
		Sa3,Sd3 : out STD_LOGIC_VECTOR(1 DOWNTO 0);----Reg file mux for address3 and data3
		ALU_m1,ALU_m2 : out STD_LOGIC_VECTOR(1 DOWNTO 0);----ALUA AND ALUB inputs
		L,M : out STD_LOGIC_vector(0 downto 0);----ALU
		S,d: out std_logic_vector(3 downto 0); ---ALU
		Sm:out std_logic_vector(0 downto 0);----Mem Block Adrress pin ka mux ka signal
		WE_i:out std_logic;----INcrementer special
		M_SEL:out std_logic_vector(0 downto 0);----SE6 OR SE9 selector into SE
		M_PC:out std_logic_vector(1 downto 0);-----PC Block ka input mux ka control signal
		WE,RE:out std_logic;------Mem Block 
		M_S:out std_logic_vector(0 downto 0));
		 
		 
		 
end entity controller;

architecture control of controller is

           type state is (S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14);

			  signal present_s,next_s : state:=S1 ;
			  signal op_code:std_logic_vector(3 downto 0);

			  		  
	begin
			
			op_code(3 downto 0)<= IR(15 downto 12);
			clk_process:process(clk, next_s)
			
				 begin
					 if(clk'event and clk='1') then 
							
								present_s <= next_s;
					end if;
									 
			end process;
		
	statedefinition:process(op_code,present_s)

   begin
                 S<="0000";
                 d<="0000";
                 M<="0";
                 L<="0";
					  R1<='0';R2<='0';WR_EN<='0';
		          Sa3<="11";Sd3 <= "11";
	           	ALU_m1<="00";ALU_m2 <= "11"; 
	         	Sm<="0";
	          	WE_i<='0';
	         	M_SEL<="0";
	         	M_PC<="11";
	         	WE<='0';
	         	RE<='1' ;
					M_S<="0";
		

		
		case present_s is
		      
				when S1=>
                         WE_i<='0';
					
				when S2=>
					          R1<='1';
					          R2<='1';

					
				when S3=>
						     
							     
								   if (op_code= "0000") then 	--------------ALU_ADD	0						    
						                     S<="0100";
								               M<="0";
								               L<="0";
								               d<="0000";
													ALU_m1<="00";
													ALU_m2<="00";
									elsif (op_code ="0010") then ----------------ALU_SUB  2
									            S<="0100";
													M<="1";
													L<="0";
													d<="0000";
													ALU_m1<="00";
													ALU_m2<="00";
									elsif (op_code ="0011") then --------ALU_MUL   3
									            S<="1100";
													M<="0";
													L<="0";
													d<="0000";
													ALU_m1<="00";
													ALU_m2<="00";
									elsif (op_code ="0001" ) then -------ALU_ADI   1
									            --EE_6<='1';
													S<="0100";
								               M<="0";
								               L<="0";
								               d<="0000";
													ALU_m1<="00";
													ALU_m2<="01";
									elsif (op_code ="0100") then ------ALU_AND  4
                                       S<="1000";
													ALU_m1<="00";
													ALU_m2<="00";
									elsif (op_code ="0101") then -------ALU_OR 5
									            S<="1001";
													ALU_m1<="00";
													ALU_m2<="00";
									elsif (op_code ="0110") then ------ALU_IMP (Not B as output and Or opn) 6
									            S<="1010";
													ALU_m1<="00";
													ALU_m2<="00";
				               elsif (op_code ="1010") then  --------ALU_LW 10
									            S<="0100";
													--EE_6<='1';
													M<="0";
													L<="0";
													d<="0000";
													ALU_m1<="01";
													ALU_m2<="00";
									elsif (op_code ="1011") then------------ALU_SW  11
									            S<="0100";
													--EE_6<='1';
													M<="0";
													L<="0";
													d<="0000";
													ALU_m1<="01";
													ALU_m2<="00";
								   elsif (op_code ="1100") then-------ALU_BEQ 12
									            S<="0100";
								             	M<="0";
													ALU_m1<="00";
													ALU_m2<="00";
													

						end if;
				   
				when S4=>
								        if (op_code= "1111") then-------JLR
										        R1<='0';
												  R2<='0';
												  Sd3<="10";
												  WR_EN<='1';
										 elsif (op_code = "1101") then	
									           R1<='0';
												  R2<='0';
												  Sd3<="01";
												  WR_EN<='1';	 
												  
										  else
										        R1<='0';
												  R2<='0';
						                    WR_EN<='1';
												  Sd3<="00"; 
								end if;
					
				when S5 =>
								 L<="0";
								 M<="0";
								 S<="0000";
								 d<="1000";
				  				ALU_m1<="10";
								ALU_m2<="11";
				when S6 =>
								 L<="0";
								 M<="0";
								 S<="0100";
								 d<="1000";
				  				ALU_m1<="10";
								ALU_m2<="11";
					 
				when S7=>
						       R1<='0';
						       R2<='1';
								 WR_EN<='0';
				when S8=>
								 L<="0";
								 d<="0001";
								 M<="0";
								 S<="0000";
								 ALU_m1<="10";
								ALU_m2<="11";
				when S9=>
								 WE_i<='1';-----SP/NON_SPL diff
				when S10=>
						       RE<='1';
								 WE<='0';
								 Sm<="1";
								 M_S<="1";
				when S11=>
						       R1<='1';
								 R2<='0';
								 WR_EN<='0';
				when S12=>
								 L<="1";
								 d<="0001";
								 M<="0";
								 S<="0000";
							  ALU_m1<="01";
								ALU_m2<="11";
				when S13=>
						       WE<='1';
								 Sm<="1";
								 
				when S14=>
								 WE<='1';
				when others=>
                NULL;
					 
					end case; 
				
					
					
				end process;   
					
					
				   
					
				  
				  
     	
	next_state : process(present_s, op_code,Clk)
		 
	begin
				 


     -- if(rising_edge(Clk)) then	
			--next_s <= present_s;
		case present_s is
			
			when S1 =>
				IF ((op_code) = "0000" or (op_code)="0010" or (op_code)="0011" or (op_code)="0100" or (op_code)="0101" or (op_code)="0110" or(op_code)="1100"or (op_code)="1011") THEN
					next_s <= S2;---2
				elsif ((op_code)="0001") then--or (op_code)="1011" 
					next_s <= S11;---11
				elsif ((op_code)="1000") then 
				   next_s<= S5;--5
				elsif((op_code)="1001") then 
				   next_s<= S6;--6
				elsif((op_code)="1010") then 
				   next_s<=S7;--7
				elsif((op_code)="1101") then 
					next_s<=S8;--8
				elsif((op_code)="1111") then 
				   next_s<=S4;--4
				END IF;
			when S2=>
			      next_s<=S3;	--3
			when S3 =>
			      if((op_code)="0000") then 
						next_s <= S4;--4
					elsif((op_code)="1010") then 
					   next_s<= S10;--10
					elsif((op_code)="1100") then 
					   next_s<= S12;--12
					elsif((op_code)="1011") then 
					   next_s<= S13;	---13	
			   end if;				
			when S4 =>
		            if((op_code)="1111") then 
						  next_s<=S14;--14
						 else next_s<= S1;
						end if;
			when S5 =>
			         if((op_code)="1000") then
						 next_s <= S4;--4
					end if;
			when S6 =>
			         if((op_code)="1001") then 
						  next_s<= S4;--4
						 end if;
			when S7 =>
			         if((op_code)="1010") then 
						  next_s<=S3;--3
						end if;
			when S8 =>
			         if((op_code)="1101") then 
						  next_s<=S9;--9
						 end if;
				
				
			when S9 =>
			         if((op_code)="1101") then 
						  next_s<=S4;--4
						 END IF;
			when S10 => --JLR
			         IF((op_code)="1010") then 
						   next_s<=S4;--4
					end if;
				
				
			when S11 =>
			         if((op_code="0001")) then 
						   next_s<=S3;--3
					end if;

			when S12 => 
				         if((op_code="1100")) then 
						   next_s<=S9;--9
		        end if;

			
		
			when others =>
				next_s <= S1;
			end case;
	end process;
	end architecture control ;
