----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:34:18 04/05/2022 
-- Design Name: 
-- Module Name:    MEMSTAGE - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEMSTAGE is
		
	port( ByteOp: in std_logic;
			Mem_WrEn: in std_logic;
			ALU_MEM_Addr: in std_logic_vector(31 downto 0);
			MEM_DataIn: in std_logic_vector(31 downto 0);
			MEM_DataOut: out std_logic_vector(31 downto 0);
			MM_WrEn: out std_logic;
			MM_Addr: out std_logic_vector(31 downto 0);
			MM_WrData: out std_logic_vector(31 downto 0);
			MM_RdData: in std_logic_vector(31 downto 0));
		
end MEMSTAGE;

architecture Behavioral of MEMSTAGE is

signal MEM_DataOut_sig: std_logic_vector(31 downto 0);
signal MM_WrEn_sig: std_logic; 
signal MM_Addr_sig: std_logic_vector(31 downto 0);
signal MM_WrData_sig: std_logic_vector(31 downto 0);

begin

	process(ByteOp, Mem_WrEn, ALU_MEM_Addr, MEM_DataIn, MM_RdData,
	MEM_DataOut_sig, MM_WrEn_sig, MM_Addr_sig, MM_WrData_sig)

begin
		
		MM_WrEn_sig <= Mem_WrEn;
		MM_Addr_sig <= ALU_MEM_Addr + x"00000400"; -- setting offset
		
		if ByteOp = '0' then
			-- lw
			MEM_DataOut_sig <= MM_RdData;
			-- sw
			MM_WrData_sig <= MEM_DataIn; 
			
		else
			-- lb
			MEM_DataOut_sig <= x"000000" & MM_RdData(7 downto 0);
			-- sb
			MM_WrData_sig <= x"000000" & MEM_DataIn(7 downto 0); 
			
		end if;
		
		MEM_DataOut <= MEM_DataOut_sig ;
		MM_WrEn <= MM_WrEn_sig ;
		MM_Addr <= MM_Addr_sig ;
		MM_WrData <= MM_WrData_sig ;
		
	end process;


end Behavioral;

