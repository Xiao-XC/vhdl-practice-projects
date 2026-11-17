library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu_tb is
end alu_tb;

architecture Behavioral of alu_tb is
component alu is
    Port(A : in std_logic_vector(31 downto 0);
         B : in std_logic_vector(31 downto 0);
         Shamt : in std_logic_vector(4 downto 0);
         ALUCntl : in std_logic_vector(3 downto 0);
         Carryin : in std_logic;
         Zero, Overflow, Carryout : out std_logic;
         ALUout : out std_logic_vector(31 downto 0));
end component alu;

signal A, B, ALUout : std_logic_vector(31 downto 0);
signal Shamt : std_logic_vector(4 downto 0);
signal ALUCntl : std_logic_vector(3 downto 0);
signal Carryin, Zero, Overflow, Carryout : std_logic;

begin
    dut: alu port map( --dut means Device Under Test
        A => A,
        B => B,
        Shamt => Shamt,
        ALUCntl => ALUCntl,
        Carryin => Carryin,
        Carryout => Carryout,
        Zero => Zero,
        Overflow => Overflow,
        ALUout => ALUout 
    );
    
    simulation: process
	begin
		-- in your testbench that you submit must have all the test vectors from Table 3 of the lab manual
		
		-- and test vector
		A <= x"FFFF0000";
		B <= x"0000FFFF";
		Carryin <= '0';
		Shamt <= "00000";
		ALUCntl <= "0000";
		wait for 20 ns;
		
		-- or test vector
		A <= x"FFFF0000";
		B <= x"0000FFFF";
		Carryin <= '0';
		Shamt <= "00000";
		ALUCntl <= "0001";
		wait for 20 ns;
		
		-- xor test vector
		A <= x"AAAAAAAA";
		B <= x"5555AAAA";
		Carryin <= '0';
		Shamt <= "00000";
		ALUCntl <= "0010";
		wait for 20 ns;
		
		-- nor test vector
		A <= x"AAAAAAAA";
		B <= x"5555555A";
		Carryin <= '0';
		Shamt <= "00000";
		ALUCntl <= "0011";
		wait for 20 ns;
		
		-- Add test vector
		A <= x"00000001";
		B <= x"00000000";
		Carryin <= '0';
		Shamt <= "00000";
		ALUCntl <= "0100";
		wait for 20 ns;
		
		-- Add test vector
		A <= x"00000001";
		B <= x"00000000";
		Carryin <= '1';
		Shamt <= "00000";
		ALUCntl <= "0100";
		wait for 20 ns;
		
		-- Add test vector
		A <= x"12345678";
		B <= x"12345678";
		Carryin <= '0';
		Shamt <= "00000";
		ALUCntl <= "0100";
		wait for 20 ns;
		
		-- Add test vector
		A <= x"12345678";
		B <= x"12345678";
		Carryin <= '1';
		Shamt <= "00000";
		ALUCntl <= "0100";
		wait for 20 ns;
		
		-- Add test vector
		A <= x"00000001";
		B <= x"FFFFFFFF";
		Carryin <= '0';
		Shamt <= "00000";
		ALUCntl <= "0100";
		wait for 20 ns;
		
		-- Add test vector
		A <= x"00000001";
		B <= x"FFFFFFFF";
		Carryin <= '1';
		Shamt <= "00000";
		ALUCntl <= "0100";
		wait for 20 ns;
		
		-- Add test vector
		A <= x"00000001";
		B <= x"7FFFFFFF";
		Carryin <= '1';
		Shamt <= "00000";
		ALUCntl <= "0100";
		wait for 20 ns;
		
		-- Add test vector
		A <= x"80000001";
		B <= x"80000000";
		Carryin <= '1';
		Shamt <= "00000";
		ALUCntl <= "0100";
		wait for 20 ns;
		
		-- sub test vector
		A <= x"00000000";
		B <= x"00000001";
		Carryin <= '0';
		Shamt <= "00000";
		ALUCntl <= "0101";
		wait for 20 ns;
		
		-- sub test vector
		A <= x"12345678";
		B <= x"12345678";
		Carryin <= '0';
		Shamt <= "00000";
		ALUCntl <= "0101";
		wait for 20 ns;
		
		-- sub test vector
		A <= x"12345678";
		B <= x"12345677";
		Carryin <= '0';
		Shamt <= "00000";
		ALUCntl <= "0101";
		wait for 20 ns;
		
		-- sub test vector
		A <= x"7FFFFFFF";
		B <= x"FFFFFFFF";
		Carryin <= '0';
		Shamt <= "00000";
		ALUCntl <= "0101";
		wait for 20 ns;
		
		-- SLL test vector
		A <= x"00000000";
		B <= x"0000FFFF";
		Carryin <= '0';
		Shamt <= "00100";
		ALUCntl <= "0110";
		wait for 20 ns;
		
		-- SRL test vector
		A <= x"00000000";
		B <= x"FFFF0000";
		Carryin <= '0';
		Shamt <= "00100";
		ALUCntl <= "0111";
		wait for 20 ns;
		
		-- SLT signed test vector
		A <= x"FFFFFFFF";
		B <= x"00000001";
		Carryin <= '0';
		Shamt <= "00000";
		ALUCntl <= "1000";
		wait for 20 ns;
		
		-- SLTU unsigned test vector
		A <= x"FFFFFFFF";
		B <= x"00000001";
		Carryin <= '0';
		Shamt <= "00000";
		ALUCntl <= "1001";
		wait for 20 ns;
		
		wait;
    end process;
end Behavioral;