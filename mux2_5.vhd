library ieee;
use ieee.std_logic_1164.all;

entity mux2_5 is
	port ( sel : in std_logic;
		A : in std_logic_vector(4 downto 0);
		B : in std_logic_vector(4 downto 0);
		X : out std_logic_vector(4 downto 0));
end mux2_5;

architecture Behavioral of mux2_5 is
begin
	X <= A when (sel = '1') else B;
end Behavioral;


