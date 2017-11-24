library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity plus4 is
	port ( pc : in std_logic_vector(31 downto 0);
		pc_next : out std_logic_vector(31 downto 0));
end entity;

architecture add4 of plus4 is
begin
	pc_next <= std_logic_vector(unsigned(pc) + 4); -- Increment PC by 4
end architecture;