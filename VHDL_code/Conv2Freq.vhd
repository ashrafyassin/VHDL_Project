library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

 --- converting the key serial number to its div parameter---
 --- using the formula div=clk/(freq*256).
entity Conv2Freq is
	port ( 
	 clk : in std_logic ;	 
	 resetN : in std_logic ;
	 NotesVec  : in std_logic_vector(16 downto 0);
	 div1	: 	out std_logic_vector (11 downto 0);
	 div2	: 	out std_logic_vector (11 downto 0);
	 div3	: 	out std_logic_vector (11 downto 0)
	 );
end Conv2Freq;

architecture behavior of Conv2Freq is
	
	signal div1_tmp	: std_logic_vector (11 downto 0);
	signal div2_tmp	: std_logic_vector (11 downto 0);
	signal div3_tmp	: std_logic_vector (11 downto 0);
begin
	 div1 <= div1_tmp;
	 div2 <= div2_tmp;
	 div3 <= div3_tmp;
process ( resetN , clk,NotesVec)
	 	variable counter : integer := 0;
	 begin
		 if resetN = '0' then
			counter := 0;
			div1_tmp <= (others=>'0');
			div2_tmp <= (others=>'0');
			div3_tmp <= (others=>'0');
		 elsif rising_edge(clk) then
			div1_tmp <= (others=>'0');
			div2_tmp <= (others=>'0');
			div3_tmp <= (others=>'0'); 
			counter := 0;
			if notesVec(0) = '1' then
				if counter = 0 then
					div1_tmp <= conv_std_logic_vector(748,12); -- C4 / A
				elsif counter = 1 then
					div2_tmp <= conv_std_logic_vector(748,12);
				elsif counter = 2 then
					div3_tmp <= conv_std_logic_vector(748,12);
				end if;
				counter := counter + 1;
			end if;	
			
			if notesVec(1) = '1' then
				if counter = 0 then
					div1_tmp <= conv_std_logic_vector(705,12); -- C4# /W
				elsif counter = 1 then
					div2_tmp <= conv_std_logic_vector(705,12);
				elsif counter = 2 then
					div3_tmp <= conv_std_logic_vector(277,12);
				end if;
				counter := counter + 1;
			end if;
			
			if notesVec(2) = '1' then
				if counter = 0 then
					div1_tmp <= conv_std_logic_vector(664,12); -- D4 / S
				elsif counter = 1 then
					div2_tmp <= conv_std_logic_vector(664,12);
				elsif counter = 2 then
					div3_tmp <= conv_std_logic_vector(664,12);
				end if;
				counter := counter + 1;
			end if;
			
			if notesVec(3) = '1' then
				if counter = 0 then
					div1_tmp <= conv_std_logic_vector(628,12); -- D4# /E
				elsif counter = 1 then
					div2_tmp <= conv_std_logic_vector(628,12);
				elsif counter = 2 then
					div3_tmp <= conv_std_logic_vector(628,12);
				end if;
				counter := counter + 1;
			end if;
				
			if notesVec(4) = '1' then
				if counter = 0 then
					div1_tmp <= conv_std_logic_vector(592,12); -- E4 /D
				elsif counter = 1 then
					div2_tmp <= conv_std_logic_vector(592,12);
				elsif counter = 2 then
					div3_tmp <= conv_std_logic_vector(592,12);
				end if;
				counter := counter + 1;
			end if;
			if notesVec(5) = '1' then
				if counter = 0 then
					div1_tmp <= conv_std_logic_vector(560,12); -- F4 /F
				elsif counter = 1 then
					div2_tmp <= conv_std_logic_vector(560,12); -- F4 /F
				elsif counter = 2 then
					div3_tmp <= conv_std_logic_vector(560,12); -- F4 /F
				end if;
				counter := counter + 1;
			end if;
				
			if notesVec(6) = '1' then
				if counter = 0 then
					div1_tmp <= conv_std_logic_vector(528,12); -- F4# /T
				elsif counter = 1 then
					div2_tmp <= conv_std_logic_vector(528,12); -- F4# /T
				elsif counter = 2 then
					div3_tmp <= conv_std_logic_vector(528,12); -- F4# /T
				end if;
				counter := counter + 1;
			end if;
			
			if notesVec(7) = '1' then
				if counter = 0 then
					div1_tmp <= conv_std_logic_vector(498,12); -- G4 /G
				elsif counter = 1 then
					div2_tmp <= conv_std_logic_vector(498,12); -- G4 /G
				elsif counter = 2 then
					div3_tmp <= conv_std_logic_vector(498,12); -- G4 /G
				end if;
				counter := counter + 1;
			end if;	
			
			if notesVec(8) = '1' then
				if counter = 0 then
					div1_tmp <= conv_std_logic_vector(471,12); -- G4# /Y
				elsif counter = 1 then
					div2_tmp <= conv_std_logic_vector(471,12); -- G4# /Y
				elsif counter = 2 then
					div3_tmp <= conv_std_logic_vector(471,12); -- G4# /Y
				end if;
				counter := counter + 1;
			end if;
				
			if notesVec(9) = '1' then
				if counter = 0 then
					div1_tmp <= conv_std_logic_vector(444,12); -- A4 /H
				elsif counter = 1 then
					div2_tmp <= conv_std_logic_vector(444,12); -- A4 /H
				elsif counter = 2 then
					div3_tmp <= conv_std_logic_vector(444,12); -- A4 /H
				end if;
				counter := counter + 1;
			end if;
				
			if notesVec(10) = '1' then
				if counter = 0 then
					div1_tmp <= conv_std_logic_vector(419,12); -- A4# /U
				elsif counter = 1 then
					div2_tmp <= conv_std_logic_vector(419,12); -- A4# /U
				elsif counter = 2 then
					div3_tmp <= conv_std_logic_vector(419,12); -- A4# /U
				end if;
				counter := counter + 1;
			end if;
				
			if notesVec(11) = '1' then
				if counter = 0 then
					div1_tmp <= conv_std_logic_vector(395,12); -- B4 /J
				elsif counter = 1 then
					div2_tmp <= conv_std_logic_vector(395,12); -- B4 /J
				elsif counter = 2 then
					div3_tmp <= conv_std_logic_vector(395,12); -- B4 /J
				end if;
				counter := counter + 1;
			end if;
			
			if notesVec(12) = '1' then
				if counter = 0 then
					div1_tmp <= conv_std_logic_vector(373,12); -- C5/ K
				elsif counter = 1 then
					div2_tmp <= conv_std_logic_vector(373,12); -- C5/ K
				elsif counter = 2 then
					div3_tmp <= conv_std_logic_vector(373,12); -- C5/ K
				end if;
				counter := counter + 1;
			end if;
				
			if notesVec(13) = '1' then
				if counter = 0 then
					div1_tmp <= conv_std_logic_vector(353,12); -- C5#/O
				elsif counter = 1 then
					div2_tmp <= conv_std_logic_vector(353,12); -- C5#/O
				elsif counter = 2 then
					div3_tmp <= conv_std_logic_vector(353,12); -- C5#/O
				end if;
				counter := counter + 1;
			end if;
				
			if notesVec(14) = '1' then
				if counter = 0 then
					div1_tmp <= conv_std_logic_vector(333,12); -- D5 / L
				elsif counter = 1 then
					div2_tmp <= conv_std_logic_vector(333,12); -- D5 / L
				elsif counter = 2 then
					div3_tmp <= conv_std_logic_vector(333,12); -- D5 / L
				end if;
				counter := counter + 1;
			end if;
				
			if notesVec(15) = '1' then
				if counter = 0 then
					div1_tmp <= conv_std_logic_vector(314,12); -- D5# /P
				elsif counter = 1 then
					div2_tmp <= conv_std_logic_vector(314,12); -- D5# /P
				elsif counter = 2 then
					div3_tmp <= conv_std_logic_vector(314,12); -- D5# /P
				end if;
				counter := counter + 1;
			end if;
				
			if notesVec(16) = '1' then
				if counter = 0 then
					div1_tmp <= conv_std_logic_vector(296,12); -- E5 / ;
				elsif counter = 1 then
					div2_tmp <= conv_std_logic_vector(296,12); -- E5 / ;
				elsif counter = 2 then
					div3_tmp <= conv_std_logic_vector(296,12); -- E5 / ;
				end if;
				counter := counter + 1;
			end if;	
		end if;		
	 end process;
end architecture;