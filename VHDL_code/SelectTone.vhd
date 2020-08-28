library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- select the shape of the note according to the given rhythm which is the key playing time

entity SelectTone is
	port ( 
	 clk : in std_logic ;	 
	 resetN : in std_logic ;
	 NoteNumber : in std_logic_vector(4 downto 0);
	 rhythm : in std_logic_vector(3 downto 0);
	 drawing_requests : in std_logic_vector(17 downto 0) ;
	 req : out std_logic
	 );
end SelectTone;

architecture behavior of SelectTone is
begin
process ( resetN , clk)
	 begin
		 if resetN = '0' then
			 req <= drawing_requests(0);									
		 elsif rising_edge(clk) then
		     if NoteNumber = 1   then
			  -- C4 and C5
				if rhythm = 2 then 
					req <=  drawing_requests(0);
				elsif rhythm = 4 then
					req <= drawing_requests(1);
				else
					req <= drawing_requests(2);
				end if;
			elsif NoteNumber =2  then    -- C4#,C5# 
					if rhythm = 2 then
						req <= drawing_requests(3);
					elsif rhythm = 4 then
						req <= drawing_requests(4);
					else
						req <= drawing_requests(5);
					end if;
			elsif NoteNumber =4  or   NoteNumber =7 or  NoteNumber =9 or NoteNumber =11 then
			--For the notes D4#,F4#,G4#,A4#,D5#
					if rhythm = 2 then
						req <= drawing_requests(9);
					elsif rhythm = 4 then
						req <= drawing_requests(10);
					else
						req <= drawing_requests(11);
					end if;
			elsif NoteNumber =3 or  NoteNumber =5 or  NoteNumber =6
			 or NoteNumber =8 or NoteNumber =10 then
	-- For the notes D4,E4,F4,G4,A4,B4,D5,E5 
					if rhythm = 2 then
						req <= drawing_requests(6);
					elsif rhythm = 4 then
						req <= drawing_requests(7);
					else
						req <= drawing_requests(8);
					end if;
			elsif NoteNumber =3 or  NoteNumber =5 or  NoteNumber =6
			 or NoteNumber =8 or NoteNumber =10 then
	-- For the notes D4,E4,F4,G4,A4,B4,D5,E5 
					if rhythm = 2 then
						req <= drawing_requests(6);
					elsif rhythm = 4 then
						req <= drawing_requests(7);
					else
						req <= drawing_requests(8);
					end if;
			elsif NoteNumber =12 or NoteNumber =13 or NoteNumber =15 or 
				NoteNumber =17 then
				if rhythm = 2 then
					req <= drawing_requests(12);
				elsif rhythm = 4 then
					req <= drawing_requests(13);
				else
					req <= drawing_requests(16);
				end if;
			elsif NoteNumber =16 or NoteNumber =14 then
				if rhythm = 2 then
					req <= drawing_requests(14);
				elsif rhythm = 4 then
					req <= drawing_requests(15);
				else
					req <= drawing_requests(17);
				end if;
			else        
					req  <= drawing_requests(0);
			end if;		
		end if;
	 end process;
end architecture;