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
        x"24", x"08", x"00", x"01", -- 00: addiu $t0, $zero, 1
        x"24", x"09", x"00", x"00", -- 04: addiu $t1, $zero, 0
        x"24", x"0A", x"00", x"00", -- 08: addiu $t2, $zero, 0
        x"AD", x"48", x"00", x"00", -- 0C: sw $t0, 0($t2)
        x"25", x"4A", x"00", x"04", -- 10: addiu $t2, $t2, 4
        x"31", x"0B", x"00", x"01", -- 14: andi $t3, $t0, 1
        x"15", x"60", x"00", x"02", -- 18: bne $t3, $zero, ODD
        x"01", x"09", x"58", x"21", -- 1C: addu $t3, $t0, $t1
        x"10", x"00", x"00", x"01", -- 20: beq $zero, $zero, UPDATE
        x"00", x"08", x"58", x"40", -- 24: sll $t3, $t0, 1
        x"01", x"00", x"48", x"21", -- 28: addu $t1, $t0, $zero
        x"01", x"60", x"40", x"21", -- 2C: addu $t0, $t3, $zero
        x"10", x"00", x"FF", x"F6", -- 30: beq $zero, $zero, LOOP
        others => x"00");

begin
    
    inst_out(31 downto 24)  <= RAM(to_integer(unsigned(addr)));
    inst_out(23 downto 16)  <= RAM(to_integer(unsigned(addr)+1));
    inst_out(15 downto 8)   <= RAM(to_integer(unsigned(addr)+2));
    inst_out(7 downto 0)    <= RAM(to_integer(unsigned(addr)+3));

end Behavioral;
