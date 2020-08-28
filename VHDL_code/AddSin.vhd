library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

 --- add the sin inputs to one sin signal and normalize it to be from -128 to 127 ---
 
entity AddSin is
	port(Q1 : in signed(7 downto 0);
		 Q2 : in signed(7 downto 0);
		 Q3 : in signed(7 downto 0);
		 enable1 : in std_logic;
		 enable2 : in std_logic;
		 enable3 : in std_logic;
		 Qout: out std_logic_vector(7 downto 0));
		
end AddSin;

architecture arc of AddSin is
begin
	process(Q1,Q2,Q3)
		variable counter : integer :=0;
	begin
		if enable1 = '1' then
			counter := counter + 1;
		end if;
		if enable2 = '1' then
			counter := counter + 1;
		end if;
		if enable3 = '1' then
			counter := counter + 1;
		end if;
		if counter = 1 then
			Qout<= conv_std_logic_vector(conv_integer(Q1)+conv_integer(Q2)+conv_integer(Q3),8) ; 
		elsif counter = 2 then
			Qout<= conv_std_logic_vector(conv_integer(Q1(7 downto 1))+conv_integer(Q2(7 downto 1))+conv_integer(Q3(7 downto 1)),8) ; 
		elsif counter =3 then 
			Qout<= conv_std_logic_vector((conv_integer(Q1)+conv_integer(Q2)+conv_integer(Q3))/counter,8) ;
		else
			Qout <= (others=>'0');
		end if;
		counter := 0;
	end process;
end arc;