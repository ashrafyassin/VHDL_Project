library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

--- move one slot after each new key is pressed ,and clean the DPRAM befor playing in the playing state .
--- save the data in the DPRAM in the slot address.

entity ScreenUpdate is
	port ( 
		clk : in std_logic ;
		RESETn : in std_logic ;
		clear : in std_logic;
		read_ena : in std_logic ;
		wren_in : in std_logic;
		data_in : in std_logic_vector(8 downto 0);
		wren_out : out std_logic;
		slot_out : out std_logic_vector(7 downto 0);
		data_out : out std_logic_vector(8 downto 0)
 );
end ScreenUpdate;

architecture behav of ScreenUpdate is 

begin
 process ( RESETn , clk)	
  	variable counter: integer :=0;
	variable flag: std_logic := '0' ;
	variable pressed : std_logic := '0' ;
	variable flag1: std_logic := '0' ;
	variable pressed1 : std_logic := '0' ;
 begin
	if RESETn = '0' then
		data_out <=(others => '0'); 
		slot_out <= (others => '0'); 
		wren_out <= '1';
	elsif rising_edge(clk) then
		if clear ='1' and flag1 = '0'  then --start reset
			if pressed1 = '0' then
				pressed1 := '1';
				counter := 0 ;
			end if;	
			data_out <=(others => '0'); --- insert zeros to the DPRAM 
			slot_out <= conv_std_logic_vector(counter,8);
			counter := counter+1;
			wren_out <= '1';
			if counter > 255 then
				flag1 := '1';
				counter := 0;
			end if;
		elsif flag1 = '1' and clear = '0'  then
			counter := 0 ;
			pressed1 := '0' ;
			flag1 := '0' ;
		elsif read_ena = '1' and (flag = '0') then --start reset
			if pressed = '0' then
				pressed := '1';
				counter := 0 ;
			end if;	
			data_out <=(others => '0'); --- insert zeros to the DPRAM 
			slot_out <= conv_std_logic_vector(counter,8);
			counter := counter+1;
			wren_out <= '1';
			if counter > 255 then
				flag := '1';
				counter := 0;
			end if;
		elsif flag='1' or pressed = '0' then -- reset finished
			if read_ena = '0' then
				pressed := '0' ;
				flag := '0' ;
			end if;
			data_out <= data_in; -- move the input to the output in the right slot 
			slot_out <=conv_std_logic_vector(counter,8);
			wren_out <= wren_in ;
			if counter >=3*66 then-- after 3 screens continue from the first screen
				counter := 0;
			end if;
			if wren_in = '1' then
				counter := counter+1; --indecate to the next slot
			end if;
		end if;
	end if;
 end process;
end architecture;