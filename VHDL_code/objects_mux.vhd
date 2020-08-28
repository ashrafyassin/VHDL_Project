library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
--- choose the request depending on the slot of the screen 
entity objects_mux is
port 	(
		--////////////////////	Clock Input	 	////////////////////	 
		CLK	: in std_logic; --						//	27 MHz
		RESETn : in std_logic;
		slot   :  in std_logic_vector(7 downto 0);
		
		y_drawing_request : in std_logic;	
		y_mVGA_RGB 	: in std_logic_vector(7 downto 0); --	,  -- background signal 
		
		screen_request : in std_logic;
		screen_RGB 	: in std_logic_vector(7 downto 0); --	, -- notes signal 
		
		soul_drawing_request	: in std_logic;				 -- soul request

		m_mVGA_R 	: out std_logic_vector(9 downto 0); --	,  
		m_mVGA_G 	: out std_logic_vector(9 downto 0); --	, 
		m_mVGA_B 	: out std_logic_vector(9 downto 0) --	,
	);
end objects_mux;

architecture behav of objects_mux is 
signal m_mVGA_t 	: std_logic_vector(7 downto 0);
begin

-- priority encoder process

process ( RESETn, CLK)
begin 
	if RESETn = '0' then
			m_mVGA_t <= (others => '0') ; 	
	elsif CLK'event and CLK='1' then
		m_mVGA_t <= y_mVGA_RGB ;
		if slot = "10000000" then ---if we are in the left side of the screen choose the soul rreq
			if soul_drawing_request = '1'  then		
				m_mVGA_t <= (others => '0');
			end if;		
		elsif screen_request = '1'  then  --- if we are not in the sides choose the notes request.
			m_mVGA_t <= screen_RGB;
		end if; 
	end if ; 
end process ;
m_mVGA_R	<= m_mVGA_t(7 downto 5)& "0000000"; -- expand to 10 bits 
m_mVGA_G	<= m_mVGA_t(4 downto 2)& "0000000";
m_mVGA_B	<= m_mVGA_t(1 downto 0)& "00000000";
end behav;