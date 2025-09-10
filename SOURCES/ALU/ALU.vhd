library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity ALU is
	port(	A: in std_logic_vector(31 downto 0);
			B: in std_logic_vector(31 downto 0);
			Op: in std_logic_vector(3 downto 0);
			Out1: out std_logic_vector(31 downto 0);
			Zero: out std_logic;
			Cout: out std_logic;
			Ovf: out std_logic);
end ALU;

architecture Behavioral of ALU is
	-- signals for the outputs
	signal Out1_sig: std_logic_vector(31 downto 0);
	signal Zero_sig: std_logic;
	signal Cout_sig: std_logic_vector(32 downto 0);
	signal Ovf_sig: std_logic;

begin
	process(A, B, Op, Out1_sig, Zero_sig, Cout_sig, Ovf_sig)

begin
		-- initialization
		Zero_sig <= '0';
		Cout_sig <= "000000000000000000000000000000000";
		Ovf_sig <= '0';	
	case Op is
				
		when "0000" => -- add
			Out1_sig <= A + B;
			Cout_sig <= ('0' & A) + ('0' & B);
			
		when "0001" => -- sub
			Out1_sig <= A - B;
			
		when "0010" => -- and
			Out1_sig <= A and B;
			
		when "0011" => -- or
			Out1_sig <= A or B;
			
		when "0100" => -- not
			Out1_sig <= not A;
			
		when "0101" => -- nand
			Out1_sig <= not(A and B);
			
		when "0110" => -- nor
			Out1_sig <= not(A or B);
			
		when "1000" => -- sra
			Out1_sig <= A(31) & A(31 downto 1);
			
		when "1001" => -- srl
			Out1_sig <= '0' & A(31 downto 1);
			
		when "1010" => -- sll
			Out1_sig <= A(30 downto 0) & '0'; 
			
		when "1100" => -- rol
			Out1_sig <= A(30 downto 0) & A(31);
			
		when "1101" => -- ror
			Out1_sig <= A(0) & A(31 downto 1);
			
		when others =>
			null;
			
	end case;

-- overflow
	if( (Op = "0000") AND ((A(31) = B(31)) AND ( Out1_sig(31) = not( B(31) ) ) ) ) then
		Ovf_sig <= '1';
		
	elsif( (Op = "0001") AND ((A(31) = not(B(31)) ) AND (Out1_sig(31) = B(31))) ) then
		Ovf_sig <= '1';
		
	else
		Ovf_sig <= '0';
	end if;

-- zero
	if(Out1_sig = "00000000000000000000000000000000") then
		Zero_sig <= '1';
	else
		Zero_sig <= '0';
	end if;

-- outputs
	Out1 <= Out1_sig after 10 ns;
	Zero <= Zero_sig after 10 ns;
	Cout <= Cout_sig(32) after 10 ns;
	Ovf  <= Ovf_sig  after 10 ns;

	end process;

end Behavioral;