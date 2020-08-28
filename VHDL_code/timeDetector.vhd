library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- measuring the pressed key time for each key and save its rate in rhythm--

entity timeDetector is 
	port (music : in std_logic_vector(16 downto 0);
		  clk : in std_logic;
		  RESET : in std_logic;
		  newKey : out std_logic;
		  Data : out std_logic_vector(8 downto 0)
		   );
end timeDetector;

architecture arc of timeDetector is
	
	type counter_array is array (0 to 16) of integer;
	constant clk_rate : integer := 1250000;
	signal rythem : integer;
	signal keyNumber : integer;
	
begin
	Data(8 downto 4) <=  conv_std_logic_vector(keyNumber,5);
	Data(3 downto 0) <=  conv_std_logic_vector(rythem ,4);
	process(clk , RESET)
		variable counters : counter_array;
	begin
		if RESET = '0' then
			 newKey <= '0';
             rythem  <= 0;
             keyNumber <= 0;
             counters := (others => 0);
        elsif rising_edge(clk) then
				newKey <='0' ;
				keyNumber <= 0;
			if music(0) = '0' and counters(0) > 0 then
				newKey <='1' ;
				keyNumber <= 1;
				if counters(0) < 10*clk_rate  then
					rythem <= 2;
				elsif( counters(0) < 20*clk_rate ) then
					rythem <= 4 ;
				else 
					rythem <= 8 ;
				end if;
			counters(0) := 0;	
			elsif music(0) = '1' then
				counters(0) := counters(0) +1 ;
			end if;
			
			if music(1) = '0' and counters(1) > 0 then
				newKey <='1' ;
				keyNumber <= 2;
				if counters(1) < 10*clk_rate  then
					rythem <= 2;
				elsif( counters(1) < 20*clk_rate ) then
					rythem <= 4 ;
				else 
					rythem <= 8 ;
				end if;
			counters(1) := 0;	
			elsif music(1) = '1' then
				counters(1) := counters(1) +1 ;
			end if;
			
			if music(2) = '0' and counters(2) > 0 then
				newKey <='1' ;
				keyNumber <= 3;
				if counters(2) < 10*clk_rate  then
					rythem <= 2;
				elsif( counters(2) < 20*clk_rate ) then
					rythem <= 4 ;
				else 
					rythem <= 8 ;
				end if;
			counters(2) := 0;	
			elsif music(2) = '1' then
				counters(2) := counters(2) +1 ;
			end if;
			
			if music(3) = '0' and counters(3) > 0 then
				newKey <='1' ;
				keyNumber <= 4;
				if counters(3) < 10*clk_rate  then
					rythem <= 2;
				elsif( counters(3) < 20*clk_rate ) then
					rythem <= 4 ;
				else 
					rythem <= 8 ;
				end if;
			counters(3) := 0;	
			elsif music(3) = '1' then
				counters(3) := counters(3) +1 ;
			end if;
			
			if music(4) = '0' and counters(4) > 0 then
				newKey <='1' ;
				keyNumber <= 5;
				if counters(4) < 10*clk_rate then
					rythem <= 2;
				elsif( counters(4) < 20*clk_rate ) then
					rythem <= 4 ;
				else 
					rythem <= 8 ;
				end if;
			counters(4) := 0;	
			elsif music(4) = '1' then
				counters(4) := counters(4) +1 ;
			end if;
			
			if music(5) = '0' and counters(5) > 0 then
				newKey <='1' ;
				keyNumber <= 6;
				if counters(5) < 20*clk_rate  then
					rythem <= 2;
				elsif( counters(5) < 20*clk_rate ) then
					rythem <= 4 ;
				else 
					rythem <= 8 ;
				end if;
			counters(5) := 0;	
			elsif music(5) = '1' then
				counters(5) := counters(5) +1 ;
			end if;
			
			if music(6) = '0' and counters(6) > 0 then
				newKey <='1' ;
				keyNumber <= 7;
				if counters(6) < 10*clk_rate  then
					rythem <= 2;
				elsif( counters(6) < 20*clk_rate ) then
					rythem <= 4 ;
				else 
					rythem <= 8 ;
				end if;
			counters(6) := 0;	
			elsif music(6) = '1' then
				counters(6) := counters(6) +1 ;
			end if;
			
			if music(7) = '0' and counters(7) > 0 then
				newKey <='1' ;
				keyNumber <= 8;
				if counters(7) < 10*clk_rate  then
					rythem <= 2;
				elsif( counters(7) < 20*clk_rate ) then
					rythem <= 4 ;
				else 
					rythem <= 8 ;
				end if;
			counters(7) := 0;	
			elsif music(7) = '1' then
				counters(7) := counters(7) +1 ;
			end if;
			
			if music(8) = '0' and counters(8) > 0 then
				newKey <='1' ;
				keyNumber <= 9;
				if counters(8) < 10*clk_rate  then
					rythem <= 2;
				elsif( counters(8) < 20*clk_rate ) then
					rythem <= 4 ;
				else 
					rythem <= 8 ;
				end if;
			counters(8) := 0;	
			elsif music(8) = '1' then
				counters(8) := counters(8) +1 ;
			end if;
			
			if music(9) = '0' and counters(9) > 0 then
				newKey <='1' ;
				keyNumber <= 10;
				if counters(9) < 10*clk_rate  then
					rythem <= 2;
				elsif( counters(9) < 20*clk_rate ) then
					rythem <= 4 ;
				else 
					rythem <= 8 ;
				end if;
			counters(9) := 0;	
			elsif music(9) = '1' then
				counters(9) := counters(9) +1 ;
			end if;
			
			if music(10) = '0' and counters(10) > 0 then
				newKey <='1' ;
				keyNumber <= 11;
				if counters(10) < 10*clk_rate  then
					rythem <= 2;
				elsif( counters(10) < 20*clk_rate ) then
					rythem <= 4 ;
				else 
					rythem <= 8 ;
				end if;
			counters(10) := 0;	
			elsif music(10) = '1' then
				counters(10) := counters(10) +1 ;
			end if;
			
			if music(11) = '0' and counters(11) > 0 then
				newKey <='1' ;
				keyNumber <= 12;
				if counters(11) < 10*clk_rate  then
					rythem <= 2;
				elsif( counters(11) < 20*clk_rate ) then
					rythem <= 4 ;
				else 
					rythem <= 8 ;
				end if;
			counters(11) := 0;	
			elsif music(11) = '1' then
				counters(11) := counters(11) +1 ;
			end if;
			
			if music(12) = '0' and counters(12) > 0 then
				newKey <='1' ;
				keyNumber <= 13;
				if counters(12) < 10*clk_rate  then
					rythem <= 2;
				elsif( counters(12) < 20*clk_rate ) then
					rythem <= 4 ;
				else 
					rythem <= 8 ;
				end if;
			counters(12) := 0;	
			elsif music(12) = '1' then
				counters(12) := counters(12) +1 ;
			end if;
			
			if music(13) = '0' and counters(13) > 0 then
				newKey <='1' ;
				keyNumber <= 14;
				if counters(13) < 10*clk_rate  then
					rythem <= 2;
				elsif( counters(13) < 20*clk_rate ) then
					rythem <= 4 ;
				else 
					rythem <= 8 ;
				end if;
			counters(13) := 0;	
			elsif music(13) = '1' then
				counters(13) := counters(13) +1 ;
			end if;
			
			if music(14) = '0' and counters(14) > 0 then
				newKey <='1' ;
				keyNumber <= 15;
				if counters(14) < 10*clk_rate  then
					rythem <= 2;
				elsif( counters(14) < 20*clk_rate ) then
					rythem <= 4 ;
				else 
					rythem <= 8 ;
				end if;
			counters(14) := 0;	
			elsif music(14) = '1' then
				counters(14) := counters(14) +1 ;
			end if;
			
			if music(15) = '0' and counters(15) > 0 then
				newKey <='1' ;
				keyNumber <= 16;
				if counters(15) < 10*clk_rate  then
					rythem <= 2;
				elsif( counters(15) < 20*clk_rate ) then
					rythem <= 4 ;
				else 
					rythem <= 8 ;
				end if;
			counters(15) := 0;	
			elsif music(15) = '1' then
				counters(15) := counters(15) +1 ;
			end if;
			
			if music(16) = '0' and counters(16) > 0 then
				newKey <='1' ;
				keyNumber <= 17;
				if counters(16) < 10*clk_rate  then
					rythem <= 2;
				elsif( counters(16) < 20*clk_rate ) then
					rythem <= 4 ;
				else 
					rythem <= 8 ;
				end if;
			counters(16) := 0;	
			elsif music(16) = '1' then
				counters(16) := counters(16) +1 ;
			end if;
		end if;
	end process;
end arc;