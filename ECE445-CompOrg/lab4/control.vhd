library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control is
    port (Opcode : in std_logic_vector(5 downto 0); RegWrite : out std_logic);
end control;
architecture rtl of control is begin
    RegWrite <= '1' when Opcode = "000000" else '0';
end rtl;
