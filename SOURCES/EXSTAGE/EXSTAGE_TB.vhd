--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:48:15 04/07/2022
-- Design Name:   
-- Module Name:   C:/Users/Mike/Xilinx_projects/phase1/EXSTAGE_TB.vhd
-- Project Name:  phase1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: EXSTAGE
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
USE ieee.numeric_std.ALL;
use ieee.std_logic_signed.all;

ENTITY EXSTAGE_TB IS
END EXSTAGE_TB;
 
ARCHITECTURE behavior OF EXSTAGE_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EXSTAGE
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0);
         ALU_zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_out : std_logic_vector(31 downto 0);
   signal ALU_zero : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: EXSTAGE PORT MAP (
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_out => ALU_out,
          ALU_zero => ALU_zero
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      
		RF_A <= x"00000000";
		RF_B <= x"00000000";
		Immed<= x"00000000";
		ALU_Bin_sel <= '1'; -- Immed
		ALU_func <= "0000";
      wait for 100 ns;	
		
		for i in 1 to 6 loop 
			RF_A <= RF_A + x"00000004";
			RF_B <= RF_B + x"00000002";
			Immed<= Immed + x"00000003";
			ALU_func <= ALU_func + "0001";
			wait for 100 ns;	
		end loop;
		
		RF_A <= x"1fe605a4";
		RF_B <= x"f0b918d3";
		Immed<= x"00407012";
		ALU_Bin_sel <= '0'; -- RF_B
		ALU_func <= "1000";
		wait for 100 ns;	
		
		for i in 1 to 5 loop 
			RF_A <= RF_A + x"00000004";
			RF_B <= RF_B + x"00000002";
			Immed<= Immed + x"00000003";
			ALU_func <= ALU_func + "0001";
			wait for 100 ns;	
		end loop;
		
		-- cheching cout
		RF_A <= x"d00ff00f";
		Immed<= x"f0e01350";
		ALU_Bin_sel <= '1'; -- Immed
		ALU_func <= "0000";
		wait for 100 ns;	
		
		--checking zero
		RF_A <= x"1fe605a4";
		RF_B <= x"1fe605a4";
		ALU_Bin_sel <= '0'; -- RF_B
		ALU_func <= "0001";
		wait for 100 ns;	
		
		-- checking overflow
		RF_A <= x"7fffffff";
		Immed<= x"fffffffe";
		ALU_Bin_sel <= '1'; -- Immed
		wait for 100 ns;
		
      -- insert stimulus here 

      wait;
   end process;

END;
