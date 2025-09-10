----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:16:07 04/10/2022 
-- Design Name: 
-- Module Name:    IFSTAGE_TOPMODULE - Behavioral 
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

entity IFSTAGE_TOPMODULE is

		port ( PC_Immed: in std_logic_vector(31 downto 0);
				 PC_sel: in std_logic;
				 PC_LdEn: in std_logic;
				 Reset: in std_logic;
				 Clk: in std_logic;
				 Instr: out std_logic_vector(31 downto 0));
				 
end IFSTAGE_TOPMODULE;

architecture Behavioral of IFSTAGE_TOPMODULE is

	component IFSTAGE is
		port ( PC_Immed: in std_logic_vector(31 downto 0);
				 PC_sel: in std_logic;
				 PC_LdEn: in std_logic;
				 Reset: in std_logic;
				 Clk: in std_logic;
				 PC: out std_logic_vector(31 downto 0));
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
	
signal PC_sig: std_logic_vector(31 downto 0);

begin

	IF_Stg:
			IFSTAGE port map( PC_Immed => PC_Immed,
									PC_sel => PC_sel,
									PC_LdEn => PC_LdEn,
									Reset => Reset,
									Clk => Clk,
									PC => PC_sig);
	MEM:
			RAM port map( clk => Clk,
							  inst_addr => PC_sig(12 downto 2), -- ignoring 2 lsbits
							  inst_dout => Instr,
							  data_we => '0', -- not used
							  data_addr => "00000000000", --
							  data_din => x"00000000", --
							  data_dout => open); --


end Behavioral;

