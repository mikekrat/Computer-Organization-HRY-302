----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:06:36 03/28/2022 
-- Design Name: 
-- Module Name:    MUX - Behavioral 
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
use work.MUX_IN_PACK.all; -- package for in array

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--package muxIn_pack is
	--type inMuxType is array (31 downto 0) of std_logic_vector(31 downto 0);
--end muxIn_pack;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX is
	port(	DataInMux: in inMuxType;
			selection: in std_logic_vector(4 downto 0); 
			DataOutMux: out std_logic_vector(31 downto 0));

end MUX;

architecture Behavioral of MUX is

	signal DataOutMux_sig: std_logic_vector(31 downto 0);
	
begin
	
	process(DataInMux, selection, DataOutMux_sig)
	
begin
	
	DataOutMux_sig <= std_logic_vector(DataInMux(to_integer(unsigned(selection))));

	end process;
	
DataOutMux <= DataOutMux_sig after 10 ns;

end Behavioral;

