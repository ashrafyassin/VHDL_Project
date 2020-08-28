library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- choose the enabled adsr effect --

entity Choose_ADSR is
port 	(
	   	CLK  		: in std_logic;
		RESETn		: in std_logic;
		ena_pitch	:in std_logic ;
		ena_drum	:in std_logic ;
		ena_flute	:in std_logic ;
		Pitch		: in std_logic_vector(7 downto 0);
		Drum		: in std_logic_vector(7 downto 0);
		flute		: in std_logic_vector(7 downto 0);
		ADSR_Out	: out std_logic_vector(7 downto 0)
	);
end Choose_ADSR;

architecture behav of Choose_ADSR is
begin 
 process(RESETn,CLK) 
 begin
	if RESETn = '0' then
		ADSR_Out <= (others => '0');
	elsif rising_edge(CLK) then 
		if ena_pitch = '1' then
			ADSR_Out <= Pitch;
		elsif ena_drum = '1' then
			ADSR_Out <= Drum; 
		else
			ADSR_Out <= flute ;
		end if;
	end if;
end process;
end behav;