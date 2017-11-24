library ieee; 
use ieee.std_logic_1164.all;


entity decoder is 
    port ( ir : in std_logic_vector (31 downto 0); 
        pc_sel : out std_logic_vector(1 downto 0); 
        vval : out std_logic; 
        Op1Sel : out std_logic; 
        Op2Sel : out std_logic_vector (1 downto 0); 
        ALUfun: out std_logic_vector (3 downto 0); 
        mem_rw : out std_logic; 
        mem_val : out std_logic; 
        wb_sel : out std_logic_vector (1 downto 0); 
        wa_sel : out std_logic; 
        rf_wen : out std_logic;
		eof : out std_logic);  
end decoder; 

architecture decoder_body of decoder is 
begin
	--eof
	eof <= '1' when (ir = x"00000000") else '0';	--End of File
	--val
	vval <= '1';	--Enable Instruction Memory
	--pc_sel
	pc_sel <= "01" when (ir(6 downto 0) = "1100011") else			--Branch
		      "10" when (ir(6 downto 0) = "1101111") else			--Jump
		      "10" when (ir(6 downto 0) = "1100111") else			--JALR
		      "00";													--Other 
	--Op1Sel		
	Op1Sel <= '1';													--all instructions that use alu use rs1
			
	--Op2Sel		
	Op2sel <= "00" when (ir(6 downto 0) = "0110111" or		
						 ir(6 downto 0) = "0010111") else 			--Shifts by 12
		      "01" when (ir(6 downto 0) = "1100011" or 
						 ir(6 downto 0) = "0100011") else			--Branch or SW
		      "10" when (ir(6 downto 0) = "0010011" or		
						 ir(6 downto 0) = "1100111") else			--I-Type
		      "11";
	--ALUfun
	ALUfun <= "0001" when ((ir(31 downto 25) & ir(14 downto 12) = "0100000000") and
							ir(6 downto 0) = "0110011") else	--Subtraction
		      "0010" when ((ir(31 downto 25) & ir(14 downto 12) = "0000001000")) else	--Multiply Low
		      "0010" when ((ir(31 downto 25) & ir(14 downto 12) = "0000001001")) else	--Multiply High
		      "1001" when ((ir(31 downto 25) & ir(14 downto 12) = "0000000101")) else	--SRA
		      "0000" when ((ir(14 downto 12) = "000") or
						   (ir(14 downto 12) & ir(6 downto 0) = "0100000011" or
						   (ir(14 downto 12) & ir(6 downto 0) = "0100100011"))) else		--Add (ADD, SW and LW)
		      "0111" when ((ir(14 downto 12) = "001")) else			--SLL
		      "1000" when ((ir(14 downto 12) = "101")) else			--SRL
		      "0100" when ((ir(14 downto 12) = "100")) else			--XOR
		      "0101" when ((ir(14 downto 12) = "110")) else			--OR
		      "0110" when ((ir(14 downto 12) = "111")) else			--SRL
		      "1010" when ((ir(14 downto 12) = "010")) else			--SLT
			  "1111";
	--mem_rw
	mem_rw <= '1' when (ir(6 downto 0) = "0000011") else			--Load Word
		      '0';				--Store Word or other functions
	--mem_val
	mem_val <= '1' when (ir(6 downto 0) = "0000011" or
						 ir(6 downto 0) = "0100011") else			--Loads and Stores
			   '0';
	--wb_sel
	wb_sel <= "01" when (ir(6 downto 0) = "1101111" or
						 ir(6 downto 0) = "1100111") else			--Jumps
		      "11" when (ir(6 downto 0) = "0000011") else 			--Load Word
		      "00" when (ir(6 downto 0) = "0010111") else			--AUIPC
		      "10";													--ALU
	--wa_sel
	wa_sel <= '1';													--always write back to rd
	--rf_wen
	rf_wen <= '0' when (ir(6 downto 0) = "0100011" or
						ir(6 downto 0) = "1100011") else
			  '1';
end decoder_body;	  
