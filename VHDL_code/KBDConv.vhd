library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- creating vector with notes size ---

--  key is pressed <=> vector[key]='1' ----

entity KBDConv is
	port ( 
	 clk : in std_logic ;	 
	 resetN : in std_logic ;
	 KbdEnable : in std_logic; 
	 din : in std_logic_vector (8 downto 0);
	 make : in std_logic ;
	 break : in std_logic ;
	 NotesVec  : out std_logic_vector(16 downto 0)
	 );
end KBDConv;

architecture behavior of KBDConv is
begin
process ( resetN , clk ,make, break)

	 variable tmpVec : std_logic_vector ( 16 downto 0);
	 variable Pressed : std_logic_vector ( 16 downto 0);
	 variable counter : integer :=0 ;
	 
	 begin
		 if resetN = '0' then
			 tmpVec := (others=>'0');
			 counter :=0;
		 elsif rising_edge(clk) then
		 if KbdEnable = '1' then
			 if (make = '1') and counter < 3 then -- play up to three keys once .
				counter := counter +1 ;
				 case din is
					when "000011100" =>  -- C4 / A
									if Pressed(0) = '1' then
										counter := counter - 1; 
									else
										tmpVec(0) := '1';
										Pressed(0) := '1';
									end if;
					when "000011101" =>  -- C4# /W
									if Pressed(1) = '1' then
										counter := counter - 1; 
									else
										tmpVec(1) := '1';
										Pressed(1) := '1';
									end if;
					when "000011011" =>-- D4 / S
									if Pressed(2) = '1' then
										counter := counter - 1; 
									else
										tmpVec(2) := '1';
										Pressed(2) := '1';
									end if;
					when "000100100" =>  -- D4# /E
									if Pressed(3) = '1' then
										counter := counter - 1; 
									else
										tmpVec(3) := '1';
										Pressed(3) := '1';
									end if;
					when "000100011" => -- E4 /D
									if Pressed(4) = '1' then
										counter := counter - 1; 
									else
										tmpVec(4) := '1';
										Pressed(4) := '1';
									end if;
					when "000101011" =>-- F4 /F
									if Pressed(5) = '1' then
										counter := counter - 1; 
									else
										tmpVec(5) := '1';
										Pressed(5) := '1';
									end if;
					when "000101100" => -- F4# /T
									if Pressed(6) = '1' then
										counter := counter - 1; 
									else
										tmpVec(6) := '1';
										Pressed(6) := '1';
									end if;
					when "000110100" => -- G4 /G
									if Pressed(7) = '1' then
										counter := counter - 1; 
									else
										tmpVec(7) := '1';
										Pressed(7) := '1';
									end if;
					when "000110101" => -- G4# /Y
									if Pressed(8) = '1' then
										counter := counter - 1; 
									else
										tmpVec(8) := '1';
										Pressed(8) := '1';
									end if;
					when "000110011" => -- A4 /H
									if Pressed(9) = '1' then
										counter := counter - 1;
									else
										tmpVec(9) := '1';
										Pressed(9) := '1';
									end if;
					when "000111100" => -- A4# /U
									if Pressed(10) = '1' then
										counter := counter - 1;
									else
										tmpVec(10) := '1';
										Pressed(10) := '1';
									end if;
					when "000111011" => -- B4 /J
									if Pressed(11) = '1' then
										counter := counter - 1;
									else
										tmpVec(11) := '1';
										Pressed(11) := '1';
									end if;
					when "001000010" =>-- C5/ K
									if Pressed(12) = '1' then
										counter := counter - 1;
									else
										tmpVec(12) := '1';
										Pressed(12) := '1';
									end if;
					when "001000100" =>-- C5#/O
									if Pressed(13) = '1' then
										counter := counter - 1;
									else
										tmpVec(13) := '1';
										Pressed(13) := '1';
									end if;
					when "001001011" => -- D5 / L
									if Pressed(14) = '1' then
										counter := counter - 1;
									else
										tmpVec(14) := '1';
										Pressed(14) := '1';
									end if;
					when "001001101" => -- D5# /P
									if Pressed(15) = '1' then
										counter := counter - 1;
									else
										tmpVec(15) := '1';
										Pressed(15) := '1';
									end if;
					when "001001100" => -- E5 / ;
									if Pressed(16) = '1' then
										counter := counter - 1;
									else
										tmpVec(16) := '1';
										Pressed(16) := '1';
									end if;
					when others =>
									counter := counter -1;
				end case;						
			elsif(break = '1') and counter >= 0 then -- update the vector after eache release 
				 case din is
					when "000011100" => 
									if tmpVec(0) = '1' then
										tmpVec(0) := '0';
										Pressed(0) := '0';
										counter := counter - 1;
									end if;
					when "000011101" => 
									if tmpVec(1) = '1' then
										tmpVec(1) := '0';
										Pressed(1) := '0';
										counter := counter - 1;
									end if;
					when "000011011" =>
									if tmpVec(2) = '1' then
										tmpVec(2) := '0';
										Pressed(2) := '0';
										counter := counter - 1;
									end if;
					when "000100100" => 
									if tmpVec(3) = '1' then
										tmpVec(3) := '0';
										Pressed(3) := '0';
										counter := counter - 1;
									end if;
					when "000100011" =>
									if tmpVec(4) = '1' then
										tmpVec(4) := '0';
										Pressed(4) := '0';
										counter := counter - 1;
									end if;
					when "000101011" =>
									if tmpVec(5) = '1' then
										tmpVec(5) := '0';
										Pressed(5) := '0';
										counter := counter - 1;
									end if;
					when "000101100" =>
									if tmpVec(6) = '1' then
										tmpVec(6) := '0';
										Pressed(6) := '0';
										counter := counter - 1;
									end if;
					when "000110100" =>
									if tmpVec(7) = '1' then
										tmpVec(7) := '0';
										Pressed(7) := '0';
										counter := counter - 1;
									end if;
					when "000110101" =>
									if tmpVec(8) = '1' then
										tmpVec(8) := '0';
										Pressed(8) := '0';
										counter := counter - 1;
									end if;
					when "000110011" =>
									if tmpVec(9) = '1' then
										tmpVec(9) := '0';
										Pressed(9) := '0';
										counter := counter - 1;
									end if;
					when "000111100" =>
									if tmpVec(10) = '1' then
										tmpVec(10) := '0';
										Pressed(10) := '0';
										counter := counter - 1;
									end if;
					when "000111011" =>
									if tmpVec(11) = '1' then
										tmpVec(11) := '0';
										Pressed(11) := '0';
										counter := counter - 1;
									end if;
					when "001000010" =>
									if tmpVec(12) = '1' then
										tmpVec(12) := '0';
										Pressed(12) := '0';
										counter := counter - 1;
									end if;
					when "001000100" =>
									if tmpVec(13) = '1' then
										tmpVec(13) := '0';
										Pressed(13) := '0';
										counter := counter - 1;
									end if;
					when "001001011" =>
									if tmpVec(14) = '1' then
										tmpVec(14) := '0';
										Pressed(14) := '0';
										counter := counter - 1;
									end if;
					when "001001101" =>
									if tmpVec(15) = '1' then
										tmpVec(15) := '0';
										Pressed(15) := '0';
										counter := counter - 1;
									end if;
					when "001001100" =>
									if tmpVec(16) = '1' then
										tmpVec(16) := '0';
										Pressed(16) := '0';
										counter := counter - 1;
									end if;
					when others => 
									
				end case;				
			end if;
		end if;
		 NotesVec <= tmpVec;
	end if;
end process;
end architecture;