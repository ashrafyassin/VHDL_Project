library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reset is
port(
	resetN  : in std_logic ;
    div    : in std_logic_vector(11 downto 0);
    ena     : out std_logic
);
end reset;

architecture arch of reset is
begin
process(resetN, div)
  begin
    if (resetN='0') or div="000000000000" then
      ena <= '1';
     else 
     ena <= '0';
     end if;
  end process;
end arch;