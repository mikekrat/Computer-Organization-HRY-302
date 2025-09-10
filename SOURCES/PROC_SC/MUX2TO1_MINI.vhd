----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:59:03 04/03/2022 
-- Design Name: 
-- Module Name:    MUX2TO1_MINI - Behavioral 
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

entity MUX2TO1_MINI is
	Port ( DataInMUX0_Mini : in std_logic_vector (4 downto 0);
          DataInMUX1_Mini : in std_logic_vector (4 downto 0);
          selection_Mini : in std_logic;
          DataOutMUX_Mini : out std_logic_vector(4 downto 0));
end MUX2TO1_MINI;

architecture Behavioral of MUX2TO1_MINI is

signal DataOutMUX_Mini_sig: std_logic_vector(4 downto 0);

begin
	process(DataInMUX0_Mini, DataInMUX1_Mini,  selection_Mini)

begin
	
	if(selection_Mini = '1') then
		DataOutMUX_Mini_sig <= DataInMUX1_Mini;
	else
		DataOutMUX_Mini_sig <= DataInMUX0_Mini;	
	end if;
	
	end process;
	
DataOutMUX_Mini <= DataOutMUX_Mini_sig ;


end Behavioral;

