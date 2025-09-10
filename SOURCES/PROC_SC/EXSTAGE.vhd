----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:19:45 04/05/2022 
-- Design Name: 
-- Module Name:    EXSTAGE - Behavioral 
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

entity EXSTAGE is
	
	port( RF_A: in std_logic_vector(31 downto 0);
			RF_B: in std_logic_vector(31 downto 0);
			Immed: in std_logic_vector(31 downto 0);
			ALU_Bin_sel: in std_logic;
			ALU_func: in std_logic_vector(3 downto 0);
			ALU_out: out std_logic_vector(31 downto 0);
			ALU_zero: out std_logic;
			ALU_overflow: out std_logic);
	
end EXSTAGE;

architecture Behavioral of EXSTAGE is

component ALU is
	port(	A: in std_logic_vector(31 downto 0);
			B: in std_logic_vector(31 downto 0);
			Op: in std_logic_vector(3 downto 0);
			Out1: out std_logic_vector(31 downto 0);
			Zero: out std_logic;
			Cout: out std_logic;
			Ovf: out std_logic);
end component;

component MUX2TO1 is

	Port ( DataInMUX0 : in std_logic_vector(31 downto 0);
          DataInMUX1 : in std_logic_vector(31 downto 0);
          selection : in std_logic;
          DataOutMUX : out std_logic_vector(31 downto 0));

end component;

signal DataOutMUX_sig: std_logic_vector (31 downto 0);

begin
	
	Multiplexer_2x1_EX:
			MUX2TO1 port map( DataInMUX0 => RF_B,
									 DataInMUX1 => Immed,
									 selection => ALU_Bin_sel,
									 DataOutMUX => DataOutMUX_sig);
	
	Alu_unit:
			ALU port map( A => RF_A,
							  B => DataOutMUX_sig,
							  Op => ALU_func,
							  Out1 => ALU_out,
							  Zero => ALU_zero,
							  Cout => open,
							  Ovf => ALU_overflow);

end Behavioral;

