library ieee;
use ieee.std_logic_1164.all;

entity mux4 is
	port ( sel : in std_logic_vector(1 downto 0);
		A : in std_logic_vector(31 downto 0);
		B : in std_logic_vector(31 downto 0);
		C : in std_logic_vector(31 downto 0);
		D : in std_logic_vector(31 downto 0);
		X : out std_logic_vector(31 downto 0));
end mux4;

architecture Behavioral of mux4 is
begin
	X <= A when (sel = "00") else
         B when (sel = "01") else
         C when (sel = "10") else
         D;
end Behavioral;



		