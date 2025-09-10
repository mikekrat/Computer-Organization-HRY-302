----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:28:24 03/28/2022 
-- Design Name: 
-- Module Name:    RF - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RF is
	port( Ard1: in std_logic_vector(4 downto 0);
			Ard2: in std_logic_vector(4 downto 0);
			Awr: in std_logic_vector(4 downto 0);
			Dout1: out std_logic_vector(31 downto 0);
			Dout2: out std_logic_vector(31 downto 0);
			Din: in std_logic_vector(31 downto 0);
			WrEn: in std_logic;
			Clk: in std_logic;
			Rst: in std_logic);

end RF;

architecture Behavioral of RF is
	
	COMPONENT DEC
		port( Awr: in std_logic_vector(4 downto 0);
				WrEn: in std_logic;
				DataOutDEC: out std_logic_vector(31 downto 0));
	END COMPONENT;
	
	COMPONENT REGISTR
		port(	DataInREG: in std_logic_vector(31 downto 0);
				CLK: in std_logic;
				RST: in std_logic;
				WE: in std_logic;
				DataOutREG: out std_logic_vector(31 downto 0));
	END COMPONENT;

	COMPONENT MUX
		port(	DataInMux: in inMuxType;
				selection: in std_logic_vector(4 downto 0); 
				DataOutMux: out std_logic_vector(31 downto 0));
	END COMPONENT;

	signal DataOutDEC_sig: std_logic_vector(31 downto 0);
	signal WrEn_and_DataOutDEC_sig: std_logic_vector(31 downto 0);
	signal DataOutREG_sig: inMuxType;

begin

-- Decoder's mapping
	Decoder:
		DEC port map( Awr => Awr,
						  WrEn => WrEn,
						  DataOutDEC => DataOutDEC_sig);

-- Registers' generator & mapping

	Registers:
		for j in 0 to 31 generate
			REGISTRX: REGISTR port map( DataInREG => Din,
												 CLK => Clk,
												 RST => Rst,
												 WE => DataOutDEC_sig(j),
												 DataOutREG => DataOutREG_sig(j));
		end generate Registers;

-- Multiplexers' mapping

	MultiplexerA:
		MUX port map( DataInMux => DataOutREG_sig,
						  selection => Ard1,
						  DataOutMux => Dout1);
	
	MultiplexerB:
		MUX port map( DataInMux => DataOutREG_sig,
						  selection => Ard2,
						  DataOutMux => Dout2);
	

end Behavioral;

