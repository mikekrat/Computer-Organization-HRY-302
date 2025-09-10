----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:46:09 04/10/2022 
-- Design Name: 
-- Module Name:    MEMSTAGE_TOPMODULE - Behavioral 
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

entity MEMSTAGE_TOPMODULE is
	
	port( ByteOp: in std_logic;
			Mem_WrEn: in std_logic;
			ALU_MEM_Addr: in std_logic_vector(31 downto 0);
			MEM_DataIn: in std_logic_vector(31 downto 0);
			MEM_DataOut: out std_logic_vector(31 downto 0);
			Clk: in std_logic);
			
end MEMSTAGE_TOPMODULE;

architecture Behavioral of MEMSTAGE_TOPMODULE is

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

	component RAM is

		 port ( clk : in std_logic;
				  inst_addr : in std_logic_vector(10 downto 0);
				  inst_dout : out std_logic_vector(31 downto 0);
				  data_we : in std_logic;
				  data_addr : in std_logic_vector(10 downto 0);
				  data_din : in std_logic_vector(31 downto 0);
				  data_dout : out std_logic_vector(31 downto 0));

	end component;
	
signal MM_WrEn_sig: std_logic;
signal MM_Addr_sig: std_logic_vector(31 downto 0);
signal MM_WrData_sig: std_logic_vector(31 downto 0);
signal MM_RdData_sig: std_logic_vector(31 downto 0);

begin

	MEM_Stg:
			MEMSTAGE port map( ByteOp => ByteOp,
									 Mem_WrEn => Mem_WrEn,
									 ALU_MEM_Addr => ALU_MEM_Addr,
									 MEM_DataIn => MEM_DataIn,
									 MEM_DataOut => MEM_DataOut,
									 MM_WrEn => MM_WrEn_sig,
									 MM_Addr => MM_Addr_sig,
									 MM_WrData => MM_WrData_sig,
									 MM_RdData => MM_RdData_sig);
	
	MEM_2:
			RAM port map( clk => Clk,
							  inst_addr => "00000000000", -- not used
							  inst_dout => open, --
							  data_we => MM_WrEn_sig,
							  data_addr => MM_Addr_sig(12 downto 2), -- ignoring 2 lsbits
							  data_din => MM_WrData_sig,
							  data_dout => MM_RdData_sig);

end Behavioral;

