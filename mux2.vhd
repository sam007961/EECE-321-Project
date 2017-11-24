library ieee;
use ieee.std_logic_1164.all;

entity mux2 is
	port ( sel : in std_logic;
		A : in std_logic_vector(31 downto 0);
		B : in std_logic_vector(31 downto 0);
		X : out std_logic_vector(31 downto 0));
end mux2;

architecture Behavioral of mux2 is
begin
	X <= A when (sel = '1') else B;
end Behavioral;


