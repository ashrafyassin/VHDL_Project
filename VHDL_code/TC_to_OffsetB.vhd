library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity TC_to_OffsetB is
	port(TC : in std_logic_vector(7 downto 0);
		 OffsetB : out std_logic_vector(7 downto 0));
		
end TC_to_OffsetB;

architecture arc_TC_to_OffsetB of TC_to_OffsetB is
begin
	process(TC)
	begin
		if TC(7) = '0' then
			OffsetB <= TC - "10000000" ;
		else
			OffsetB <= TC + "10000000" ;
		end if;
	end process;
end arc_TC_to_OffsetB;