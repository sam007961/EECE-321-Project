library ieee; 
use ieee.std_logic_1164.all;

use ieee.numeric_std.all; 

entity test7test is 
end test7test; 

architecture test7body of test7test is 
component auipc
	port (a: in std_logic_vector (31 downto 0); 
	b: in std_logic_vector (19 downto 0); 
	z:out std_logic_vector (31 downto 0));
end component; 

signal at: std_logic_vector(31 downto 0); 
signal bt: std_logic_vector (19 downto 0); 
signal zt: std_logic_vector(31 downto 0); 	

begin 
	u1: auipc port map( at,bt,zt); 
	
	process
	begin 
		at<=x"00000001"; bt<= x"00001"; wait for 10ns;  wait;
	end process; 
end test7body; 