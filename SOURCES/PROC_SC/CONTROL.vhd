----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:51:49 04/09/2022 
-- Design Name: 
-- Module Name:    CONTROL - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_signed.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CONTROL is

	port( Reset: in std_logic;
			Instr: in std_logic_vector(31 downto 0);
			ALU_overflow: in std_logic;
			ALU_zero: in std_logic;
			PC_Sel: out std_logic;
			PC_LdEn: out std_logic;
			Immext: out std_logic_vector(1 downto 0);
			RF_WrEn: out std_logic;
			RF_B_Sel: out std_logic;
			RF_WrData_sel: out std_logic;
			ALU_Bin_sel: out std_logic;
			ALU_func: out std_logic_vector(3 downto 0);
			ByteOp: out std_logic;
			MEM_WrEn: out std_logic);
			
end CONTROL;

architecture Behavioral of CONTROL is

begin
	
	process(Instr, ALU_overflow, ALU_zero)
	
begin
		
		if(Reset = '1') then
				PC_Sel <= '0'; 
				PC_LdEn <= '0'; 
				Immext <= "10"; -- don't care
				RF_WrEn <= '0'; 
				RF_B_Sel <= '0'; 
				RF_WrData_sel <= '0';  
				ALU_Bin_sel <= '0'; 	
				ALU_func <= "0000";
				ByteOp <= '0'; 
				MEM_WrEn <= '0';
		end if;
		
		case Instr(31 downto 26) is
			
			-- ALU operations
			when "100000" => 
				PC_Sel <= '0'; -- not a branch
				PC_LdEn <= '1'; 
				Immext <= "01"; -- don't care
				RF_WrEn <= '1'; 
				RF_B_Sel <= '0'; -- not immediate operation format
				RF_WrData_sel <= '0';  -- ALU_out
				ALU_Bin_sel <= '0'; 	-- RF_B
				ALU_func <= Instr(3 downto 0);
				ByteOp <= '0'; -- don't care
				MEM_WrEn <= '0';
			
			-- Immediate operations
			when "111000" | "110000" => -- li and addi
				PC_Sel <= '0'; -- not a branch
				PC_LdEn <= '1';
				ImmExt <= "10"; -- sign extend
				RF_WrEn <= '1'; 
				RF_B_Sel <= '0'; 
				RF_WrData_sel <= '0';  -- ALU_out
				ALU_Bin_sel <= '1'; 	-- immediate operation format
				ALU_func <= "0000"; -- add
				ByteOp <= '0'; -- don't care
				MEM_WrEn <= '0';
			
			when "111001" => -- lui
				PC_Sel <= '0'; -- not a branch
				PC_LdEn <= '1';
				ImmExt <= "01"; -- zero filling and 16 left shifts
				RF_WrEn <= '1'; 
				RF_B_Sel <= '0';
				RF_WrData_sel <= '0';  -- ALU_out
				ALU_Bin_sel <= '1'; 	-- immediate operation format
				ALU_func <= "0000"; --add
				ByteOp <= '0'; -- don't care
				MEM_WrEn <= '0';
			
			when "110010" => -- nandi
				PC_Sel <= '0'; -- not a branch
				PC_LdEn <= '1';
				ImmExt <= "00"; -- zero filling
				RF_WrEn <= '1'; 
				RF_B_Sel <= '0'; 
				RF_WrData_sel <= '0';  -- ALU_out
				ALU_Bin_sel <= '1'; 	-- immediate operation format
				ALU_func <= "0101"; -- nand
				ByteOp <= '0'; -- don't care
				MEM_WrEn <= '0';
			
			when "110011" => -- ori
				PC_Sel <= '0'; -- not a branch
				PC_LdEn <= '1';
				ImmExt <= "00"; -- zero filling
				RF_WrEn <= '1'; 
				RF_B_Sel <= '0'; 
				RF_WrData_sel <= '0';  -- ALU_out
				ALU_Bin_sel <= '1'; 	-- immediate operation format
				ALU_func <= "0011"; -- or
				ByteOp <= '0'; -- don't care
				MEM_WrEn <= '0';
			
			-- branch operations
			when "111111" => -- b
				PC_Sel <= '1'; -- branch
				PC_LdEn <= '1';
				ImmExt <= "10"; -- sign extend ONLY!!
				RF_WrEn <= '0'; -- no need to write in a branch
				RF_B_Sel <= '1'; 
				RF_WrData_sel <= '-'; -- don't care
				ALU_Bin_sel <= '1'; 	-- RF_B
				ALU_func <= "----"; -- sub
				ByteOp <= '0'; -- don't care
				MEM_WrEn <= '0';
			
			when "000000" => -- beq			
				PC_Sel <= ALU_zero; -- branch	equals			
				PC_LdEn <= '1';
				ImmExt <= "11"; -- sign extend and 2 left shifts
				RF_WrEn <= '0'; -- no need to write in a branch
				RF_B_Sel <= '1'; 
				RF_WrData_sel <= '-'; -- don't care
				ALU_Bin_sel <= '0'; 	-- RF_B
				ALU_func <= "0001"; -- sub
				ByteOp <= '0'; -- don't care
				MEM_WrEn <= '0';
			
			when "000001" => -- bne			
				PC_Sel <= not(ALU_zero); -- branch not equals				
				PC_LdEn <= '1';
				ImmExt <= "11"; -- sign extend and 2 left shifts
				RF_WrEn <= '0'; -- no need to write in a branch
				RF_B_Sel <= '1'; 
				RF_WrData_sel <= '0'; -- don't care
				ALU_Bin_sel <= '0'; 	-- RF_B
				ALU_func <= "0001"; -- sub
				ByteOp <= '0'; -- don't care
				MEM_WrEn <= '0';
			
			-- load operations
			when "000011" | "001111" => -- lb and lw
				PC_Sel <= '0'; -- not a branch
				PC_LdEn <= '1';
				ImmExt <= "10"; -- sign extend
				RF_WrEn <= '1'; 
				RF_B_Sel <= '0'; -- not immediate operation format
				RF_WrData_sel <= '1';  -- MEM_out
				ALU_Bin_sel <= '1'; 	-- Immediate
				ALU_func <= "0000"; -- add
				ByteOp <= not(Instr(28)); -- 1 for load byte, 0 for load word
				MEM_WrEn <= '0';
			
			-- store operations
			when "000111" | "011111" => -- sb and sw
				PC_Sel <= '0'; -- not a branch
				PC_LdEn <= '1';
				ImmExt <= "10"; -- sign extend
				RF_WrEn <= '0'; 
				RF_B_Sel <= '1'; -- not immediate operation format
				RF_WrData_sel <= '1';  -- MEM_out
				ALU_Bin_sel <= '1'; 	-- Immediate
				ALU_func <= "0000"; -- add
				ByteOp <= not(Instr(29)); -- 1 for store byte, 0 for store word
				MEM_WrEn <= '1';
			
			when others =>
				null;
				
		end case;
	
	end process;
	


end Behavioral;

