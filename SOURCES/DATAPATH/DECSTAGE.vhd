----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:17:00 04/03/2022 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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

entity DECSTAGE is

	port( Instr: in std_logic_vector(31 downto 0);
			RF_WrEn: in std_logic;
			ALU_out: in std_logic_vector(31 downto 0);
			MEM_out: in std_logic_vector(31 downto 0);
			RF_WrData_sel: in std_logic;
			RF_B_sel: in std_logic;
			ImmExt: in std_logic_vector(1 downto 0);
			Clk: in std_logic;
			Rst: in std_logic;
			Immed: out std_logic_vector(31 downto 0);
			RF_A: out std_logic_vector(31 downto 0);
			RF_B: out std_logic_vector(31 downto 0));
			
end DECSTAGE;

architecture Behavioral of DECSTAGE is

component RF is

	port( Ard1: in std_logic_vector(4 downto 0);
			Ard2: in std_logic_vector(4 downto 0);
			Awr: in std_logic_vector(4 downto 0);
			Dout1: out std_logic_vector(31 downto 0);
			Dout2: out std_logic_vector(31 downto 0);
			Din: in std_logic_vector(31 downto 0);
			WrEn: in std_logic;
			Clk: in std_logic;
			Rst: in std_logic);

end component;

component MUX2TO1 is

    port ( DataInMUX0: in std_logic_vector(31 downto 0);
           DataInMUX1: in std_logic_vector(31 downto 0);
           selection: in std_logic;
           DataOutMUX: out std_logic_vector(31 downto 0));
			  
end component;

component MUX2TO1_MINI is

	port ( DataInMUX0_Mini : in std_logic_vector (4 downto 0);
          DataInMUX1_Mini : in std_logic_vector (4 downto 0);
          selection_Mini : in std_logic;
          DataOutMUX_Mini : out std_logic_vector(4 downto 0));
			 
end component;

component CLOUD_UNIT is
	
	port( DataInCloud: in std_logic_vector(15 downto 0);
			ImmExt: in std_logic_vector(1 downto 0); -- opcode
			Immed: out std_logic_vector(31 downto 0));

end component;

signal DataOutMUX_sig: std_logic_vector(31 downto 0);
signal DataOutMUX_Mini_sig: std_logic_vector(4 downto 0);


begin

	Multiplexer_2x1:
			MUX2TO1 port map( DataInMUX0 => ALU_out,
									DataInMUX1 => MEM_out,
									selection => RF_WrData_sel,
									DataOutMUX => DataOutMUX_sig);

	Multiplexer_2x1_mini:
			MUX2TO1_MINI port map( DataInMUX0_Mini => Instr(15 downto 11),
										  DataInMUX1_Mini => Instr(20 downto 16),
										  selection_Mini => RF_B_sel,
										  DataOutMUX_Mini => DataOutMUX_Mini_sig);
	
	Reg_File:
			RF port map( Ard1 => Instr(25 downto 21),
							 Ard2 => DataOutMUX_Mini_sig,
							 Awr => Instr(20 downto 16),
							 Dout1 => RF_A,
							 Dout2 => RF_B,
							 Din => DataOutMUX_sig,
							 WrEn => RF_WrEn,
							 Clk => Clk,
							 Rst => Rst);
	
	Cloud:
			CLOUD_UNIT port map( DataInCloud => Instr(15 downto 0),
										 ImmExt => ImmExt,
										 Immed => Immed);
	
end Behavioral;

