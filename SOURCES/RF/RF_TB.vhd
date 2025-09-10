--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:18:36 04/06/2022
-- Design Name:   
-- Module Name:   C:/Users/Mike/Xilinx_projects/phase1/RF_TB.vhd
-- Project Name:  phase1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RF
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
 
ENTITY RF_TB IS
END RF_TB;
 
ARCHITECTURE behavior OF RF_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RF
    PORT(
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
         Clk : IN  std_logic;
         Rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Ard1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';

 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RF PORT MAP (
          Ard1 => Ard1,
          Ard2 => Ard2,
          Awr => Awr,
          Dout1 => Dout1,
          Dout2 => Dout2,
          Din => Din,
          WrEn => WrEn,
          Clk => Clk,
          Rst => Rst
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process 
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		Awr <= "00001";        
		Din <= x"00050007";
		WrEn <= '1';
		Rst <= '1';
      wait for 100 ns;	
		
		-- write into R1
		Awr <= "00001";        
		Din <= x"0b054a03";
		WrEn <= '1';
		Rst <= '0';
      wait for 100 ns;	
		
		-- write into R5
		Awr <= "00101";        
		Din <= x"0f01a217";
		WrEn <= '1';
		Rst <= '0';
      wait for 100 ns;	
		
		-- write into R19
		Awr <= "10011";        
		Din <= x"12b90c1f";
		WrEn <= '1';
		Rst <= '0';
      wait for 100 ns;	
		
		-- read from R1 and R5. checking if R5 will be overwritten when WrEn = 0
		Ard1 <= "00001";
		Ard2 <= "00101";
		Awr <= "00101";        
		Din <= x"016000a0";
		WrEn <= '0';
		Rst <= '0';
      wait for 100 ns;	
		
		-- read from R19 and R5. checking WrEn after being 0 by writing on R29
		Ard1 <= "10011";
		Ard2 <= "00101";
		Awr <= "11101";        
		Din <= x"0ffa96b0";
		WrEn <= '1';
		Rst <= '0';
      wait for 100 ns;	
		
		-- read from R19 and R29. checking writing on R0 
		Ard1 <= "10011";
		Ard2 <= "11101";
		Awr <= "00000";        
		Din <= x"00050021";
		WrEn <= '1';
		Rst <= '0';
      wait for 100 ns;	
		
		-- checking R0 value
		Ard1 <= "00000";
		Ard2 <= "11101";
		Awr <= "00000";        
		Din <= x"00050021";
		WrEn <= '0';
		Rst <= '0';
		wait for 100 ns;	
		
		-- Reset and checking if our regs are reseted
		Ard1 <= "00001";
		Ard2 <= "00101";
		Awr <= "00101";        
		Din <= x"011220f0";
		WrEn <= '0';
		Rst <= '1';
		wait for 100 ns;
		
      wait for Clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
