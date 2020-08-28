library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

--- the game state machine ---

entity State_Machine is
	port(
	 clk : in std_logic ;	 
	 resetN : in std_logic ;
	 start : in std_logic;
	 freeStyle : in std_logic;
	 Create : in std_logic;
	 playGame : in std_logic;
	 finish   : in std_logic ;
	 flute : in std_logic;
	 piano : in std_logic;
	 drums : in std_logic;
	 pitch : in std_logic;
	 recording : in std_logic;
	 playing : in std_logic;
	 escape : in std_logic;
	 stop_playing : in std_logic;
	 stop_recording : in std_logic;
	 screen : out std_logic_vector(1 downto 0);
	 RecordEna : out std_logic;
	 PlayEna : out std_logic;
	 KbdEnable : out std_logic;
	 FluteEna : out std_logic;
	 pianoEna : out std_logic;
	 DrumEna : out std_logic;
	 pitchEna : out std_logic;
	 playOriginal : out std_logic;
	 gameEnable	  : out std_logic;
	 clear  : out std_logic
); 
	 
end State_Machine;

architecture arc of State_Machine is
	type state_type is (START_s, PICK_INSTRUMENT, FREESTYLE_s,PLAYGAME_s, RECORDING_s, PLAYING_s);
	signal state : state_type;
begin 
	process(clk, resetN)
	begin
	 if resetN = '0' then
         state <= START_s;
		 screen <= "00" ;
         RecordEna <= '0' ;
	     PlayEna <= '0' ;
         KbdEnable <= '0' ;
         pitchEna <= '0' ;
         FluteEna <= '0' ;
         DrumEna <= '0' ;
         gameEnable <= '0' ;
         playOriginal <= '0' ;
         clear <= '0' ;
     elsif rising_edge(clk) then
		clear <= '0' ;
        case state is
			when START_s => ---the start screen is where we can pick the free style mood or to record
				clear <= '1' ;
				KbdEnable <= '0' ;
				FluteEna <= '0' ;
				pianoEna <= '0' ; 
				DrumEna <= '0' ;
				pitchEna <= '0' ;
				RecordEna <= '0' ;
				PlayEna <= '0' ;
				gameEnable <= '0' ;
				playOriginal <= '0' ; 
				if freesTyle = '1' then
					screen <= "01" ; -- go to the pick instrument screen 
					state <= PICK_INSTRUMENT;
				elsif Create = '1' then
					screen <= "10"; -- go to the press to record screen
					state <= RECORDING_s;
				elsif playGame= '1' then 
					screen <= "10" ;
					state <= PLAYGAME_s;
				end if;
				
			when PICK_INSTRUMENT =>
				KbdEnable <= '0' ;
				if escape  = '1' then -- when escape is pressed, go back to the pick mode screen
					state <= START_s;
					screen <= "00" ;
				elsif piano = '1' or drums = '1' or flute = '1' or pitch = '1'  then
					KbdEnable <= '1' ;
					state <= FREESTYLE_s ;
				end if;
			when PLAYGAME_s => 
				gameEnable <= '1' ;
				if escape  = '1' then -- when escape is pressed, go back to the pick mode screen
					state <= START_s;
					screen <= "00" ;
				end if;
				KbdEnable <= '1' ;
				RecordEna <= '1' ;
				if finish= '1' then
					KbdEnable <= '0' ;
					RecordEna <= '0' ;
					PlayEna <= '1' ;
					playOriginal <= '1'; 
					state <= PLAYING_s ;
				end if;
			when FREESTYLE_s => --- play with the instrument that was choosen by the user
				KbdEnable <= '1' ;
				PlayEna <= '0' ;
				if escape  = '1' then -- when escape is pressed, go back to the pick mode screen
					state <= START_s;
					screen <= "00" ;
				elsif flute = '1' then 
					FluteEna <= '1' ;
					pianoEna <= '0' ; 
					DrumEna <= '0' ;
					pitchEna <= '0' ;
				elsif piano = '1' then
					FluteEna <= '0' ;
					pianoEna <= '1' ; 
					DrumEna <= '0' ;
					pitchEna <= '0' ;
				elsif drums = '1' then
					FluteEna <= '0' ;
					pianoEna <= '0' ; 
					DrumEna <= '1' ;
					pitchEna <= '0' ;
				elsif pitch = '1' then
					FluteEna <= '0' ;
					pianoEna <= '0' ; 
					DrumEna <= '0' ;
					pitchEna <= '1' ;
				end if;
			when RECORDING_s => -- record state
				if escape  = '1' then -- when escape is pressed, go back to the pick mode screen
					state <= START_s;
					screen <= "00" ;
				elsif recording = '1' then
					 PlayEna <= '0' ;
					 RecordEna <= '1' ;
					 KbdEnable <= '1' ;
				elsif stop_recording = '1' then
					RecordEna <= '0' ;
					KbdEnable <= '0' ;
				elsif playing =  '1' then ---move to play state if playing button was pressed 
					KbdEnable <= '0' ;
					RecordEna <= '0' ;
					PlayEna <= '1' ;
					state <= PLAYING_s ;
				end if;
			when PLAYING_s => --- play state 
				KbdEnable <= '0' ;
				if escape  = '1' then -- when escape is pressed, go back to the pick mode screen
					state <= START_s;
					screen <= "00" ;
				elsif flute = '1' then 
					FluteEna <= '1' ;
					pianoEna <= '0' ; 
					DrumEna <= '0' ;
					pitchEna <= '0' ;
				elsif piano = '1' then
					FluteEna <= '0' ;
					pianoEna <= '1' ; 
					DrumEna <= '0' ;
					pitchEna <= '0' ;
				elsif drums = '1' then
					FluteEna <= '0' ;
					pianoEna <= '0' ; 
					DrumEna <= '1' ;
					pitchEna <= '0' ;
				elsif pitch = '1' then
					FluteEna <= '0' ;
					pianoEna <= '0' ; 
					DrumEna <= '0' ;
					pitchEna <= '1' ;
				elsif playing =  '1' then
					KbdEnable <= '0' ;
					RecordEna <= '0' ;
					PlayEna <= '1' ;
				elsif stop_playing = '1' then
					PlayEna <= '0' ;
					playOriginal <= '0' ;
				elsif recording = '1' then ---move to record state if recording button was pressed
					 PlayEna <= '0' ;
					 RecordEna <= '1' ;
					 KbdEnable <= '1' ;
					state <= RECORDING_s;
				end if;				
		end case;
	end if;
end process;
end arc;
				

			
        