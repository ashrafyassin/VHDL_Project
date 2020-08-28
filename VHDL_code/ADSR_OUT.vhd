library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

-- multiply the ADSR with the sin signal to create the ADSR envelope --

entity ADSR_OUT is
port(
  CLK     : in std_logic;
  RESET_N : in std_logic;  
  ENA	  : in std_logic;
  ADSR    : in signed(7 downto 0);
  input   :  in signed(7 downto 0);
  Q       : out std_logic_vector(7 downto 0)
);
end ADSR_OUT;

architecture arch of ADSR_OUT is
begin
process(RESET_N, CLK)
    variable tmp : std_logic_vector ( 15 downto 0);
  begin
    if (RESET_N='0') then
      tmp := (others=> '0');
    elsif(rising_edge(CLK)) then
      if (ENA = '1') then
          tmp :=conv_std_logic_vector(conv_integer(ADSR)*conv_integer(input),16);
          tmp(15 downto 8) := tmp (14 downto 8) & '0';
       else	
			tmp(15 downto 8) := conv_std_logic_vector(input,8);
      end if;
    end if;
    Q<= tmp(15 downto 8);
  end process;
end arch;