----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:37:03 04/03/2022 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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

entity IFSTAGE is
	port ( PC_Immed: in std_logic_vector(31 downto 0);
			 PC_sel: in std_logic;
			 PC_LdEn: in std_logic;
			 Reset: in std_logic;
			 Clk: in std_logic;
			 PC: out std_logic_vector(31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is

component REGISTR is

	port(	DataInREG: in std_logic_vector(31 downto 0);
			CLK: in std_logic;
			RST: in std_logic;
			WE: in std_logic;
			DataOutREG: out std_logic_vector(31 downto 0));
			
end component;

component ADDER_INCREMENTOR is

	port( DataInINC: in std_logic_vector(31 downto 0);
			DataOutINC: out std_logic_vector(31 downto 0));

end component;

component ADDER_INC_AND_IMMED is

	port( DataInInc: in std_logic_vector(31 downto 0);
		   PC_Immed: in std_logic_vector(31 downto 0);
			DataOutInc_Immed: out std_logic_vector(31 downto 0));

end component;

component MUX2TO1 is

    port ( DataInMUX0: in std_logic_vector(31 downto 0);
           DataInMUX1: in std_logic_vector(31 downto 0);
           selection: in std_logic;
           DataOutMUX: out std_logic_vector(31 downto 0));
			  
end component;

signal PC_IN_sig: std_logic_vector(31 downto 0);
signal PC_OUT_sig: std_logic_vector(31 downto 0);
signal DataOutINC_sig: std_logic_vector(31 downto 0);
signal DataOutInc_Immed_sig: std_logic_vector(31 downto 0);

begin

	PC_REG: 
		REGISTR port map( DataInREG => PC_IN_sig,
							   CLK => Clk,
								RST => Reset,
								WE => PC_LdEn,
								DataOutREG => PC_OUT_sig);
								
	Adder_inc:
		ADDER_INCREMENTOR port map( DataInINC => PC_OUT_sig,
											 DataOutINC => DataOutINC_sig);
	
	Adder_inc_immed:
		ADDER_INC_AND_IMMED port map( DataInInc => DataOutINC_sig,
												PC_Immed => PC_Immed,
												DataOutInc_Immed => DataOutInc_Immed_sig);
	

	Multiplexer_2X1_A:
		MUX2TO1 port map( DataInMUX0 => DataOutINC_sig,
								DataInMUX1 => DataOutInc_Immed_sig,
								selection => PC_sel,
								DataOutMUX => PC_IN_sig);
	
	PC <= PC_OUT_sig;

end Behavioral;

