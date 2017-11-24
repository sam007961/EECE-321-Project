library ieee;
use ieee.std_logic_1164.all;

entity clock is
	port(clk : out std_logic;
		reset : in std_logic);
end clock;

architecture behavioral of clock is
	signal temp : std_logic := '1';
begin
	process
	begin
		if (reset = '0') then
			wait for 1 us;
			temp <= NOT temp;
		else
			temp <= '1';
			wait for 1 us;
		end if;
		
	end process;
	clk <= temp;
end behavioral;