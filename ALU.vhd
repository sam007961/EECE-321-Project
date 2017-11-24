library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is 
	port( a,b : in std_logic_vector(31 downto 0);
		ALUfun: in std_logic_vector(3 downto 0); 
		z: out std_logic_vector(31 downto 0)); 
end ALU; 

architecture alu_body of ALU is 
begin 
	process (a,b,ALUfun) is
	variable temp : std_logic_vector(63 downto 0);
	begin 

		case ALUfun is 
			when "0110" => 
				z <= a and b; --AND
			when "0101" =>
				z <= a or b; --OR
			when "0000" => 
				z <= std_logic_vector(signed(a) + signed(b)); --ADD
			when "1001"=> 
				z <= To_StdLogicVector(to_bitvector(a) sra to_integer(unsigned(b))); --SRA
			when "0111"=>
				z <= To_StdLogicVector(to_bitvector(a) sll to_integer(unsigned(b))); --SLL
			when "1000" =>
				z <= To_StdLogicVector(to_bitvector(a) srl to_integer(unsigned(b))); --SRL
			when "0001" => 
				z <= std_logic_vector(signed(a) - signed(b)); --SUB
			when "0010" => 
				temp := std_logic_vector(signed(a) * signed(b)); --MULL
				z <= temp(31 downto 0);
			when "0011" => 
				temp := std_logic_vector(signed(a) * signed(b));  --MULU
				z <= temp(63 downto 32);
			when "0100" => 
				z <= a xor b; --XOR
			when "1010" =>
				if signed(a) < signed(b) then 
					z <= x"00000001";
				else
					z <= x"00000000"; --SLT
				end if;
			when others =>
				z <= (others => 'U'); 
		end case; 
	end process; 
end alu_body;
  


