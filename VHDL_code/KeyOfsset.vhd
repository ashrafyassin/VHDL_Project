library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- sends the key offset based on the key number
entity KeyOfsset is
	port ( 
	 clk : in std_logic ;	 
	 resetN : in std_logic ;
	 mem_out : in std_logic_vector(8 downto 0);
	 Offset : out integer
	 );
end KeyOfsset;

architecture behavior of KeyOfsset is
	 
	 signal offset_t : integer;
	 signal NoteNumber : std_logic_vector(4 downto 0) ;
	 
begin
	 Offset <= offset_t;
	 NoteNumber <= mem_out(8 downto 4) ;
	 
process ( resetN , clk)
	 begin
		 if resetN = '0' then
			 offset_t <= 0;								
		 elsif rising_edge(clk) then
				 case NoteNumber is
					when "00001" => 
									offset_t <= 7; -- C4 / A								
					when "00010" => 
									offset_t <= 7; -- C4# /W
					when "00011" =>
									offset_t <= 7; -- D4 / S
					when "00100" => 
									offset_t <= 7; -- D4# /E
					when "00101" =>
									offset_t <= 15; -- E4 /D
					when "00110" =>
									offset_t <= 22;	-- F4 /F
					when "00111" =>
									offset_t <= 22; -- F4# /T
					when "01000" =>
									offset_t <= 30; -- G4 /G							
					when "01001" =>
									offset_t <= 30;	 -- G4# /Y
					when "01010" =>
									offset_t <= 37; -- A4 /H									
					when "01011" =>
									offset_t <= 37; -- A4# /U									
					when "01100" =>
									offset_t <= 2; -- B4 /J							
					when "01101" =>
									offset_t <= 8; -- C5/ K						
					when "01110" =>
									offset_t <= 8; -- C5#/O				
					when "01111" =>
									offset_t <= 15; -- D5 / L									
					when "10000" =>
									offset_t <= 15; -- D5# /P									
					when "10001" =>
									offset_t <= 21; -- E5 / ;					
					when others =>
									offset_t <= 100;									
				end case;						
		end if;
	 end process;
end architecture;