library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
  port(
    outA        : out std_logic_vector(31 downto 0);
    outB        : out std_logic_vector(31 downto 0);
    input       : in  std_logic_vector(31 downto 0);
    writeEnable : in  std_logic;
    regASel     : in  std_logic_vector(4 downto 0);
    regBSel     : in  std_logic_vector(4 downto 0);
    writeRegSel : in  std_logic_vector(4 downto 0);
    clk         : in  std_logic
    );
end register_file;


architecture Behavioral of register_file is
  type registerFile is array(0 to 31) of std_logic_vector(31 downto 0);
  signal registers : registerFile;
begin
	regFile : process (clk, regASel, regBSel) is
	begin
		outA <= registers(to_integer(unsigned(regASel)));
		outB <= registers(to_integer(unsigned(regBSel)));
		
		if rising_edge(clk) then
			-- Write to selected register
			if writeEnable = '1' then
				registers(to_integer(unsigned(writeRegSel))) <= input;  -- Write
				if regASel = writeRegSel then  -- Bypass for read A
				  outA <= input;
				end if;
				if regBSel = writeRegSel then  -- Bypass for read B
				  outB <= input;
				end if;
			end if;
		end if;
		registers(0) <= x"00000000";  -- Hardwire r0 to 0
	end process;
end Behavioral;