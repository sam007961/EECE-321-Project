library ieee; 
use ieee.std_logic_1164.all;

use ieee.numeric_std.all; 

entity jumpreggen is 
	port (a:in std_logic_vector(31 downto 0); 
	b:in std_logic_vector (31 downto 0);
	z:out std_logic_vector(31 downto 0)); 
	
end jumpreggen; 

architecture jumpreggenbody of jumpreggen is 
begin
z<=std_logic_vector( resize(signed(a) * 2 ,z'length ) + signed(b)); 
end jumpreggenbody;