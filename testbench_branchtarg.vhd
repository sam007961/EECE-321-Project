library ieee; 
use ieee.std_logic_1164.all;

use ieee.numeric_std.all; 

entity test3test is 
end test3test; 

architecture test3body of test3test is 
component branchtarget 
	port (a: in std_logic_vector(31 downto 0); 
	b:in std_logic_vector (31 downto 0); 
	z: out std_logic_vector (31 downto 0));
end component; 

signal at: std_logic_vector(31 downto 0); 
signal bt: std_logic_vector (31 downto 0); 
signal zt: std_logic_vector (31 downto 0);
begin 
	u1: branchtarget port map( at,bt,zt); 
	
	process
	begin 
		at<="00000000000000000000000000001111"; bt<= "00000000000000000000000000000011"; wait for 10ns;  wait;
	end process; 
end test3body; 