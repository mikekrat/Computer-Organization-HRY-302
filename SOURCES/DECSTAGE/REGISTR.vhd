----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:33:57 03/26/2022 
-- Design Name: 
-- Module Name:    REGISTR - Behavioral 
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

entity REGISTR is
	port(	DataInREG: in std_logic_vector(31 downto 0);
			CLK: in std_logic;
			RST: in std_logic;
			WE: in std_logic;
			DataOutREG: out std_logic_vector(31 downto 0));
end REGISTR;

architecture Behavioral of REGISTR is

signal DataOut_sig: std_logic_vector(31 downto 0);

begin
	process
	
	begin
		wait until CLK'EVENT AND CLK='1';
		
		if RST = '1' then
			DataOut_sig <= "00000000000000000000000000000000";
			
		else		
			if WE = '0' then
				DataOut_sig <= DataOut_sig;				
			else
				DataOut_sig <= DataInREG;				
			end if;
					
		end if;
		
	end process;

DataOutREG <= DataOut_sig after 10 ns;

end Behavioral;

