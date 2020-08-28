library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

--- creating enable for the adsr effects for 2 seconds for every key--

entity ADSR_Cycle is
	port ( 
	 clk : in std_logic ;	 
	 resetN : in std_logic ;
	 ena_adsr 	: in std_logic;
	 div : in std_logic_vector(11 downto 0);
	 enable_AD : out std_logic 
);
end ADSR_Cycle;

architecture behavior of ADSR_Cycle is
	
	signal pressed: std_logic;
	signal ena: std_logic;
	
begin
enable_AD <= ena;
process ( resetN , clk ) 
	 variable counter : integer := 0;
	 constant Cycle : integer := 2;
	 constant sec : integer := 49999000;
	 begin
		if resetN = '0' then 
			ena <= '0' ;
			counter := 0;
			pressed <= '0';
		elsif rising_edge(clk) then
			ena <= '0';
			if ena_adsr = '1' then
				if (div >0   and  pressed ='0') then
					counter := 0;
					pressed <='1';
				elsif (div > 0 and pressed = '1' and counter < Cycle*sec) then
					counter := counter +1 ;
					ena <= '1';
				end if;
			end if;
			if (div = 0) then
				pressed <='0' ;
			end if;
		end if;
	 end process;
end architecture;
