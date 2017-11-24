library ieee; 
use ieee.std_logic_1164.all;

use ieee.numeric_std.all;  

entity branchtarget is 
	port (a: in std_logic_vector(31 downto 0); 
	b:in std_logic_vector (31 downto 0); 
	z: out std_logic_vector (31 downto 0));
	
end branchtarget; 

architecture branchbody of branchtarget is 
begin 
	z<= std_logic_vector( unsigned(a) + unsigned(a) + unsigned(b));	
end branchbody; 
