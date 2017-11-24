library ieee; 
use ieee.std_logic_1164.all;

use ieee.numeric_std.all; 

entity branchcond is 
	port ( a:in std_logic_vector (31 downto 0); 
	b:in std_logic_vector (31 downto 0); 
	z:out std_logic; 
	x:out std_logic);
end branchcond; 

architecture branchcondbody of branchcond is 
begin 
	process	(a,b)
	begin
	if signed(a) = signed(b) then 
		z<= '1'; 
	else z<= '0'; 
	end if; 
	if signed(a)< signed(b) then 
		x<='1'; 
	else x<='0'; 
	end if; 
	end process; 
	end branchcondbody; 
	