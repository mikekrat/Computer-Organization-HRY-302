--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:32:34 04/11/2022
-- Design Name:   
-- Module Name:   C:/Users/Mike/Xilinx_projects/phase1/CONTROL_TB.vhd
-- Project Name:  phase1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CONTROL
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
 
ENTITY CONTROL_TB IS
END CONTROL_TB;
 
ARCHITECTURE behavior OF CONTROL_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONTROL
    PORT(
         Reset : IN std_logic;
			Instr : IN  std_logic_vector(31 downto 0);
         ALU_overflow : IN  std_logic;
         ALU_zero : IN  std_logic;
         PC_Sel : OUT  std_logic;
         PC_LdEn : OUT  std_logic;
         Immext : OUT  std_logic_vector(1 downto 0);
         RF_WrEn : OUT  std_logic;
         RF_B_Sel : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic;
         ALU_Bin_sel : OUT  std_logic;
         ALU_func : OUT  std_logic_vector(3 downto 0);
         ByteOp : OUT  std_logic;
         MEM_WrEn : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
	signal Reset : std_logic;
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_overflow : std_logic := '0';
   signal ALU_zero : std_logic := '0';

 	--Outputs
   signal PC_Sel : std_logic;
   signal PC_LdEn : std_logic;
   signal Immext : std_logic_vector(1 downto 0);
   signal RF_WrEn : std_logic;
   signal RF_B_Sel : std_logic;
   signal RF_WrData_sel : std_logic;
   signal ALU_Bin_sel : std_logic;
   signal ALU_func : std_logic_vector(3 downto 0);
   signal ByteOp : std_logic;
   signal MEM_WrEn : std_logic;
   
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CONTROL PORT MAP (
			 Reset => Reset,
          Instr => Instr,
          ALU_overflow => ALU_overflow,
          ALU_zero => ALU_zero,
          PC_Sel => PC_Sel,
          PC_LdEn => PC_LdEn,
          Immext => Immext,
          RF_WrEn => RF_WrEn,
          RF_B_Sel => RF_B_Sel,
          RF_WrData_sel => RF_WrData_sel,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ByteOp => ByteOp,
          MEM_WrEn => MEM_WrEn
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
		
		Reset <= '1';
		wait for 100 ns;	
		
      Reset <= '0';
		ALU_overflow <= '0';
		ALU_zero <= '0';
		
		Instr <= "100000" & "00000" & "00110" & "00000" & "00000"& "110000"; -- add
      wait for 100 ns;	
		
		Instr <= "100000" & "00010" & "00110" & "00000" & "00000"& "110001"; -- sub
      wait for 100 ns;	
      
		Instr <= "100000" & "00000" & "00111" & "00000" & "00000"& "110010"; -- and
      wait for 100 ns;
		
		Instr <= "100000" & "00011" & "00111" & "00000" & "00000"& "110011"; -- or
      wait for 100 ns;	
		
		Instr <= "100000" & "00011" & "00111" & "00000" & "00000"& "110100"; -- not
      wait for 100 ns;	
		
		Instr <= "100000" & "00011" & "00111" & "00000" & "00000"& "110101"; -- nand
      wait for 100 ns;
		
		Instr <= "100000" & "00011" & "00111" & "00000" & "00000"& "110110"; -- nor
      wait for 100 ns;
		
		Instr <= "100000" & "00011" & "00111" & "00000" & "00000"& "111000"; -- sra
      wait for 100 ns;
		
		Instr <= "100000" & "00011" & "00111" & "00000" & "00000"& "111001"; -- srl
      wait for 100 ns;
		
		Instr <= "100000" & "00011" & "00111" & "00000" & "00000"& "111010"; -- sll
      wait for 100 ns;
		
		Instr <= "100000" & "00011" & "00111" & "00000" & "00000"& "111100"; -- rol
      wait for 100 ns;
		
		Instr <= "100000" & "00011" & "00111" & "00000" & "00000"& "111100"; -- ror
      wait for 100 ns;
		
		Instr <= "111000" & "00000" & "01000" & "0000000000001001"; -- li
      wait for 100 ns;
		
		Instr <= "111001" & "00000" & "01000" & "0000000000001001"; -- lui
      wait for 100 ns;
		
		Instr <= "110000" & "00000" & "01000" & "0000000000001001"; -- addi
      wait for 100 ns;
		
		Instr <= "110010" & "00000" & "01000" & "0000000000001001"; -- nandi
      wait for 100 ns;
		
		Instr <= "110011" & "00000" & "01000" & "0000000000001001"; -- ori
      wait for 100 ns;
		
		Instr <= "111111" & "00000" & "01000" & "0000000000000100"; -- b
      wait for 100 ns;
		
		ALU_zero <= '1';
		
		Instr <= "000000" & "01000" & "01000" & "0000000000000100"; -- beq if true
      wait for 100 ns;
		
		ALU_zero <= '0';
		
		Instr <= "000000" & "00010" & "01000" & "0000000000000100"; -- beq if false
      wait for 100 ns;
		
		Instr <= "000001" & "00110" & "01000" & "0000000000000100"; -- bne
      wait for 100 ns;
		
		Instr <= "000011" & "00110" & "01000" & "0000000000000100"; -- lb
      wait for 100 ns;
		
		Instr <= "000111" & "00110" & "01000" & "0000000000000100"; -- sb
      wait for 100 ns;
		
		Instr <= "001111" & "00110" & "01000" & "0110000000000100"; -- lw
      wait for 100 ns;
		
		Instr <= "011111" & "00110" & "01000" & "0110000000000100"; -- sw
      wait for 100 ns;
      -- insert stimulus here 

      wait;
   end process;

END;
