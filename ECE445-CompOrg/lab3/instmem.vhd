library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstMem is
    Port (
        addr     : in  STD_LOGIC_VECTOR(31 downto 0);
        inst_out : out STD_LOGIC_VECTOR(31 downto 0)
    );
end InstMem;

architecture Behavioral of InstMem is

    type Instruction_Memory is array (0 to 255)
        of std_logic_vector(7 downto 0);

    signal RAM : Instruction_Memory := (

        x"01", x"2A", x"40", x"20", -- 0x00: add  $t0, $t1, $t2
        x"01", x"4B", x"48", x"21", -- 0x04: addu $t1, $t2, $t3
        x"01", x"6C", x"50", x"24", -- 0x08: and  $t2, $t3, $t4
        x"01", x"8D", x"58", x"27", -- 0x0C: nor  $t3, $t4, $t5

        x"01", x"AE", x"60", x"25", -- 0x10: or   $t4, $t5, $t6
        x"01", x"CF", x"68", x"26", -- 0x14: xor  $t5, $t6, $t7
        x"02", x"32", x"80", x"22", -- 0x18: sub  $s0, $s1, $s2
        x"02", x"53", x"88", x"23", -- 0x1C: subu $s1, $s2, $s3

        x"02", x"74", x"90", x"2A", -- 0x20: slt  $s2, $s3, $s4
        x"02", x"95", x"98", x"2B", -- 0x24: sltu $s3, $s4, $s5
        x"00", x"15", x"A2", x"80", -- 0x28: sll  $s4, $s5, 10
        x"00", x"16", x"AA", x"82", -- 0x2C: srl  $s5, $s6, 10
        x"00",x"00",x"00",x"00",-- 0X04: (empty location)
        x"00",x"00",x"00",x"00",-- 0X08: (empty location)
        x"00",x"00",x"00",x"00",-- 0X0C: (empty location)
        x"00",x"00",x"00",x"00",-- 0X10: (empty location)
        x"00",x"00",x"00",x"00",-- 0X14: (empty location)
        x"00",x"00",x"00",x"00",-- 0X18: (empty location)
        x"00",x"00",x"00",x"00",-- 0X1C: (empty location)
        x"00",x"00",x"00",x"00",-- 0X20: (empty location)
        x"00",x"00",x"00",x"00",-- 0X24: (empty location)
        x"00",x"00",x"00",x"00",-- 0X28: (empty location) 
        x"00",x"00",x"00",x"00",-- 0X2C: (empty location) 
        x"00",x"00",x"00",x"00",-- 0X30: (empty location)
        x"00",x"00",x"00",x"00",-- 0X34: (empty location)
        x"00",x"00",x"00",x"00",-- 0X38: (empty location) 
        x"00",x"00",x"00",x"00",-- 0X3C: (empty location) 
        x"00",x"00",x"00",x"00",-- 0X40: (empty location) 
        x"00",x"00",x"00",x"00",-- 0X44: (empty location) 
        x"00",x"00",x"00",x"00",-- 0X48: (empty location) 
        x"00",x"00",x"00",x"00",-- 0X4C: (empty location)
        x"00",x"00",x"00",x"00",-- 0x50: (empty location)
        x"00",x"00",x"00",x"00",-- 0x54: (empty location)
        x"00",x"00",x"00",x"00",-- 0x58: (empty location)
        x"00",x"00",x"00",x"00",-- 0x5C: (empty location)
        x"00",x"00",x"00",x"00",-- 0x60: (empty location)
        x"00",x"00",x"00",x"00",-- 0x64: (empty location)
        x"00",x"00",x"00",x"00",-- 0x68: (empty location)
        x"00",x"00",x"00",x"00",-- 0x6C: (empty location)
        x"00",x"00",x"00",x"00",-- 0x70: (empty location)
        x"00",x"00",x"00",x"00",-- 0x74: (empty location)
        x"00",x"00",x"00",x"00",-- 0x78: (empty location)
        x"00",x"00",x"00",x"00",-- 0x7C: (empty location)
        x"00",x"00",x"00",x"00",-- 0x80: (empty location)
        x"00",x"00",x"00",x"00",-- 0x84: (empty location)
        x"00",x"00",x"00",x"00",-- 0x88: (empty location)
        x"00",x"00",x"00",x"00",-- 0x8C: (empty location)
        x"00",x"00",x"00",x"00",-- 0x90: (empty location)
        x"00",x"00",x"00",x"00",-- 0x94: (empty location)
        x"00",x"00",x"00",x"00",-- 0x98: (empty location)
        x"00",x"00",x"00",x"00",-- 0x9C: (empty location)
        x"00",x"00",x"00",x"00",-- 0xA0: (empty location)
        x"00",x"00",x"00",x"00",-- 0xA4: (empty location)
        x"00",x"00",x"00",x"00",-- 0xA8: (empty location)
        x"00",x"00",x"00",x"00",-- 0xAC: (empty location)
        x"00",x"00",x"00",x"00",-- 0xB0: (empty location)
        x"00",x"00",x"00",x"00",-- 0xB4: (empty location)
        x"00",x"00",x"00",x"00",-- 0xB8: (empty location)
        x"00",x"00",x"00",x"00",-- 0xBC: (empty location)
        x"00",x"00",x"00",x"00",-- 0xC0: (empty location)
        x"00",x"00",x"00",x"00",-- 0xC4: (empty location)
        x"00",x"00",x"00",x"00",-- 0xC8: (empty location)
        x"00",x"00",x"00",x"00",-- 0xCC: (empty location)
        x"00",x"00",x"00",x"00",-- 0xD0: (empty location)
        x"00",x"00",x"00",x"00",-- 0xD4: (empty location)
        x"00",x"00",x"00",x"00",-- 0xD8: (empty location)
        x"00",x"00",x"00",x"00",-- 0xDC: (empty location)
        x"00",x"00",x"00",x"00",-- 0xE0: (empty location)
        x"00",x"00",x"00",x"00",-- 0xE4: (empty location)
        x"00",x"00",x"00",x"00",-- 0xE8: (empty location)
        x"00",x"00",x"00",x"00",-- 0xEC: (empty location)
        x"00",x"00",x"00",x"00",-- 0xF0: (empty location)
        x"00",x"00",x"00",x"00",-- 0xF4: (empty location)
        x"00",x"00",x"00",x"00",-- 0xF8: (empty location)
        x"00",x"00",x"00",x"00" -- 0xFF: (empty location)
    );

begin

    inst_out(7 downto 0) <=
        RAM(to_integer(unsigned(addr)) + 3);

    inst_out(15 downto 8) <=
        RAM(to_integer(unsigned(addr)) + 2);

    inst_out(23 downto 16) <=
        RAM(to_integer(unsigned(addr)) + 1);

    inst_out(31 downto 24) <=
        RAM(to_integer(unsigned(addr)));

end Behavioral;