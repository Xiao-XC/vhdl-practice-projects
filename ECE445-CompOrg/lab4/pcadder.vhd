library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pcadder is
    port (CurrAddr : in std_logic_vector(31 downto 0); NextAddr : out std_logic_vector(31 downto 0));
end pcadder;
architecture rtl of pcadder is begin
    NextAddr <= std_logic_vector(unsigned(CurrAddr) + 4);
end rtl;
