--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:46:14 04/06/2022
-- Design Name:   
-- Module Name:   C:/Users/Mike/Xilinx_projects/phase1/REGISTR_TB.vhd
-- Project Name:  phase1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: REGISTR
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
 
ENTITY REGISTR_TB IS
END REGISTR_TB;
 
ARCHITECTURE behavior OF REGISTR_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT REGISTR
    PORT(
         DataInREG : IN  std_logic_vector(31 downto 0);
         CLK : IN  std_logic;
         RST : IN  std_logic;
         WE : IN  std_logic;
         DataOutREG : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DataInREG : std_logic_vector(31 downto 0) := (others => '0');
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal WE : std_logic := '0';

 	--Outputs
   signal DataOutREG : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: REGISTR PORT MAP (
          DataInREG => DataInREG,
          CLK => CLK,
          RST => RST,
          WE => WE,
          DataOutREG => DataOutREG
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	
      -- hold reset state for 100 ns.
		DataInREG <= x"00000000";
		RST <= '1';
		WE <= '0';
      wait for 100 ns;	
		
		-- checking writing
		DataInREG <= x"07009003";
		RST <= '0';
		WE <= '1';
      wait for 100 ns;	
		
		DataInREG <= x"5bc8e0f3";
		RST <= '0';
		WE <= '1';
      wait for 100 ns;	
		
		-- checking we = 0
		DataInREG <= x"10000083";
		RST <= '0';
		WE <= '0';
      wait for 100 ns;	
		
		-- checking reset
		DataInREG <= x"f07090a1";
		RST <= '1';
		WE <= '1';
      wait for 100 ns;	
		
		-- checking writing after reset
		DataInREG <= x"42b10d10";
		RST <= '0';
		WE <= '1';
      wait for 100 ns;	
		
      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
