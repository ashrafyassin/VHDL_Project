library ieee;
use ieee.std_logic_1164.all;
entity divider_80 is
 port (
	CLK : in std_logic;
	RESETN : in std_logic ;
	one_sec_flag : out std_logic
 );
end entity;
architecture behav of divider_80 is
begin
process(CLK,RESETN)
 variable one_sec: integer ;
 constant sec: integer := 390000 ;
begin
	if RESETN = '0' then
		one_sec := 0 ;
		one_sec_flag <= '0' ;
	elsif rising_edge(CLK) then
		one_sec := one_sec + 1 ;
		if (one_sec > sec-1) then
			one_sec_flag <= '1' ;
			one_sec := 0;
		else
		one_sec_flag <= '0';
		end if;
	end if;
end process;
end behav;
