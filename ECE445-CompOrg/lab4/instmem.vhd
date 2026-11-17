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
type Instruction_Memory is array (0 to 255) of std_logic_vector(7 downto 0);
    signal RAM : Instruction_Memory := (
        x"01", x"28", x"10", x"22", 
        x"00", x"02", x"18", x"40", 
        x"00", x"62", x"20", x"20", 
        x"00", x"04", x"28", x"40", 
        x"00", x"A4", x"30", x"20", 
        x"00", x"06", x"38", x"40", 
        x"00", x"E6", x"80", x"20", 
        x"00", x"10", x"88", x"40", 
        x"02", x"30", x"90", x"20",
        others => x"00"
    );
begin
    inst_out(7 downto 0) <= RAM(to_integer(unsigned(addr)) + 3);
    inst_out(15 downto 8) <= RAM(to_integer(unsigned(addr)) + 2);
    inst_out(23 downto 16) <= RAM(to_integer(unsigned(addr)) + 1);
    inst_out(31 downto 24) <= RAM(to_integer(unsigned(addr)));
end Behavioral;
