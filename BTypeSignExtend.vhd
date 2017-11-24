library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BTypeSignExtend is
	port ( imm12_7 : in std_logic_vector(4 downto 0);
		imm12_25 : in std_logic_vector(6 downto 0);
		extd : out std_logic_vector(31 downto 0));
end entity;

architecture Behavioral of BTypeSignExtend is
signal temp : std_logic_vector(11 downto 0);
begin
	temp <=  imm12_25 & imm12_7;
	extd <= std_logic_vector(resize(signed(temp), extd'length));
end Behavioral;