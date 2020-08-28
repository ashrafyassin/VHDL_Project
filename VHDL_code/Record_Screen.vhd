library IEEE;
use IEEE.STD_LOGIC_1164.all;

--- drawing the record/play screen

entity Record_Screen is
port 	(
	   	CLK  		: in std_logic;
		RESETn		: in std_logic;
		oCoord_X	: in integer;
		oCoord_Y	: in integer;
		Recording_state : in std_logic;
		playing_state  	: in std_logic ;
		playOriginal	: in std_logic;
		game_enable		: in std_logic;
		colors			: in std_logic_vector(1 downto 0);
		Notes_screen_request : in std_logic;
		mVGA_RGB    : out std_logic_vector(7 downto 0);
		record_play_request	: out std_logic
	);
end Record_Screen;

architecture behav of Record_Screen is 

--record size
constant record_X_size : integer :=99;
constant record_Y_size : integer :=23;

--object start
signal X_begin : integer := 20;
signal Y_begin : integer := 400 ;

signal bCoord_X : integer := 0;
signal bCoord_Y : integer := 0;

signal drawing_X : std_logic := '0';
signal drawing_Y : std_logic := '0';


type record_object is array (0 to record_Y_size - 1 , 0 to record_X_size - 1) of std_logic;
 constant recording: record_object := (
("000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000111000"),
("000000000000000000000000000000000000000000000000000000000000000000000000111111111000000000001111100"),
("000000000000000000000000000000000000000000000000000000000011111111110000111111111110000000011111100"),
("000000111110000000000000000000000000111100000011111110000011111111111000111111111111000000110110110"),
("111111111111100000011111111000000111111100001111111111000011111111111100111000001111100000000110000"),
("111111111111110001111111111000001111111100011111111111100111000000011100111000000011100000000110000"),
("111111111111110001111111111000011110000000011100000011110111000000011100111000000011100000000110000"),
("111100000001110011110000000000111000000000111000000001110111000000011100111000000011100000000110000"),
("111000000001111011100000000001110000000000111000000001110111000000011100111000000011100000000110000"),
("111000000001110011100000000001110000000001110000000001110111000000111100111000000011100000000110000"),
("111000000001110011111111100001110000000001110000000001110111111111111000111000000111100000000110000"),
("111000000011110011111111100001110000000001110000000001110111111111110000111000001111000000000110000"),
("111111111111110011111111100001110000000001111000000011110111111111000000111000011110000000000110000"),
("111111111111100011100000000001110000000000111100000111100111011111000000111111111110000000000110000"),
("111111111111000011100000000001111000000000111111111111000111001111100000111111111000000000000100000"),
("111111111000000011100000000000111111111000011111111110000111000111110000111111100000000000000000000"),
("111011111000000011111111111000111111111000001111111100000111000011111000000000000000000000000000000"),
("111001111100000011111111111000001111111000000001100000000000000001111100000000000000000000000000000"),
("111000111110000011111111111000000000000000000000000000000000000000111000000000000000000000000000000"),
("111000011111000000000000000000000000000000000000000000000000000000010000000000000000000000000000000"),
("000000001111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000"),
("000000000111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000"),
("000000000011100000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
 );
 


 ----- play image size
constant play_X_size : integer :=81;
constant play_Y_size : integer :=24;

--object start
signal X2_begin : integer := 20;
signal Y2_begin : integer := 430;
 
signal bCoord_X2 : integer := 0;
signal bCoord_Y2 : integer := 0;

signal drawing_X2 : std_logic := '0';
signal drawing_Y2 : std_logic := '0';


type play_object is array (0 to play_Y_size - 1 , 0 to play_X_size - 1) of std_logic;
 constant playing : play_object := (
("000000000000000000000000000000000000000000000000000000000000000100000000011000000"),
("000000000000000000000000000000000000000000000000000000000000001110000000011000000"),
("000000000000000000000000000000000000001111100000111000000000011111000000011000000"),
("000000000000000000000000000000000000001111100001111100000000111110000000011000000"),
("000000000000000000011110000000000000011111100001111100000000111100000000011000000"),
("011111111111110000011110000000000000011111110000111110000001111100000000011000000"),
("111111111111111000011110000000000000111111110000111111000011111000000000011000000"),
("111111111111111100011110000000000000111111110000011111000111110000000000011000000"),
("111111111111111100011110000000000000111111111000001111100111100000000000011000000"),
("111100000000111110011100000000000001111001111000000111111111100000000000011000000"),
("111100000000011110111100000000000001111001111000000111111111000000000000011000000"),
("111100000000011110111100000000000011110001111100000011111110000000000000011000000"),
("111100000000011110111100000000000011110000111100000001111110000000000100011000100"),
("111100000000111100111100000000000111110000111100000001111100000000000110011001100"),
("111100000011111100111100000000000111111111111110000001111000000000000111111111000"),
("111111111111111000111100000000000111111111111110000011110000000000000011111110000"),
("111111111111110000111100000000001111111111111110000111110000000000000001111100000"),
("111111111111100000111100000000001111111111011111001111100000000000000000111000000"),
("111111111100000000111111111111111111000000001111001111000000000000000000000000000"),
("111100000000000000111111111111111110000000001111011111000000000000000000000000000"),
("111100000000000000111111111111111110000000001111111110000000000000000000000000000"),
("111100000000000000111111111111110000000000001111111100000000000000000000000000000"),
("111100000000000000000000000000000000000000001111110000000000000000000000000000000"),
("111100000000000000000000000000000000000000000111110000000000000000000000000000000")
);

begin 

--calculating  x & y coordination for drawing the pictures

-----	

	drawing_X	<= '1' when  (oCoord_X  >=X_begin) and  (oCoord_X < X_begin+record_X_size) else '0';
	drawing_Y	<= '1' when  (oCoord_Y  >= Y_begin)  and (oCoord_Y  < Y_begin+record_y_size) else '0';
            
	bCoord_X   <=  (oCoord_X-X_begin) when ( drawing_X = '1' and  drawing_Y = '1'  ) else 0 ; 
	bCoord_Y   <= (oCoord_Y-Y_begin) when ( drawing_X = '1' and  drawing_Y = '1'  ) else 0 ; 
	
----

	drawing_X2	<= '1' when  (oCoord_X  >=X2_begin) and  (oCoord_X < X2_begin+play_X_size) else '0';
	drawing_Y2	<= '1' when  (oCoord_Y  >= Y2_begin)  and (oCoord_Y  < Y2_begin+play_y_size) else '0';
            
	bCoord_X2   <=  (oCoord_X-X2_begin) when ( drawing_X2 = '1' and  drawing_Y2 = '1'  ) else 0 ; 
	bCoord_Y2   <= (oCoord_Y-Y2_begin) when ( drawing_X2 = '1' and  drawing_Y2 = '1'  ) else 0 ; 
	

process ( RESETn, CLK) 		
 begin
	if RESETn = '0' then	
		record_play_request <= '0';
	elsif CLK'event and CLK='1' then
		if  drawing_X='1' and drawing_Y='1' then 
			record_play_request <= recording(bCoord_Y , bCoord_X)  ;
			if recording_state = '1' then		
				mVGA_RGB <= x"e0" ;-- draw the picture in "red" if it's selected.
			else 
				mVGA_RGB <= x"34"  ;-- other wise draw it in "green"
			end if;
		elsif  drawing_X2='1' and drawing_Y2='1' then 
			record_play_request <= playing(bCoord_Y2 , bCoord_X2)  ;
			if playing_state = '1' then		
				mVGA_RGB <= x"00" ;
			else 
				mVGA_RGB <= x"34" ;
			end if;
		else
			record_play_request <= Notes_screen_request;-- draw the notes on this screen also
			if game_enable ='0' and playOriginal = '0' then
				mVGA_RGB <= x"00";
			elsif colors = "01" then
				mVGA_RGB <= x"23";
			elsif colors = "10" then
				mVGA_RGB <= x"e0" ;
			else
				mVGA_RGB <= x"00";
			end if;
		end if ;
	end if;
end process;
end behav;