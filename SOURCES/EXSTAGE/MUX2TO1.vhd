----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:07:10 04/03/2022 
-- Design Name: 
-- Module Name:    MUX2TO1 - Behavioral 
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

entity MUX2TO1 is
	Port ( DataInMUX0 : in std_logic_vector(31 downto 0);
          DataInMUX1 : in std_logic_vector(31 downto 0);
          selection : in std_logic;
          DataOutMUX : out std_logic_vector(31 downto 0));
end MUX2TO1;

architecture Behavioral of MUX2TO1 is

signal DataOutMUX_sig: std_logic_vector(31 downto 0);

begin
	process(DataInMUX0, DataInMUX1,  selection)

begin
	
	if(selection = '1') then
		DataOutMUX_sig <= DataInMUX1;
	else
		DataOutMUX_sig <= DataInMUX0;	
	end if;
	
	end process;
	
DataOutMUX <= DataOutMUX_sig ;

end Behavioral;

