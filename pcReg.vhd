library ieee;
use ieee.std_logic_1164.all;

entity pcReg is
	port(clk, reset : in std_logic;
		pc_in : in std_logic_vector(31 downto 0);
		pc_out : out std_logic_vector(31 downto 0));
end entity;

architecture description of pcReg is
begin
	process(clk, reset)
	begin
		if reset = '1' then
			pc_out <= x"00000000";
		elsif rising_edge(clk) then
			pc_out <= pc_in;	--Update PC
		end if;
	end process;
end description;