library ieee; 
use ieee.std_logic_1164.all;

use ieee.numeric_std.all; 

entity test6test is 
end test6test; 

architecture test6body of test6test is 
component itypeextend 
	port (a: in std_logic_vector (11 downto 0);
	z: out std_logic_vector (31 downto 0));
end component; 

signal at: std_logic_vector(11 downto 0); 

signal zt: std_logic_vector (31 downto 0); 	

begin 
	u1: itypeextend port map( at,zt); 
	
	process
	begin 
		at<=x"001"; wait for 10ns;  wait;
	end process; 
end test6body; 