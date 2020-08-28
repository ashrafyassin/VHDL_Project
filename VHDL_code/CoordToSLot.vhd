library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

----- calculating the slot of the vga scanner based on the x and y coordination---

entity CoordToSLot is
port 	(
	   	CLK  		: in std_logic;
		RESETn		: in std_logic;
		oCoord_X	: in integer;
		oCoord_Y	: in integer;
		present_slot : in std_logic_vector(7 downto 0) ;
		Slot	: out std_logic_vector(7 downto 0)
	);
end CoordToSLot;

architecture behav of CoordToSLot is 
	
	signal slot_t : std_logic_vector(7 downto 0);	
	signal  slot_X : integer;
	signal slot_Y : integer;
	signal slot_YF : integer;
begin 
	Slot <= slot_t;
	process ( RESETn, CLK)
	variable x : integer :=0 ;
	begin
		if RESETn = '0' then
			slot_t <= (others=>'0');	
		elsif CLK'event and CLK='1' then
		
--- number of the CURRENT screen
			x := conv_integer(present_slot)/66; 
			
--- this cordination indecates to draw the soul.			
			if (oCoord_X < 55 or oCoord_X > 605) and oCoord_Y < 400 then 
					slot_t <= "10000000";
					
---calculate the slot 					
			else							
				slot_X <=(oCoord_X-55)/(25);
				slot_Y <=(oCoord_Y-15)/(120);
				slot_t <= conv_std_logic_vector(slot_X+22*slot_Y+66*x,8);
			end if;
		end if;
	end process;
end behav;		
		