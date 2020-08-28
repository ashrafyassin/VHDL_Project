library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--- choose to play the music live or from the DPRAM ---

entity chooseOut is
port 	(

		Recorded : in std_logic_vector(16 downto 0);
		live  : in std_logic_vector(16 downto 0);
		rd : in std_logic;
		music : out std_logic_vector(16 downto 0)	
	);
end chooseOut;

architecture behav of chooseOut is 
	
begin 
	
	process ( Recorded,live,rd)
	begin
		if rd = '0' then
			music <= live;
		else
			music <= Recorded;
		end if;		
	end process;
end behav;		
		