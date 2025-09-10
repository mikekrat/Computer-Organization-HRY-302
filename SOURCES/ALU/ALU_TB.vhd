--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:36:20 03/26/2022
-- Design Name:   
-- Module Name:   C:/Users/Mike/Xilinx_projects/comp_org_project1/ALU_TB.vhd
-- Project Name:  comp_org_project1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ALU_TB IS
END ALU_TB;
 
ARCHITECTURE behavior OF ALU_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         Out1 : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Out1 : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
   
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Out1 => Out1,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );
	
	 -- Stimulus process
	stim_proc: process
	begin
		
		Op <= "0000";
		
		-- checking adding and overflow
		A <= "11100000000000010100000001000000";
		B <= "10000000000000001100000001000000";
		wait for 100 ns;
		
		A <= "11111111110101000000000111000000";
		B <= "11001111111111111111100011111111";
		wait for 100 ns;
		
		-- checking subtraction
		Op <= "0001";
		
		A <= "11110000101100000101000100000000";
		B <= "11010000000100110010000110101000";
		wait for 100 ns;
		
		-- and overflow
		A <= "01111111111111111111111111111111";
		B <= "11111111111111111111111111111110";
		wait for 100 ns;
		
		A <= "10000000000000000000000000000000";
		B <= "00000000000000000000000000000001";
		wait for 100 ns;
		
		-- checking AND
		Op <= "0010";
		
		A <= "00000111111001001010100100111000";
		B <= "01001101101101101111111111101100";
		wait for 100 ns;
		
		-- checking zero
		A <= "00000111111001001010100100111000";
		B <= "00110000000100010000011001000100";
		wait for 100 ns;
		
		--checking OR
		Op <= "0011";
		
		A <= "11000111101010011010100111010111";
		B <= "10010011000001001000001010001001";
		wait for 100 ns;
		
		-- CHECKING NOT
		Op <= "0100";
		
		-- CHECKING NAND
		Op <= "0010";
		
		A <= "00000111111001001010100100111000";
		B <= "01001101101101101111111111101100";
		wait for 100 ns;
		
		-- CHECKING NOR
		Op <= "0110";
		
		A <= "11000111101010011010100111010111";
		B <= "10010011000001001000001010001001";
		wait for 100 ns;
		
		-- checking ARITHMETIC right shift
		Op <= "1000";
		
		A <= "11000010000011100000000000011010";
		B <= "00000000000000000000000000000000";
		wait for 100 ns;
		
		-- checking LOGICAL right logical shift
		Op <= "1001";
		wait for 100 ns;
		
		-- checking LOGICAL left logical shift
		Op <= "1010";
		wait for 100 ns;
		
		-- checking ROTATE right logical shift
		Op <= "1100";
		wait for 100 ns;
		
		-- checking ROTATE left logical shift
		Op <= "1101";
		
		A <= "01100001000011100000000000011011";
		wait for 100 ns;
		
	wait;
	end process;

END;
