library ieee;
use ieee.std_logic_1164.all;

entity toplevel is
end toplevel;

architecture test of toplevel is
-------------------------------------------------------------------
	component clock is
		port(clk : out std_logic;
			reset : in std_logic);
	end component;
	
	component pcReg is
		port(clk, reset : in std_logic;
		pc_in : in std_logic_vector(31 downto 0);
		pc_out : out std_logic_vector(31 downto 0));
		
	end component;
-------------------------------------------------------------------
	component register_file is
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
	end component;
-------------------------------------------------------------------
	component ALU is 
		port( a,b : in std_logic_vector(31 downto 0);
		ALUfun: in std_logic_vector(3 downto 0); 
		z: out std_logic_vector(31 downto 0)); 
	end component; 
-------------------------------------------------------------------
component decoder is
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
end component; 
-------------------------------------------------------------------
component BTypeSignExtend is
	port ( imm12_7 : in std_logic_vector(4 downto 0);
		imm12_25 : in std_logic_vector(6 downto 0);
		extd : out std_logic_vector(31 downto 0));
end component;
-------------------------------------------------------------------
component plus4 is
	port ( pc : in std_logic_vector(31 downto 0);
		pc_next : out std_logic_vector(31 downto 0));
end component;
-------------------------------------------------------------------
component mux2 is
	port ( sel : in std_logic;
		A : in std_logic_vector(31 downto 0);
		B : in std_logic_vector(31 downto 0);
		X : out std_logic_vector(31 downto 0));
end component;
-------------------------------------------------------------------
component mux2_5 is
	port ( sel : in std_logic;
		A : in std_logic_vector(4 downto 0);
		B : in std_logic_vector(4 downto 0);
		X : out std_logic_vector(4 downto 0));
end component;
-------------------------------------------------------------------
component mux4 is
	port ( sel : in std_logic_vector(1 downto 0);
		A : in std_logic_vector(31 downto 0);
		B : in std_logic_vector(31 downto 0);
		C : in std_logic_vector(31 downto 0);
		D : in std_logic_vector(31 downto 0);
		X : out std_logic_vector(31 downto 0));
end component;
-------------------------------------------------------------------
component jumptarget is 
	port( a: in std_logic_vector (19 downto 0); 
	b: in std_logic_vector (31 downto 0); 
	z:out std_logic_vector (31 downto 0)); 
end component;	 
-------------------------------------------------------------------
component jumpreggen is 
	port (a:in std_logic_vector(31 downto 0); 
	b:in std_logic_vector (31 downto 0);
	z:out std_logic_vector(31 downto 0)); 
	
end component; 
-------------------------------------------------------------------
component branchcond is 
	port ( a:in std_logic_vector (31 downto 0); 
	b:in std_logic_vector (31 downto 0); 
	z:out std_logic; 
	x:out std_logic);
end component; 
-------------------------------------------------------------------
component pc_sel_comb is
	port( br_eq, br_lt : in std_logic;
		pc_sel: in std_logic_vector(1 downto 0);
		funct : in std_logic_vector(2 downto 0);
		pc_sel_final : out std_logic_vector(1 downto 0));
end component;
-------------------------------------------------------------------
component branchtarget is 
	port (a: in std_logic_vector(31 downto 0); 
	b:in std_logic_vector (31 downto 0); 
	z: out std_logic_vector (31 downto 0));
end component; 
-------------------------------------------------------------------
component auipc is 
	port (a: in std_logic_vector (31 downto 0); 
	b: in std_logic_vector (19 downto 0); 
	z:out std_logic_vector (31 downto 0)); 
end component;
-------------------------------------------------------------------
component itypeextend is 
	port (a: in std_logic_vector (11 downto 0);
	z: out std_logic_vector (31 downto 0));
end component; 
-------------------------------------------------------------------
component rom1024x32 is
  port (addr : in std_logic_vector(31 downto 0);
	data : out std_logic_vector(31 downto 0));
end component;
-------------------------------------------------------------------
component dataMem is
  port(
    outA        : out std_logic_vector(31 downto 0);
    input       : in  std_logic_vector(31 downto 0);
    read_write : in  std_logic;
    sel     : in  std_logic_vector(31 downto 0);
    clk, mem_val: in  std_logic
    );
end component;
-------------------------------------------------------------------
	signal clk, reset : std_logic;
	signal pc_plus4,pc,pc_in, rs2, rs1, 
		regFileIn, ALUInA, ALUInB, ALUOut,
		b_extd, i_extd, aui,
		jump, jalr, branch, rdata: std_logic_vector(31 downto 0);
	signal regFile2Sel, regFile1Sel, 
		regFileWriteSel : std_logic_vector(4 downto 0);
-------------------------------------------------------------------
--Decoder Signals
	signal ir : std_logic_vector(31 downto 0);
	signal pc_sel, pc_sel_final, Op2Sel, wb_sel : std_logic_vector(1 downto 0);
	signal vval, Op1Sel, mem_rw, mem_val, wa_sel, rf_wen, br_eq, br_lt : std_logic;
	signal ALUfun : std_logic_vector(3 downto 0);
	signal EOF : std_logic;
--rdata, i_extd, aui 	
begin
	Comb: pc_sel_comb port map(br_eq, br_lt, pc_sel, ir(14 downto 12), pc_sel_final); --Combinational Circuit
	C1: clock port map(clk, reset);									--Clock
	P1: pcReg port map(clk, reset, pc_in, pc);						--PC register
	R1: register_file port map(rs2, rs1, 							--Register File
		regFileIn, rf_wen, 
		ir(24 downto 20), ir(19 downto 15), regFileWriteSel, clk);
	A1: ALU port map(ALUInA, ALUInB, ALUfun, ALUOut);				--ALU
	D1: decoder port map (ir, pc_sel, vval, Op1Sel, Op2Sel, 		--Decoder
			ALUfun, mem_rw, mem_val, wb_sel, wa_sel, rf_wen, EOF);
			
	S1: BTypeSignExtend port map(ir(11 downto 7), 
		ir(31 downto 25), b_extd);									--Btype Sign Extend
	S2: jumptarget port map(ir(31 downto 12), pc, jump);			--Jump TargetGen
	S3: jumpreggen port map(i_extd, rs1, jalr);						--Jump Reg TargetGen
	S4: plus4 port map(pc, pc_plus4);								--Plus 4
	S5: branchcond port map(rs1, rs2, br_eq, br_lt);				--Branch CondGen
	S6: branchtarget port map(b_extd, pc, branch);					--Branch TargetGen
	S7: auipc port map(pc, ir(31 downto 12), aui);					--AUIPC
	S8: itypeextend port map(ir(31 downto 20), i_extd);				--itype sign extend
	
	M1: mux2 port map(Op1Sel, rs1, x"00000000", ALUInA);			--ALU input Mux 1
	M2: mux2_5 port map(wa_sel, ir(11 downto 7), "00001", 			--Write Address Mux 
						regFileWriteSel);							
	M3: mux4 port map(Op2Sel, x"0000000C", b_extd, i_extd, rs2, ALUInB);	--ALU input Mux 2
	M4: mux4 port map(pc_sel_final, pc_plus4, branch, jump, jalr, pc_in);
	M5: mux4 port map(wb_sel, aui, pc_plus4, ALUOut, rdata, regFileIn);
	
	MEM1: rom1024x32 port map(pc, ir);										--instruction memory
	MEM2: dataMem port map(rdata, rs2, mem_rw, ALUOut, clk, mem_val);		--Data memory
	process
	begin
		reset <= '1'; wait for 1 us; reset <= '0';
		wait;
	end process;
end test;