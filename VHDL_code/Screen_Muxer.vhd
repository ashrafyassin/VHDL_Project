library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- pick the present screen depending on the game status.

entity Screen_Muxer is
port 	(
	   	CLK  		: in std_logic;
		RESETn		: in std_logic;
		screen_status : in std_logic_vector(1 downto 0);
		pick_screen    : in  std_logic_vector(7 downto 0);
		pick_screent_request	: in  std_logic;
		instrument_screen   : in  std_logic_vector(7 downto 0);
		instrument_screen_request	: in  std_logic;
		record_play_screen    : in  std_logic_vector(7 downto 0);
		record_play_screen_request	: in  std_logic;	
		out_screen    : out std_logic_vector(7 downto 0);
		out_screen_request	: out std_logic	
	);
end Screen_Muxer;

architecture behav of Screen_Muxer is 
begin
process(RESETn, CLK) 
begin 
	if RESETn = '0' then
		out_screen <= ( others => '0') ;
		out_screen_request <= '0' ;
	elsif rising_edge(CLK) then
		case screen_status is 
			when "00" =>
						out_screen <= pick_screen;
						out_screen_request <= pick_screent_request;
			when "01" =>
						out_screen <= instrument_screen;
						out_screen_request <= instrument_screen_request;
			when "10" =>
						out_screen <= record_play_screen;
						out_screen_request <= record_play_screen_request;
			when others =>
						out_screen <= ( others => '0') ;
						out_screen_request <= '0' ;
			end case ;
		end if;
	end process ;
end behav ;