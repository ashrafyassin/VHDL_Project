library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

--- the game specail keys ---

entity Special_Keys is
	port ( 
	 clk : in std_logic ;	 
	 resetN : in std_logic ;
	 din : in std_logic_vector (8 downto 0);
	 make : in std_logic ;
	 break : in std_logic ;
	 start : out std_logic;
	 freeStyle : out std_logic;
	 Create : out std_logic;
	 playGame : out std_logic;
	 flute : out std_logic;
	 piano : out std_logic;
	 drums : out std_logic;
	 pitch :out std_logic;
	 recording : out std_logic;
	 playing : out std_logic;
	 escape : out std_logic;
	 stop_recording : out std_logic;
	 stop_playing : out std_logic
	 );
end Special_Keys;

architecture behavior of Special_Keys is
begin
process ( resetN , clk ,make, break)
	 begin
		 if resetN = '0' then
			start <= '0' ;
			freeStyle <= '0' ;
			Create <= '0' ;
			flute <= '0' ;
			piano <= '0' ;
			drums <= '0' ;
			recording <= '0' ;
			playing <= '0' ;
			escape <= '0' ; 
			stop_recording <= '0' ;
		 elsif rising_edge(clk) then
			 if (make = '1') then
				 case din is
					when "001011010" =>  --Enter=>start
								start <= '1';
					when "001101001" =>  -- 1
								freeStyle <= '1';
					when "001110010" =>  -- 2
								Create <= '1';
					when "001111010" => -- 3
								playGame<= '1';
					when "000010110" =>  -- 1
								flute <= '1';
					when "000011110" =>  -- 2
								piano <= '1';
					when "000100110" =>  -- 3
								drums <= '1';
					when "000100101" =>  -- 4
								pitch <= '1';
					when "101110101" =>  -- up arrow
								recording <= '1';
					when "101110010" =>  -- down arrow
								playing <= '1';
					when "000001101" =>  -- tap
								escape <= '1';	
					when "000101001" =>  --space => stop Recording/playing
								stop_recording  <= '1' ;
								stop_playing <= '1' ;
					when others =>
								escape <= '0';	
				end case;						
			elsif break = '1' then
				 case din is
					when "001011010" =>  --Enter=>start
								start <= '0';
					when "001101001" =>  -- 1
								freeStyle <= '0';
					when "001110010" =>  -- 2
								Create <= '0';
					when "001111010" => --3
								playGame<= '0';
					when "000010110" =>  -- 1
								flute <= '0';
					when "000011110" =>  -- 2
								piano <= '0';
					when "000100110" =>  -- 3
								drums <= '0';
					when "000100101" =>  -- 4
								pitch <= '0';
					when "101110101" =>  -- up arrow
								recording <= '0';
					when "101110010" =>  -- down arrow
								playing <= '0';
					when "000001101" =>  -- tap
								escape <= '0';	
					when "000101001" =>  --space => stop Recording/playing
								stop_recording  <= '0' ;
								stop_playing <= '0' ;
					when others =>
								escape <= '0';	
				end case;		
			end if;
		end if;
	 end process;
end architecture;