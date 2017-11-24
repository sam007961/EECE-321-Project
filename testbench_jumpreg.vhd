library ieee; 
use ieee.std_logic_1164.all;

use ieee.numeric_std.all; 

entity test4test is 
end test4test; 

architecture test4body of test4test is 
component jumpreggen 
	port (a:in std_logic_vector(31 downto 0); 
	b:in std_logic_vector (31 downto 0);
	z:out std_logic_vector(31 downto 0)); 
end component; 

signal at: std_logic_vector(31 downto 0); 
signal bt: std_logic_vector (31 downto 0); 
signal zt: std_logic_vector (31 downto 0);
begin 
	u1: jumpreggen port map( at,bt,zt); 
	
	process
	begin 
		at<="00000000000000000000000000001111"; bt<= "00000000000000000000000000000011"; wait for 10ns;  wait;
	end process; 
end test4body; 