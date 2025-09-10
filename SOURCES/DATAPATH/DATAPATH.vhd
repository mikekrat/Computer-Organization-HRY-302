----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:58:28 04/09/2022 
-- Design Name: 
-- Module Name:    DATAPATH - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DATAPATH is

	port( Reset: in std_logic;
			Clk: in std_logic;
			-- IFSTAGE PORTS
			PC_Sel: in std_logic;
			PC_LdEn: in std_logic;
			PC: out std_logic_vector(31 downto 0);
			-- DECSTAGE PORTS
			Immext: in std_logic_vector(1 downto 0);
			Instr: in std_logic_vector(31 downto 0);
			RF_WrEn: in std_logic;
			RF_B_Sel: in std_logic;
			RF_WrData_sel: in std_logic;
			-- EXSTAGE PORTS
			ALU_Bin_Sel: in std_logic;
			ALU_func: in std_logic_vector(3 downto 0);
			ALU_zero: out std_logic; 
			ALU_overflow: out std_logic;
			-- MEMSTAGE PORTS
			ByteOp: in std_logic;
			MEM_WrEn: in std_logic;
			MM_WrEn: out std_logic;
			MM_Addr: out std_logic_vector(31 downto 0);
			MM_WrData: out std_logic_vector(31 downto 0);
			MM_RdData: in std_logic_vector(31 downto 0));
			
end DATAPATH;

architecture Behavioral of DATAPATH is

	component IFSTAGE is
	
		port ( PC_Immed: in std_logic_vector(31 downto 0);
				 PC_sel: in std_logic;
				 PC_LdEn: in std_logic;
				 Reset: in std_logic;
				 Clk: in std_logic;
				 PC: out std_logic_vector(31 downto 0));
				 
	end component;
	
	component DECSTAGE is

		port( Instr: in std_logic_vector(31 downto 0);
				RF_WrEn: in std_logic;
				ALU_out: in std_logic_vector(31 downto 0);
				MEM_out: in std_logic_vector(31 downto 0);
				RF_WrData_sel: in std_logic;
				RF_B_sel: in std_logic;
				ImmExt: in std_logic_vector(1 downto 0);
				Clk: in std_logic;
				Rst: in std_logic;
				Immed: out std_logic_vector(31 downto 0);
				RF_A: out std_logic_vector(31 downto 0);
				RF_B: out std_logic_vector(31 downto 0));
				
	end component;
	
	component EXSTAGE is
	
		port( RF_A: in std_logic_vector(31 downto 0);
				RF_B: in std_logic_vector(31 downto 0);
				Immed: in std_logic_vector(31 downto 0);
				ALU_Bin_sel: in std_logic;
				ALU_func: in std_logic_vector(3 downto 0);
				ALU_out: out std_logic_vector(31 downto 0);
				ALU_zero: out std_logic;
				ALU_overflow: out std_logic);
		
	end component;
	
	component MEMSTAGE is
		
		port( ByteOp: in std_logic;
				Mem_WrEn: in std_logic;
				ALU_MEM_Addr: in std_logic_vector(31 downto 0);
				MEM_DataIn: in std_logic_vector(31 downto 0);
				MEM_DataOut: out std_logic_vector(31 downto 0);
				MM_WrEn: out std_logic;
				MM_Addr: out std_logic_vector(31 downto 0);
				MM_WrData: out std_logic_vector(31 downto 0);
				MM_RdData: in std_logic_vector(31 downto 0));
			
	end component;
	
	signal RF_A_sig: std_logic_vector(31 downto 0);
	signal RF_B_sig: std_logic_vector(31 downto 0);
	
	signal Immed_sig: std_logic_vector(31 downto 0);
	
	signal ALU_out_sig: std_logic_vector(31 downto 0);
	signal MEM_out_sig : std_logic_vector(31 downto 0);
	
begin

	IF_Stage:
		IFSTAGE port map(	PC_Immed => Immed_sig,
								PC_sel => PC_Sel,
								PC_LdEn => PC_LdEn,
								Reset => Reset,
								Clk => Clk,
								PC => PC);
								
	
	DEC_Stage:
		DECSTAGE port map( Instr => Instr,
								 RF_WrEn => RF_WrEn,
								 ALU_out => ALU_out_sig,
								 MEM_out => MEM_out_sig,
								 RF_WrData_sel => RF_WrData_sel,
								 RF_B_sel => RF_B_Sel,
								 ImmExt => Immext,
								 Clk => Clk,
								 Rst => Reset,
								 Immed => Immed_sig,
								 RF_A => RF_A_sig,
								 RF_B => RF_B_sig);
								 
	EX_Stage:
		EXSTAGE port map( RF_A => RF_A_sig,
							   RF_B => RF_B_sig,
							   Immed => Immed_sig,
							   ALU_Bin_sel => ALU_Bin_Sel,
							   ALU_func => ALU_func,
							   ALU_out => ALU_out_sig,
							   ALU_zero => ALU_zero,
							   ALU_overflow => ALU_overflow);
	
	MEM_Stage:
		MEMSTAGE port map( ByteOp => ByteOp,
								 Mem_WrEn => Mem_WrEn,
								 ALU_MEM_Addr => ALU_out_sig,
								 MEM_DataIn => RF_B_sig,
								 MEM_DataOut => MEM_out_sig,
								 MM_WrEn => MM_WrEn,
								 MM_Addr => MM_Addr,
								 MM_WrData => MM_WrData, 
								 MM_RdData => MM_RdData);
								

end Behavioral;

