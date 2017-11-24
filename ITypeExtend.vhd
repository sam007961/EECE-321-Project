library ieee; 
use ieee.std_logic_1164.all;

use ieee.numeric_std.all; 

entity itypeextend is 
	port (a: in std_logic_vector (11 downto 0);
	z: out std_logic_vector (31 downto 0));
	
end itypeextend; 

architecture itypebody of itypeextend is
begin 
	z<= std_logic_vector(resize(signed(a), z'length));
end itypebody; 
