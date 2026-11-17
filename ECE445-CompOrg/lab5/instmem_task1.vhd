library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;

entity InstMem is
    Port ( addr : in  STD_LOGIC_VECTOR (31 downto 0);
           inst_out : out  STD_LOGIC_VECTOR (31 downto 0));
end InstMem;

architecture Behavioral of InstMem is

type Instruction_Memory is array (0 to 255) of std_logic_vector (7 downto 0);
    signal RAM: Instruction_Memory := (
            x"8c",x"08",x"00",x"00",-- 0X00         lw $t0, 0($zero) 
            x"8c",x"09",x"00",x"04",-- 0X04         lw $t1, 4($zero) 
            x"8c",x"0a",x"00",x"08",-- 0X08         lw $t2, 8($zero) 
            x"8c",x"0b",x"00",x"0c",-- 0X0C         lw $t3, 12($zero) 
            x"8c",x"0c",x"00",x"10",-- 0X10         lw $t4, 16($zero) 
            x"8c",x"0d",x"00",x"14",-- 0X14         lw $t5, 20($zero) 
            x"21",x"08",x"00",x"01",-- 0X18  insts: addi $t0, $t0, 1 
            x"31",x"29",x"00",x"00",-- 0X1C         andi $t1, $t1, 0 
            x"35",x"4a",x"00",x"07",-- 0X20         ori $t2, $t2, 7 
            x"29",x"6b",x"00",x"09",-- 0X24         slti $t3, $t3, 9 
            x"2d",x"8c",x"00",x"00",-- 0X28         sltiu $t4, $t4, 0 
            x"01",x"a8",x"68",x"22",-- 0X2C         sub $t5, $t5, $t0 
            x"11",x"a0",x"00",x"01",-- 0X30         beq  $t5, $zero, store
            x"15",x"a0",x"ff",x"f8",-- 0X34         bne  $t5, $zero, insts
            x"ac",x"08",x"00",x"00",-- 0X38  store: sw $t0, 0($zero) 
            x"ac",x"09",x"00",x"04",-- 0X3C         sw $t1, 4($zero) 
            x"ac",x"0a",x"00",x"08",-- 0X40         sw $t2, 8($zero) 
            x"ac",x"0b",x"00",x"0c",-- 0X44         sw $t3, 12($zero) 
            x"ac",x"0c",x"00",x"10",-- 0x48         sw $t4, 16($zero) 
            x"ac",x"0d",x"00",x"14",-- 0x4C         sw $t5, 20($zero)
            others => x"00");

begin
    
    inst_out(31 downto 24)  <= RAM(to_integer(unsigned(addr)));
    inst_out(23 downto 16)  <= RAM(to_integer(unsigned(addr)+1));
    inst_out(15 downto 8)   <= RAM(to_integer(unsigned(addr)+2));
    inst_out(7 downto 0)    <= RAM(to_integer(unsigned(addr)+3));

end Behavioral;
