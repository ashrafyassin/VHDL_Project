library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

--- move one slot after each new key is pressed ,and clean the DPRAM befor playing in the playing state .
--- save the data in the DPRAM in the slot address.

entity checkAndColor is
	port ( 
		clk : in std_logic ;
		RESETn : in std_logic ;
		clear	: in std_logic;
		newKey: in std_logic;
		memNote : in std_logic_vector(8 downto 0);
		data_in : in std_logic_vector(8 downto 0);
		wren_out : out std_logic;
		slot_out : out std_logic_vector(7 downto 0);
		mem_addr : out std_logic_vector(7 downto 0);
		color : out std_logic_vector(1 downto 0);
		finish : out std_logic 
 );
end checkAndColor;

architecture behav of checkAndColor is 
--	signal tmp : std_logic_vector(8 downto 0);
begin
 process ( RESETn , clk)	
  	variable  counter: integer :=0;
  	variable pressed : std_logic := '0' ;
  	variable flag : std_logic := '0' ;
 begin
	if RESETn = '0' then
		counter := 0 ;
		finish <= '0';
		color <= "00";
		flag := '0';
		pressed := '0';
	--	tmp <= (others => '0');
	elsif rising_edge(clk) then
		if clear ='1' and flag = '0'  then --start reset
			if pressed = '0' then
				pressed := '1';
				counter := 0 ;
			end if;	
			color <= "00"; --- insert zeros to the DPRAM 
			slot_out <= conv_std_logic_vector(counter,8);
			counter := counter+1;
			wren_out <= '1';
			if counter > 63 then
				flag := '1';
				counter := 0;
			end if;
		elsif newKey = '1' then 
			pressed := '0';
			flag := '0';
		--	tmp <= data_in;
			if (data_in = memNote) then
				color <= "01";
			else
				color <= "10" ;
			end if;
			slot_out <=conv_std_logic_vector(counter,8);
			wren_out <= newKey ;
			finish <= '0' ;
			if counter > 32 then
				counter := 0;
				finish <= '1' ;
			end if;
				counter := counter+1; --indecate to the next slot
				mem_addr <=conv_std_logic_vector(counter,8);
		end if;
	end if;
 end process;
end architecture;