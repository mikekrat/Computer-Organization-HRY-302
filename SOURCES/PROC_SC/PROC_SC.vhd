----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:22:47 04/11/2022 
-- Design Name: 
-- Module Name:    PROC_SC - Behavioral 
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

entity PROC_SC is

	port( Clock: in std_logic;
			Reset: in std_logic);
			
end PROC_SC;

architecture Behavioral of PROC_SC is

	component DATAPATH is

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
				
	end component;
	
	component CONTROL is

		port( Reset: in std_logic;
				Instr: in std_logic_vector(31 downto 0);
				ALU_overflow: in std_logic;
				ALU_zero: in std_logic;
				PC_Sel: out std_logic;
				PC_LdEn: out std_logic;
				Immext: out std_logic_vector(1 downto 0);
				RF_WrEn: out std_logic;
				RF_B_Sel: out std_logic;
				RF_WrData_sel: out std_logic;
				ALU_Bin_sel: out std_logic;
				ALU_func: out std_logic_vector(3 downto 0);
				ByteOp: out std_logic;
				MEM_WrEn: out std_logic);
				
	end component;
	
	component RAM is

		 port ( clk : in std_logic;
				  inst_addr : in std_logic_vector(10 downto 0);
				  inst_dout : out std_logic_vector(31 downto 0);
				  data_we : in std_logic;
				  data_addr : in std_logic_vector(10 downto 0);
				  data_din : in std_logic_vector(31 downto 0);
				  data_dout : out std_logic_vector(31 downto 0));

	end component;
	
signal instr_dout_sig: std_logic_vector(31 downto 0);
signal ALU_overflow_sig: std_logic;
signal ALU_zero_sig: std_logic;
signal PC_Sel_sig: std_logic;
signal PC_LdEn_sig: std_logic;
signal ImmExt_sig: std_logic_vector(1 downto 0);
signal RF_WrEn_sig: std_logic;
signal RF_B_Sel_sig: std_logic;
signal RF_WrData_sel_sig: std_logic;
signal ALU_Bin_sel_sig: std_logic;
signal ALU_func_sig: std_logic_vector(3 downto 0);
signal ByteOp_sig: std_logic;
signal MEM_WrEn_sig: std_logic;
signal PC_sig: std_logic_vector(31 downto 0);
signal MM_WrEn_sig: std_logic;
signal MM_Addr_sig: std_logic_vector(31 downto 0);
signal MM_WrData_sig: std_logic_vector(31 downto 0);
signal data_dout_sig: std_logic_vector(31 downto 0);


begin

	Control_part:
			CONTROL port map( Reset => Reset,
									Instr => instr_dout_sig,
									ALU_overflow => ALU_overflow_sig,
									ALU_zero => ALU_zero_sig,
									PC_Sel => PC_Sel_sig,
									PC_LdEn => PC_LdEn_sig,
									Immext => ImmExt_sig,
									RF_WrEn => RF_WrEn_sig,
									RF_B_Sel => RF_B_Sel_sig,
									RF_WrData_sel => RF_WrData_sel_sig,
									ALU_Bin_sel => ALU_Bin_sel_sig,
									ALU_func => ALU_func_sig,
									ByteOp => ByteOp_sig,
									MEM_WrEn => MEM_WrEn_sig);

	Datapath_part:
			DATAPATH port map( Reset => Reset,
									 Clk => Clock,
									 PC_Sel => PC_Sel_sig,
									 PC_LdEn => PC_LdEn_sig,
									 PC => PC_sig, --
									 Immext => ImmExt_sig,
									 Instr => instr_dout_sig,
									 RF_WrEn => RF_WrEn_sig,
									 RF_B_Sel => RF_B_Sel_sig,
									 RF_WrData_sel => RF_WrData_sel_sig,
									 ALU_Bin_Sel => ALU_Bin_sel_sig,
									 ALU_func => ALU_func_sig,
									 ALU_zero => ALU_zero_sig,
									 ALU_overflow => ALU_overflow_sig,
									 ByteOp => ByteOp_sig,
									 MEM_WrEn => MEM_WrEn_sig,
									 MM_WrEn => MM_WrEn_sig,
									 MM_Addr => MM_Addr_sig,
									 MM_WrData => MM_WrData_sig,
									 MM_RdData => data_dout_sig);
	
	MEM_RAM_part:
			RAM port map( clk => Clock,
							  inst_addr => PC_sig(12 downto 2),
							  inst_dout => instr_dout_sig,
							  data_we => MM_WrEn_sig,
							  data_addr => MM_Addr_sig(12 downto 2),
							  data_din => MM_WrData_sig,
							  data_dout => data_dout_sig);
	
end Behavioral;

