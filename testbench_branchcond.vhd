library ieee; 
use ieee.std_logic_1164.all;

use ieee.numeric_std.all; 

entity test5test is 
end test5test; 

architecture test5body of test5test is 
component branchcond 
	port ( a:in std_logic_vector (31 downto 0); 
	b:in std_logic_vector (31 downto 0); 
	z:out std_logic; 
	x:out std_logic);
end component; 

signal at: std_logic_vector(31 downto 0); 
signal bt: std_logic_vector (31 downto 0); 
signal zt: std_logic; 	
signal xt: std_logic;
begin 
	u1: branchcond port map( at,bt,zt,xt); 
	
	process
	begin 
		at<=x"00000000"; bt<= x"00000004"; wait for 10ns;  wait;
	end process; 
end test5body; 