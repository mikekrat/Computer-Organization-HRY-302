--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:21:31 04/09/2022
-- Design Name:   
-- Module Name:   C:/Users/Mike/Xilinx_projects/phase1/DATAPATH_TB.vhd
-- Project Name:  phase1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DATAPATH
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
 
ENTITY DATAPATH_TB IS
END DATAPATH_TB;
 
ARCHITECTURE behavior OF DATAPATH_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DATAPATH
    PORT(
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         PC_Sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         PC : OUT  std_logic_vector(31 downto 0);
         Immext : IN  std_logic_vector(1 downto 0);
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         RF_B_Sel : IN  std_logic;
         RF_WrData_sel : IN  std_logic;
         ALU_Bin_Sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_zero : OUT  std_logic;
         ALU_overflow : OUT  std_logic;
         ByteOp : IN  std_logic;
         MEM_WrEn : IN  std_logic;
         MM_WrEn : OUT  std_logic;
         MM_Addr : OUT  std_logic_vector(31 downto 0);
         MM_WrData : OUT  std_logic_vector(31 downto 0);
         MM_RdData : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    
	 COMPONENT RAM is

	 port (
	 
		 clk : IN std_logic;
		 inst_addr : IN std_logic_vector(10 downto 0);
		 inst_dout : OUT std_logic_vector(31 downto 0);
		 data_we : IN std_logic;
		 data_addr : IN std_logic_vector(10 downto 0);
		 data_din : IN std_logic_vector(31 downto 0);
		 data_dout : OUT std_logic_vector(31 downto 0));

	 end COMPONENT;

   --Inputs
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';
   signal PC_Sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Immext : std_logic_vector(1 downto 0) := (others => '0');
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal RF_B_Sel : std_logic := '0';
   signal RF_WrData_sel : std_logic := '0';
   signal ALU_Bin_Sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');
   signal ByteOp : std_logic := '0';
   signal MEM_WrEn : std_logic := '0';
   signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal PC : std_logic_vector(31 downto 0);
   signal ALU_zero : std_logic;
   signal ALU_overflow : std_logic;
   signal MM_WrEn : std_logic;
   signal MM_Addr : std_logic_vector(31 downto 0);
   signal MM_WrData : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DATAPATH PORT MAP (
          Reset => Reset,
          Clk => Clk,
          PC_Sel => PC_Sel,
          PC_LdEn => PC_LdEn,
          PC => PC,
          Immext => Immext,
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          RF_B_Sel => RF_B_Sel,
          RF_WrData_sel => RF_WrData_sel,
          ALU_Bin_Sel => ALU_Bin_Sel,
          ALU_func => ALU_func,
          ALU_zero => ALU_zero,
          ALU_overflow => ALU_overflow,
          ByteOp => ByteOp,
          MEM_WrEn => MEM_WrEn,
          MM_WrEn => MM_WrEn,
          MM_Addr => MM_Addr,
          MM_WrData => MM_WrData,
          MM_RdData => MM_RdData
        );
	
	RAM_Memory:
			RAM port map( clk => Clk,
							  inst_addr => PC(12 downto 2),
							  inst_dout => Instr,
							  data_we => MM_WrEn,
							  data_addr => MM_Addr(12 downto 2),
							  data_din => MM_WrData,
							  data_dout => MM_RdData);

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
		Reset <= '1';
      wait for 100 ns;	
		
		-- li r6,9
		Reset <= '0';
      PC_Sel <= '0'; -- not a branch
		PC_LdEn <= '1'; 
		Immext <= "10";	-- sign extend
		RF_WrEn <= '1'; -- loading needs enabled write
		RF_B_Sel <= '1'; -- immediate operation format
		RF_WrData_sel <= '0';  -- ALU_out
		ALU_Bin_sel <= '1'; 	-- immediate operation format
		ALU_func <= "0000"; -- adding with r0 is li
		ByteOp <= '-'; -- don't care
		MEM_WrEn <= '0';
		wait for Clk_period;
		
		-- ori r9,r0,8f02
		PC_Sel <= '0'; -- not a branch
		PC_LdEn <= '1'; 
		Immext <= "00"; -- zero filling
		RF_WrEn <= '1'; -- loading needs enabled write
		RF_B_Sel <= '1'; -- immediate operation format
		RF_WrData_sel <= '0';  -- ALU_out
		ALU_Bin_sel <= '1'; 	-- immediate operation format
		ALU_func <= "0011"; -- or
		ByteOp <= '-'; -- don't care
		MEM_WrEn <= '0';
      wait for Clk_period;
		
		-- sw r9,4(ro)
		PC_Sel <= '0'; -- not a branch
		PC_LdEn <= '1'; 
		Immext <= "10";
		RF_WrEn <= '0'; 
		RF_B_Sel <= '1'; -- immediate operation format
		RF_WrData_sel <= '1';  -- MEM_out don't care
		ALU_Bin_sel <= '1'; 	-- immediate operation format
		ALU_func <= "0000"; -- add
		ByteOp <= '0'; 
		MEM_WrEn <= '1';
      wait for Clk_period;
      -- insert stimulus here 
		
		-- lw r15, -4(r6)
		PC_Sel <= '0'; -- not a branch
		PC_LdEn <= '1'; 
		Immext <= "10";
		RF_WrEn <= '1'; -- loading
		RF_B_Sel <= '1'; -- immediate operation format
		RF_WrData_sel <= '1';  -- MEM_out don't care
		ALU_Bin_sel <= '1'; 	-- immediate operation format
		ALU_func <= "0000"; -- add
		ByteOp <= '0'; 
		MEM_WrEn <= '0';
      wait for Clk_period;
		
		-- lb r21, 4(r0)
		PC_Sel <= '0'; -- not a branch
		PC_LdEn <= '1'; 
		Immext <= "10";
		RF_WrEn <= '1'; -- loading
		RF_B_Sel <= '1'; -- immediate operation format
		RF_WrData_sel <= '1';  -- MEM_out don't care
		ALU_Bin_sel <= '1'; 	-- immediate operation format
		ALU_func <= "0000"; -- add
		ByteOp <= '1'; 
		MEM_WrEn <= '0';
		
		-- nand r7,r0,r21
		PC_Sel <= '0'; -- not a branch
		PC_LdEn <= '1'; 
		Immext <= "--";
		RF_WrEn <= '1'; -- loading
		RF_B_Sel <= '0'; -- not immediate operation format
		RF_WrData_sel <= '0';  -- ALU_out
		ALU_Bin_sel <= '0'; 	-- RF_B
		ALU_func <= "0101"; -- nand
		ByteOp <= '-'; 
		MEM_WrEn <= '0';
		
     wait;
   end process;

END;
