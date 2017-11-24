library ieee;
use ieee.std_logic_1164.all;

entity pc_sel_comb is
	port( br_eq, br_lt : in std_logic;
		pc_sel: in std_logic_vector(1 downto 0);
		funct : in std_logic_vector(2 downto 0);
		pc_sel_final : out std_logic_vector(1 downto 0));
end pc_sel_comb;

architecture behavioral of pc_sel_comb is
begin
	pc_sel_final <= pc_sel when (pc_sel /= "01") else
					"01" when (pc_sel = "01" and
								( (funct = "000" and br_eq = '1') 
									or (funct = "001" and br_lt = '1') ) ) else
					"00";
end behavioral;