----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:20:29 04/03/2022 
-- Design Name: 
-- Module Name:    CLOUD_UNIT - Behavioral 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CLOUD_UNIT is
	port( DataInCloud: in std_logic_vector(15 downto 0);
			ImmExt: in std_logic_vector(1 downto 0); -- opcode
			Immed: out std_logic_vector(31 downto 0));
end CLOUD_UNIT;

architecture Behavioral of CLOUD_UNIT is

signal Immed_sig: std_logic_vector(31 downto 0);

begin
	process(DataInCloud, ImmExt)
begin
	
		case ImmExt is
			
			-- zero-filling
			when "00" => 
				Immed_sig(31 downto 16) <= "0000000000000000";
				Immed_sig(15 downto 0) <= DataInCloud(15 downto 0);
			
			-- zero-filling and 16 left shifts
			when "01" => 
				Immed_sig(31 downto 16) <= DataInCloud(15 downto 0);
				Immed_sig(15 downto 0) <= "0000000000000000";
			
			-- sign-extend
			when "10" => 
				Immed_sig <= std_logic_vector(resize(signed(DataInCloud(15 downto 0)),32));
				
			-- sign-extend and 2 left shifts
			when "11" => 
				Immed_sig(31 downto 0) <= std_logic_vector(resize(signed(DataInCloud(15 downto 0)),32));
				Immed_sig(17 downto 2) <= Immed_sig(15 downto 0);
				Immed_sig(1 downto 0) <= "00";
				
			when others =>
				null;
				
		end case;
		
	end process;
	
	Immed <= Immed_sig;

end Behavioral;

