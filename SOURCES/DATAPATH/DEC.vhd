----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:56:14 03/28/2022 
-- Design Name: 
-- Module Name:    DEC - Behavioral 
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

use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DEC is
	port( Awr: in std_logic_vector(4 downto 0);
			WrEn: in std_logic;
			DataOutDEC: out std_logic_vector(31 downto 0));

end DEC;

architecture Behavioral of DEC is

	signal DataOutDEC_sig: std_logic_vector(31 downto 0);
	
begin	
	
	DataOutDEC_sig(0) <= '0' after 2 ns; -- For R0
			
	Decode_operation: 
			for j in 1 to 31 generate	
			
					DataOutDEC_sig(j) <= WrEn when to_integer(unsigned(Awr)) = j  else '0' after 2 ns;
					
					
			end generate Decode_operation;

DataOutDEC <= DataOutDEC_sig after 10 ns;

end Behavioral;

