----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:39:53 04/03/2022 
-- Design Name: 
-- Module Name:    ADDER_INC_AND_IMMED - Behavioral 
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
use ieee.std_logic_signed.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ADDER_INC_AND_IMMED is

	port( DataInInc: in std_logic_vector(31 downto 0);
		   PC_Immed: in std_logic_vector(31 downto 0);
			DataOutInc_Immed: out std_logic_vector(31 downto 0));
			
end ADDER_INC_AND_IMMED;

architecture Behavioral of ADDER_INC_AND_IMMED is

begin

	DataOutInc_Immed <= DataInInc + PC_Immed + PC_Immed + PC_Immed + PC_Immed;

end Behavioral;

