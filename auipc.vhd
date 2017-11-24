library ieee; 
use ieee.std_logic_1164.all;

use ieee.numeric_std.all; 

entity auipc is 
	port (a: in std_logic_vector (31 downto 0); 
	b: in std_logic_vector (19 downto 0); 
	z:out std_logic_vector (31 downto 0)); 
	
end auipc;

architecture auipcbody of auipc is 
begin 
	z<= std_logic_vector ((signed(b) sll 12) + signed(a) ); 
end auipcbody; 
