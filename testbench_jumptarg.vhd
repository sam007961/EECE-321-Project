library ieee; 
use ieee.std_logic_1164.all;

use ieee.numeric_std.all; 

entity test2test is 
end test2test; 

architecture test2body of test2test is 
component jumptarget 
	port (a: in std_logic_vector (19 downto 0); 
	b: in std_logic_vector (31 downto 0); 
	z:out std_logic_vector (31 downto 0));
end component; 

signal at: std_logic_vector(19 downto 0); 
signal bt: std_logic_vector (31 downto 0); 
signal zt: std_logic_vector (31 downto 0);
begin 
	u1: jumptarget port map( at,bt,zt); 
	
	process
	begin 
		at<="00000000000000111110"; bt<= "00000000001000000000000000000001"; wait for 10ns;  wait;
	end process; 
end test2body; 
