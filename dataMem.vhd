library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dataMem is
  port(
    outA        : out std_logic_vector(31 downto 0);
    input       : in  std_logic_vector(31 downto 0);
    read_write : in  std_logic;
    sel     : in  std_logic_vector(31 downto 0);
    clk, mem_val: in  std_logic
    );
end dataMem;


architecture Behavioral of dataMem is
  type registerFile is array(0 to 4095) of std_logic_vector(7 downto 0);
  signal registers : registerFile;
begin
	regFile : process (clk) is
	begin
		if(mem_val = '1') then
			if falling_edge(clk)  then
				-- Read
				if read_write = '1' then
					outA <= registers(to_integer(unsigned(sel))) &
						registers(to_integer(unsigned(sel)) + 1) &
						registers(to_integer(unsigned(sel)) + 2) &
						registers(to_integer(unsigned(sel)) + 3);	--concatinate bytes
				end if;
			elsif rising_edge(clk) then
				-- Write to selected byte address
				if read_write = '0' then
					registers(to_integer(unsigned(sel))) <= input(31 downto 24);
					registers(to_integer(unsigned(sel)) + 1) <= input(23 downto 16);
					registers(to_integer(unsigned(sel)) + 2) <= input(15 downto 8);-- Write
					registers(to_integer(unsigned(sel)) + 3) <= input(7 downto 0);
				end if;
			end if;
		end if;
	end process;
end Behavioral;
